// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using Infinitra.Objects;
using InfinitraCore.Components;
using InfinitraCore.Objects;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.InputSystem;

namespace Infinitra.Movement
{

    public class Movement : MonoBehaviour, IMovement
    {
        public Vector3 velocity = Vector3.zero;
        private IModelConfig modelConfig;
        private CharacterController charaController; 

        private GoUserXr goUserXr;
        private XROrigin xrOrigin;
        private Camera camera;
        
        private bool lockMovement = true;
        private bool lockRotation = true;
        private bool lockTurn = true;
        private bool originFollowHeadMovement = true;
        private bool horizontalRotation = false;
        private bool mouseInvert = false;
        private float mouseRotateFactor = 1f;
        
        private bool jumpTrigger;
        private Vector2 movementInput;
        private Vector3 playerPosLast;
        private Vector3 hmdOffsetLast;

        private GameObject lastSelected;

        private bool isCrouching = false;

        private float crouchTimeElapsed;
        private float crouchHeightStart;

        public void Awake()
        {
            xrOrigin = GetComponent<XROrigin>();
            GameObject cameraOffset = AssetTools.getChildGameObject(gameObject, "Camera Offset");
            camera = GetComponentInChildren<Camera>();
            goUserXr = new GoUserXr(xrOrigin.gameObject, cameraOffset, this);
        }
        
        public void OnEnable()
        {

            CompLoader.regMovementScript(this);
            CompLoader.getUserController().registerGoUserXr(goUserXr);
        }

        private void processMove()
        { 

            var playerPos = charaController.transform.position;

            var moveAccelFactor = 1.0f;
            if (!goUserXr.collDown)
                // Don't accelerate fast while flying
                moveAccelFactor = 0.2f;

            // Calculate intended horizontal movement
            var accelInputVec = new Vector3(this.movementInput.x, 0, this.movementInput.y);
            var cameraYaw = Quaternion.Euler(0, xrOrigin.Camera.transform.eulerAngles.y, 0);
            var accelInputRotated = cameraYaw * accelInputVec;

            // Calculate intended vertical movement
            if (jumpTrigger)
            {
                if (modelConfig.jetPack) accelInputRotated.y = 1.0f;
                else if (goUserXr.collDown)
                {
                    velocity.y += modelConfig.jumpSpeed; // TODO jumping should be more sophisticated
                    jumpTrigger = false;
                }
            }

            // Only accelerate if the speed is within the limits
            var maxMoveSpeedXZ = goUserXr.collDown ? modelConfig.moveSpeedWalking : modelConfig.moveSpeedFlying;
            var moveAcceleration = goUserXr.collDown ? modelConfig.moveAccelerationWalking : modelConfig.moveAccelerationFlying;

            bool allowXZ = false;

            Vector3 moveXZ = new(velocity.x, 0f, velocity.z);
            Vector3 inputXZ = new(accelInputRotated.x, 0f, accelInputRotated.z);
            if (moveXZ.magnitude < maxMoveSpeedXZ) allowXZ = true;
            else
            {
                // Check if the input direction is roughly the opposite of the movement direction
                float dotProduct = Vector3.Dot(moveXZ.normalized, inputXZ.normalized);
                if (dotProduct < 0.0f) allowXZ = true;
            }
            
            if (allowXZ)
            {
                velocity.x += accelInputRotated.x * Time.deltaTime * moveAcceleration * moveAccelFactor;
                velocity.z += accelInputRotated.z * Time.deltaTime * moveAcceleration * moveAccelFactor;
            }

            // Jetpack
            if (modelConfig.jetPack && velocity.y < maxMoveSpeedXZ)
                velocity.y += accelInputRotated.y * Time.deltaTime * moveAcceleration;

            // Gravity acceleration
            if (velocity.y > modelConfig.fallSpeed) velocity.y += Time.deltaTime * modelConfig.gravityAccel;

            // Movement restrictions
            if (goUserXr.collDown)
            {
                // Restrict downward movement due to ground
                if (velocity.y < 0.0) velocity.y = -velocity.y * 0.25f;
            }
            else
            {
                // Collision while moving up
                if (goUserXr.collUp && velocity.y > 0.0) velocity.y = 0.0f;
            }

            // Calculate movement friction/decay
            float frictionFactor = goUserXr.collDown ? 1.0f : 0.05f;
            var frictionVector = velocity;
            if (goUserXr.collDown)
            {
                // Apply ground friction only to the normal component of the movement vector
                if (!accelInputRotated.Equals(Vector3.zero))
                    frictionVector *= Vector3.Cross(velocity, accelInputRotated.normalized).magnitude /
                                      velocity.magnitude;
            }

            velocity.x -= frictionVector.x * Time.deltaTime * modelConfig.friction * frictionFactor;
            velocity.z -= frictionVector.z * Time.deltaTime * modelConfig.friction * frictionFactor;
            velocity.y -= frictionVector.y * Time.deltaTime * modelConfig.friction * frictionFactor;

            // Update final velocity / position
            goUserXr.Move(velocity, Time.deltaTime);
            
            var playerVel = (playerPos - playerPosLast) / Time.deltaTime;
            playerPosLast = playerPos;
        }
        
        private void processRotation(InputAction.CallbackContext context)
        {
            Vector2 input = context.ReadValue<Vector2>();
            
            Vector3 currentRotation = goUserXr.goRotation.eulerAngles;
            Vector3 newRotation = goUserXr.goRotation.eulerAngles;
                        
            float rotYaw = input.x * modelConfig.rotationSensitivity * mouseRotateFactor;
            newRotation.y += rotYaw;

            if (!horizontalRotation)
            {
                float rotPitch = -input.y * modelConfig.rotationSensitivity;
                if (mouseInvert) rotPitch = -rotPitch;
                float testRotPitch = currentRotation.x + rotPitch;
                float testRotPitchAbs = Mathf.Abs(testRotPitch);
                if (Mathf.Abs(testRotPitch) > 275f || testRotPitchAbs < 85f) newRotation.x = testRotPitch;
            }

            goUserXr.goRotation = Quaternion.Euler(newRotation);
        }

        /*
         * The position of the XrOrigin GameObject shall be on the bottom of the character controller.
         * The camera shall be offsetted at a height of 'cameraHeightFactor'. 
         */
        private Vector3 calculateOffsets()
        {
            // The camera position (relative to the root of the character controller) shall be set via the cameraOffset GameObject
            goUserXr.camOffset = Vector3.up * (charaController.height * modelConfig.cameraHeightFactor);
            charaController.center = Vector3.up * (charaController.height * 0.5f);
            
            Vector3 hmdOffset = camera.transform.localPosition;
            Vector3 movedSinceLastUpdate = hmdOffset - hmdOffsetLast;
            if (!movedSinceLastUpdate.Equals(Vector3.zero))
            {
                goUserXr.camOffset += -hmdOffset;
                hmdOffsetLast = hmdOffset;
            }

            return movedSinceLastUpdate;
        }
        
        /*
         * The XrOrigin gameObject shall follow the head/camera movement.
         */
        private void followHmdOffset(Vector3 movedSinceLastUpdate)
        {
            if (!movedSinceLastUpdate.Equals(Vector3.zero))
            {
                gameObject.transform.position += goUserXr.goRotation*movedSinceLastUpdate*2;
            }
        }
        
        public void alignCamera()
        {
            Vector3 rotEuler = goUserXr.goRotation.eulerAngles;
            rotEuler.x = 0;
            rotEuler.z = 0;
            goUserXr.goRotation = Quaternion.Euler(rotEuler);
        }
        
        public void Update()
        {
            if (!lockMovement) processMove();
            
            if (originFollowHeadMovement)
            {
                Vector3 movedSinceLastUpdate = calculateOffsets();
                followHmdOffset(movedSinceLastUpdate);
            }
            
            processCrouch();
        }

        private void processCrouch()
        {
            if (isCrouching && crouchTimeElapsed < modelConfig.transitionTime)
            {
                var newHeight = Mathf.Lerp(crouchHeightStart, modelConfig.crouchHeight, crouchTimeElapsed / modelConfig.transitionTime);
                charaController.height = newHeight;
                crouchTimeElapsed += Time.fixedDeltaTime;
            }
            else if (!isCrouching && crouchTimeElapsed < modelConfig.transitionTime)
            {
                var newHeight = Mathf.Lerp(crouchHeightStart, modelConfig.charHeight, crouchTimeElapsed / modelConfig.transitionTime);
                charaController.height = newHeight;
                crouchTimeElapsed += Time.fixedDeltaTime;
            }
        }

        public void OnCrouchStarted(InputAction.CallbackContext context)
        {
            if (!modelConfig.canCrouch) return;
            
            isCrouching = true;
            crouchTimeElapsed = 0.0f;
            crouchHeightStart = charaController.height;
        }

        public void OnCrouchCanceled(InputAction.CallbackContext context)
        {
            isCrouching = false;
            crouchTimeElapsed = 0.0f;
            crouchHeightStart = charaController.height;
        }
        
        private void OnDisable()
        {
        }

        public void OnActionRotPerformed(InputAction.CallbackContext context)
        {
            if (!lockRotation)
            {
                processRotation(context);
            }
        }

        public void OnActionMovePerformed(InputAction.CallbackContext context)
        {
            movementInput = context.ReadValue<Vector2>();
        }

        public void OnActionMoveCanceled(InputAction.CallbackContext context)
        {
            movementInput = Vector2.zero;
        }

        public void OnActionRotCanceled(InputAction.CallbackContext context)
        {
        }

        public void OnJumpStarted(InputAction.CallbackContext context)
        {
            jumpTrigger = true;
        }

        public void OnJumpCanceled(InputAction.CallbackContext context)
        {
            jumpTrigger = false;
        }

        public void setMouseInvert(bool value)
        {
            mouseInvert = value;
        }

        public void setMouseSpeed(ControlSettings.MouseSpeed value)
        {
            switch (value)
            {
                case ControlSettings.MouseSpeed.MIN:
                    mouseRotateFactor = 0.33f;
                    break;
                case ControlSettings.MouseSpeed.SLOW:
                    mouseRotateFactor = 0.66f;
                    break;
                case ControlSettings.MouseSpeed.MEDIUM:
                    mouseRotateFactor = 1.0f;
                    break;
                case ControlSettings.MouseSpeed.HIGH:
                    mouseRotateFactor = 1.33f;
                    break;
                case ControlSettings.MouseSpeed.MAX:
                    mouseRotateFactor = 1.66f;
                    break;
            }
        }

        public bool isLockMovement()
        {
            return lockMovement;
        }

        public bool isLockTurn()
        {
            return lockTurn;
        }

        public void setLockTurn(bool value)
        {
            lockTurn = value;
        }

        public void setLockRotation(bool value)
        {
            lockRotation = value;
        }

        public void setLockMovement(bool value)
        {
            lockMovement = value;
        }

        public void setHorizontalRotation(bool value)
        {
            horizontalRotation = value;
        }

        public void setOriginFollowHeadMovement(bool value)
        {
            originFollowHeadMovement = value;
        }

        public void setLocalRot(Quaternion rotation)
        {
            goUserXr.goRotationLocal = rotation;
        }

        public XROrigin getXrOrigin()
        {
            return xrOrigin;
        }

        public Camera getCamera()
        {
            return camera;
        }

        public void applyModelConfig(IModelConfig config)
        {
            modelConfig = config;
            
            charaController = goUserXr.gameObject.GetComponent<CharacterController>();
            if (charaController == null) charaController = goUserXr.gameObject.AddComponent<CharacterController>();
            
            if (!Debug.isDebugBuild) config.jetPack = false;
            charaController.height = config.charHeight;
            charaController.radius = config.charRadius;
            charaController.stepOffset = config.charStep;
            charaController.center = config.charOffset;
        }
    }
}