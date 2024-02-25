// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using Infinitra.Objects;
using InfinitraCore.Components;
using InfinitraCore.Objects;
using InfinitraCore.Shared;
using InfinitraCore.WorldCore;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.InputSystem;
using Quaternion = InfinitraCore.Shared.Quaternion;

namespace Infinitra.Movement
{

    public class Movement : MonoBehaviour, IMovement
    {
        private Quaternion currentRotation = default;

        private IModelConfig modelConfig;
        private CharacterController charaController;

        internal GoUserXr goUserXr;
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
        private Vector hmdOffsetLast;

        private GameObject lastSelected;

        private bool isCrouching = false;

        private float crouchTimeElapsed;
        private float crouchHeightStart;
        
        private float bounceThreshold;
        
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

        private void processMove(float deltaTime)
        { 
            // Position fetching is necessary for internal calculation.
            goUserXr.goPositionGetUnity();
            currentRotation = goUserXr.goRotationLow;
            
            var moveAccelFactor = 1.0f;
            if (!goUserXr.collDown)
                // Don't accelerate fast while flying
                moveAccelFactor = 0.2f;

            // Calculate intended horizontal movement
            Vector accelInputVec = new(movementInput.x, 0, movementInput.y);
            Quaternion cameraYaw = Quaternion.Euler(0, xrOrigin.Camera.transform.eulerAngles.y, 0);
            Vector accelInputRotated = cameraYaw * accelInputVec;

            Vector velocity = goUserXr.velocity;
            
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

            Vector moveXZ = new(velocity.x, 0f, velocity.z);
            Vector inputXZ = new(accelInputRotated.x, 0f, accelInputRotated.z);
            if (moveXZ.magnitude < maxMoveSpeedXZ) allowXZ = true;
            else
            {
                // Check if the input direction is roughly the opposite of the movement direction
                float dotProduct = Vector.Dot(Vector.Normalize(moveXZ), Vector.Normalize(inputXZ));
                if (dotProduct < 0.0f) allowXZ = true;
            }
            
            if (allowXZ)
            {
                velocity.x += accelInputRotated.x * deltaTime * moveAcceleration * moveAccelFactor;
                velocity.z += accelInputRotated.z * deltaTime * moveAcceleration * moveAccelFactor;
            }

            // Jetpack
            if (modelConfig.jetPack && velocity.y < maxMoveSpeedXZ)
                velocity.y += accelInputRotated.y * deltaTime * moveAcceleration;

            // Movement restrictions
            if (goUserXr.collDown)
            {
                // Bouncing off ground.
                if (velocity.y < bounceThreshold) velocity.y = -(velocity.y-bounceThreshold) * 0.25f;
            }
            else
            {
                // Collision while moving up.
                if (goUserXr.collUp && velocity.y > 0.0) velocity.y = 0.0f;
            }
            
            // Gravity acceleration
            if (velocity.y > modelConfig.fallSpeed) velocity.y += deltaTime * modelConfig.gravityAccel;


            if (!velocity.Equals(Vector.zero))
            {
                // Calculate movement friction/decay
                float frictionFactor = goUserXr.collDown ? 1.0f : 0.05f;
                
                Vector frictionVector;
                
                if (!accelInputRotated.Equals(Vector3.zero))
                {
                    // Normalize the velocity and acceleration input vectors
                    Vector normalizedAccelInput = Vector.Normalize(accelInputRotated);

                    // Calculate the projection of velocity onto the acceleration vector (parallel component)
                    Vector parallelComponent = Vector.Dot(velocity, normalizedAccelInput) * normalizedAccelInput;

                    // The remaining part is the normal component (orthogonal to the acceleration direction)
                    Vector normalComponent = velocity - parallelComponent;
                    
                    frictionVector = -normalComponent * deltaTime * modelConfig.friction * frictionFactor;
                }
                else
                {
                    frictionVector = -velocity * deltaTime * modelConfig.friction * frictionFactor;
                }
                velocity += frictionVector;
            }

            // Update final velocity / position
            goUserXr.Move(velocity, deltaTime);
        }
        
        private void processRotation(InputAction.CallbackContext context)
        {
            Vector2 input = context.ReadValue<Vector2>();

            Vector currentEuler = currentRotation.ToEulerAngles();
            Vector newRotation = currentEuler.Clone();
                        
            float rotYaw = input.x * modelConfig.rotationSensitivity * mouseRotateFactor;
            newRotation.y += rotYaw;

            if (!horizontalRotation)
            {
                float rotPitch = -input.y * modelConfig.rotationSensitivity;
                if (mouseInvert) rotPitch = -rotPitch;
                float testRotPitch = currentEuler.x + rotPitch;
                float testRotPitchAbs = Mathf.Abs(testRotPitch);
                if (Mathf.Abs(testRotPitch) > 275f || testRotPitchAbs < 85f) newRotation.x = testRotPitch;
            }

            goUserXr.goRotationLow = Quaternion.Euler(newRotation);
        }

        /*
         * The position of the XrOrigin GameObject shall be on the bottom of the character controller.
         * The camera shall be offsetted at a height of 'cameraHeightFactor'. 
         */
        private Vector calculateOffsets()
        {
            // The camera position (relative to the root of the character controller) shall be set via the cameraOffset GameObject
            goUserXr.camOffset = Vector.up * (charaController.height * modelConfig.cameraHeightFactor);
            charaController.center = UnityConversions.ToUnity(Vector.up * (charaController.height * 0.5f));
            
            Vector hmdOffset = UnityConversions.FromUnity(camera.transform.localPosition);
            Vector movedSinceLastUpdate = hmdOffset - hmdOffsetLast;
            if (!movedSinceLastUpdate.Equals(Vector.zero))
            {
                goUserXr.camOffset += -hmdOffset;
                hmdOffsetLast = hmdOffset;
            }

            return movedSinceLastUpdate;
        }
        
        /*
         * The XrOrigin gameObject shall follow the head/camera movement.
         */
        private void followHmdOffset(Vector movedSinceLastUpdate)
        {
            if (!movedSinceLastUpdate.Equals(Vector.zero))
            {
                goUserXr.goPositionLow += currentRotation * movedSinceLastUpdate * 2;
            }
        }
        
        public void alignCamera()
        {
            Vector rotEuler = currentRotation.ToEulerAngles();
            rotEuler.x = 0;
            rotEuler.z = 0;
            goUserXr.goRotationLow = Quaternion.Euler(rotEuler);
        }
        
        public void FixedUpdate()
        {
            float delta = Time.fixedDeltaTime;
            
            // The movement should not depend on the game position, as this may change suddenly due to foldback.
            if (!lockMovement) processMove(delta);
            
            if (originFollowHeadMovement)
            {
                Vector movedSinceLastUpdate = calculateOffsets();
                followHmdOffset(movedSinceLastUpdate);
            }
            
            processCrouch(delta);
        }

        private void processCrouch(float deltaTime)
        {
            if (isCrouching && crouchTimeElapsed < modelConfig.transitionTime)
            {
                var newHeight = Mathf.Lerp(crouchHeightStart, modelConfig.crouchHeight, crouchTimeElapsed / modelConfig.transitionTime);
                charaController.height = newHeight;
                crouchTimeElapsed += deltaTime;
            }
            else if (!isCrouching && crouchTimeElapsed < modelConfig.transitionTime)
            {
                var newHeight = Mathf.Lerp(crouchHeightStart, modelConfig.charHeight, crouchTimeElapsed / modelConfig.transitionTime);
                charaController.height = newHeight;
                crouchTimeElapsed += deltaTime;
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

        public XROrigin getXrOrigin()
        {
            return xrOrigin;
        }

        public void applyModelConfig(IModelConfig config)
        {
            modelConfig = config;
            
            charaController = goUserXr.gameObject.GetComponent<CharacterController>();
            if (charaController == null) charaController = goUserXr.gameObject.AddComponent<CharacterController>();
            
            // config.jetPack = false;
            charaController.height = config.charHeight;
            charaController.radius = config.charRadius;
            charaController.stepOffset = config.charStep;
            charaController.center = config.charOffset;
            charaController.skinWidth = config.charSkin;
            charaController.slopeLimit = config.charSlope;
            charaController.minMoveDistance = config.charMoveDist;
            charaController.enableOverlapRecovery = true;
            bounceThreshold = config.bounceThreshold;
        }
    }
}