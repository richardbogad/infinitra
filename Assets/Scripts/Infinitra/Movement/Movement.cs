// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using InfinitraCore.Objects;
using InfinitraCore.WorldAPI;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.InputSystem;

namespace Infinitra.Movement
{

    public class Movement : MonoBehaviour, IMovement
    {

        // switches 
        public bool jetPack = true;

        // This vector stores the actual movement.
        public Vector3 moveVector = Vector3.zero;

        private bool lockMovement = true;
        private bool lockRotation = true;
        private bool lockTurn = true;
        private bool originFollowHeadMovement = true;
        private bool horizontalRotation = false;
        private bool mouseInvert = false;

        private float gravityAccel = -1f; // -9.81f;
        private float jumpSpeed = 3f;
        private float fallSpeed = -50f; // Maximum fall speed to prevent infinite acceleration
        private float moveSpeedWalking = 3f;
        private float moveSpeedFlying = 1.5f;

        private float moveAccelerationWalking = 10f;
        private float moveAccelerationFlying = 10f;

        private float rotationSensitivity = 0.2f;
        private readonly float friction = 3.0f;

        private XROrigin xrOrigin;
        private EnvironmentProbe probe;
        private CharacterController charaController;
        private GameObject cameraOffset;
   
        private Camera camera;
 
        private bool jumpTrigger;
        private Vector2 movementInput;
        private Vector3 playerPosLast;
        private Vector3 hmdOffsetLast;

        private GameObject lastSelected;

        private bool isCrouching = false;

        private float crouchTimeElapsed;
        private float crouchHeightStart;
        private readonly float crouchHeight = 0.8f;
        private readonly float standHeight = 1.8f;
        private readonly float transitionTime = 0.5f; // Adjust as needed
        private readonly float cameraHeightFactor = 0.75f;
        //private SetupControls setupControls;


        private void Awake()
        {
            xrOrigin = GetComponent<XROrigin>();
            probe = GetComponent<EnvironmentProbe>();
            charaController = GetComponent<CharacterController>();
            cameraOffset = AssetTools.getChildGameObject(gameObject, "Camera Offset");

            camera = GetComponentInChildren<Camera>();

        }

        private void OnEnable()
        {
            if (!Debug.isDebugBuild) jetPack = false;
            CompLoader.userContr.setMovementScript(this);
        }

        private void processMove()
        { 

            var playerPos = charaController.transform.position;

            var isGrounded = probe.collisionDown;

            var moveAccelFactor = 1.0f;
            if (!isGrounded)
                // Don't accelerate fast while flying
                moveAccelFactor = 0.2f;

            // Calculate intended horizontal movement
            var accelInputVec = new Vector3(this.movementInput.x, 0, this.movementInput.y);
            var cameraYaw = Quaternion.Euler(0, xrOrigin.Camera.transform.eulerAngles.y, 0);
            var accelInputRotated = cameraYaw * accelInputVec;

            // Calculate intended vertical movement
            if (jumpTrigger)
            {
                if (jetPack) accelInputRotated.y = 1.0f;
                else if (isGrounded)
                {
                    moveVector.y += jumpSpeed; // TODO jumping should be more sophisticated
                    jumpTrigger = false;
                }
            }

            // Only accelerate if the speed is within the limits
            var maxMoveSpeedXZ = isGrounded ? moveSpeedWalking : moveSpeedFlying;
            var moveAcceleration = isGrounded ? moveAccelerationWalking : moveAccelerationFlying;

            bool allowXZ = false;

            Vector3 moveXZ = new(moveVector.x, 0f, moveVector.z);
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
                moveVector.x += accelInputRotated.x * Time.deltaTime * moveAcceleration * moveAccelFactor;
                moveVector.z += accelInputRotated.z * Time.deltaTime * moveAcceleration * moveAccelFactor;
            }

            // Jetpack
            if (jetPack && moveVector.y < maxMoveSpeedXZ)
                moveVector.y += accelInputRotated.y * Time.deltaTime * moveAcceleration;

            // Gravity acceleration
            if (moveVector.y > fallSpeed) moveVector.y += Time.deltaTime * gravityAccel;

            // Movement restrictions
            if (isGrounded)
            {
                // Restrict downward movement due to ground
                if (moveVector.y < 0.0) moveVector.y = -moveVector.y * 0.25f;
            }
            else
            {
                // Collision while moving up
                if (probe.collisionUp && moveVector.y > 0.0) moveVector.y = 0.0f;
            }

            // Calculate movement friction/decay
            float frictionFactor = isGrounded ? 1.0f : 0.05f;
            var frictionVector = moveVector;
            if (isGrounded)
            {
                // Apply ground friction only to the normal component of the movement vector
                if (!accelInputRotated.Equals(Vector3.zero))
                    frictionVector *= Vector3.Cross(moveVector, accelInputRotated.normalized).magnitude /
                                      moveVector.magnitude;
            }

            moveVector.x -= frictionVector.x * Time.deltaTime * friction * frictionFactor;
            moveVector.z -= frictionVector.z * Time.deltaTime * friction * frictionFactor;
            moveVector.y -= frictionVector.y * Time.deltaTime * friction * frictionFactor;

            // Update final position
            charaController.Move(moveVector * Time.deltaTime);

            var playerVel = (playerPos - playerPosLast) / Time.deltaTime;
            playerPosLast = playerPos;
        }
        
        private void processRotation(InputAction.CallbackContext context)
        {
            Vector2 input = context.ReadValue<Vector2>();
            
            Vector3 currentRotation = cameraOffset.transform.eulerAngles;
            Vector3 newRotation = cameraOffset.transform.eulerAngles;
                        
            float rotYaw = input.x * rotationSensitivity;
            newRotation.y += rotYaw;

            if (!horizontalRotation)
            {
                float rotPitch = -input.y * rotationSensitivity;
                if (mouseInvert) rotPitch = -rotPitch;
                float testRotPitch = currentRotation.x + rotPitch;
                float testRotPitchAbs = Mathf.Abs(testRotPitch);
                if (Mathf.Abs(testRotPitch) > 275f || testRotPitchAbs < 85f) newRotation.x = testRotPitch;
            }

            cameraOffset.transform.rotation = Quaternion.Euler(newRotation);
        }

        /*
         * The position of the XrOrigin GameObject shall be on the bottom of the character controller.
         * The camera shall be offsetted at a height of 'cameraHeightFactor'. 
         */
        private Vector3 calculateOffsets()
        {
            // The camera position (relative to the root of the character controller) shall be set via the cameraOffset GameObject
            cameraOffset.transform.localPosition = Vector3.up * (charaController.height * cameraHeightFactor);
            charaController.center = Vector3.up * (charaController.height * 0.5f);
            
            Vector3 hmdOffset = camera.transform.localPosition;
            Vector3 movedSinceLastUpdate = hmdOffset - hmdOffsetLast;
            if (!movedSinceLastUpdate.Equals(Vector3.zero))
            {
                // This line relies on the calculateOffsets() function, which defined the camera offset previously.
                cameraOffset.transform.localPosition += -hmdOffset;
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
                gameObject.transform.position += cameraOffset.transform.rotation*movedSinceLastUpdate*2;
            }
        }


        public void alignCamera()
        {
            Vector3 rotEuler = xrOrigin.transform.eulerAngles;
            rotEuler.x = 0;
            rotEuler.z = 0;
            xrOrigin.transform.eulerAngles = rotEuler;
        }
        
        private void Update()
        {
            if (!lockMovement) processMove();
            
            Vector3 movedSinceLastUpdate = calculateOffsets();
            
            if (originFollowHeadMovement) followHmdOffset(movedSinceLastUpdate);
            
            processCrouch();
            

        }

        private void processCrouch()
        {
            if (isCrouching && crouchTimeElapsed < transitionTime)
            {
                var newHeight = Mathf.Lerp(crouchHeightStart, crouchHeight, crouchTimeElapsed / transitionTime);
                charaController.height = newHeight;
                crouchTimeElapsed += Time.fixedDeltaTime;
            }
            else if (!isCrouching && crouchTimeElapsed < transitionTime)
            {
                var newHeight = Mathf.Lerp(crouchHeightStart, standHeight, crouchTimeElapsed / transitionTime);
                charaController.height = newHeight;
                crouchTimeElapsed += Time.fixedDeltaTime;
            }
        }

        public void OnCrouchStarted(InputAction.CallbackContext context)
        {
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

        public GameObject getCameraOffset()
        {
            return cameraOffset;
        }

        public XROrigin getXrOrigin()
        {
            return xrOrigin;
        }

        public Camera getCamera()
        {
            return camera;
        }
    }
}