// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using InfinitraCore.Objects;
using InfinitraCore.WorldAPI;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.XR.Interaction.Toolkit;
using Debug = UnityEngine.Debug;

namespace Infinitra.Movement
{
    public class Movement : MonoBehaviour
    {

        public InputActionReference jumpButton;
        public InputActionReference moveAction; // Reference to your 2D movement action
        public InputActionReference rotAction;
        public InputActionReference turnAction;
                
        // switches
        public bool jetPack = true;
        
        // This vector stores the actual movement.
        public Vector3 moveVector = Vector3.zero;

        private bool mouseInvert = false;
        
        private bool lockMovement = true;
        private bool lockRotation = true;
        private bool lockTurn = true;
        private bool followHeadMovement = true;
        private bool horizontalRotation = false;
        
        private float gravityAccel = -1f; // -9.81f;
        private float jumpSpeed = 5f;
        private float fallSpeed = -50f; // Maximum fall speed to prevent infinite acceleration
        private float moveSpeedWalking = 3f;
        private float moveSpeedFlying = 1f;

        private float moveAccelerationWalking = 10f;
        private float moveAccelerationFlying = 5f;

        private float rotationSensitivity = 0.2f;
        private float turnSensitivity = 100f;
        private readonly float friction = 3.0f;
        
        private XROrigin xrOrigin;
        private EnvironmentProbe probe;
        private CharacterController charaController;
        private GameObject cameraOffset;
        private Camera camera;
        private float heightHalf;

        private bool jumpTrigger;
        private Vector2 movementInput;
        private Vector2 controllerTurnInput;
        private Vector3 playerPosLast;
        private Vector3 hmdOffsetLast;

        private GameObject lastSelected;

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
            ComponentLoader.uiVisualizer.addCanvasActiveEvent(updateRestrictions);  
            ComponentLoader.userContr.addXrActiveEvent(updateRestrictions);
            ComponentLoader.userContr.addLoadingActiveEvent(updateRestrictions);
            ComponentLoader.userContr.addControlSettingsHandler(updateControlSettings);
            
            jumpButton.action.started += JumpEnabled;
            jumpButton.action.canceled += JumpDisabled;
            jumpButton.action.Enable();
            
            rotAction.action.started += OnRotPerformed;
            rotAction.action.canceled += OnRotCanceled;
            rotAction.action.Enable();
            
            turnAction.action.performed += OnTurnPerformed; // use "performed" for snap turn
            turnAction.action.canceled += OnTurnCanceled;
            turnAction.action.Enable();
            
            moveAction.action.performed += OnMovePerformed;
            moveAction.action.canceled += OnMoveCanceled;
            moveAction.action.Enable();
        }

        private void processMove()
        { 
            heightHalf = charaController.height * 0.6f;

            var playerPos = charaController.transform.position;

            var isGrounded = probe.isGrounded;

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

            if (new Vector3(moveVector.x, 0f, moveVector.z).magnitude < maxMoveSpeedXZ)
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
                if (probe.DistanceUp < heightHalf && moveVector.y > 0.0) moveVector.y = 0.0f;
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
            
            Vector3 currentRotation = transform.eulerAngles;
            Vector3 newRotation = transform.eulerAngles;
                        
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

            transform.rotation = Quaternion.Euler(newRotation);
        }
        
        private void processControllerTurn()
        {
            if (!Vector2.zero.Equals(controllerTurnInput))
            {
                float rotationX = controllerTurnInput.x * turnSensitivity * Time.deltaTime;
                Vector3 currentRotation = transform.eulerAngles;
                transform.rotation = Quaternion.Euler(0f, currentRotation.y + rotationX, 0f);
            }
        }

        private void followHmdOffset()
        {
            Vector3 hmdOffset = camera.transform.localPosition;
            Vector3 movedSinceLastUpdate = hmdOffset - hmdOffsetLast;
            if (!movedSinceLastUpdate.Equals(Vector3.zero))
            {
                cameraOffset.transform.localPosition = -hmdOffset;
                gameObject.transform.position += camera.transform.rotation*movedSinceLastUpdate*2;
                hmdOffsetLast = hmdOffset;
            }
        }

        private void updateControlSettings(object sender, ControlSettings value)
        {
            Debug.Log("Movement script received new control settings.");
            mouseInvert = value.mouseInvert;
        }
        
        private void updateRestrictions(object sender, bool value)
        {
            bool xrActive = ComponentLoader.userContr.isXrActive();
            bool canvasVisible = ComponentLoader.uiVisualizer.isCanvasActive();

            horizontalRotation = ComponentLoader.userContr.isXrActive();
            lockTurn = canvasVisible && !xrActive;
            lockRotation = canvasVisible && !xrActive;
            lockMovement = canvasVisible;

            if (xrActive)
            {
                alignCamera();
                cameraOffset.transform.localRotation = Quaternion.identity;
            }
            else
            {
                alignCamera();
                cameraOffset.transform.localRotation = Quaternion.Inverse(camera.transform.localRotation);   
            }
            
            if (xrActive && canvasVisible)
            {
                followHeadMovement = false;
                controllerLinesVisible(true);
            }
            else
            {
                followHeadMovement = true;
                controllerLinesVisible(false);
            }    
        }

        private void controllerLinesVisible(bool visible)
        {
            foreach (XRInteractorLineVisual renderer in gameObject.GetComponentsInChildren<XRInteractorLineVisual>())
            {
                renderer.enabled = visible;
            }
        }

        private void alignCamera()
        {
            Vector3 rotEuler = xrOrigin.transform.eulerAngles;
            rotEuler.x = 0;
            rotEuler.z = 0;
            xrOrigin.transform.eulerAngles = rotEuler;
        }
        
        private void Update()
        {
            if (!lockTurn) processControllerTurn();
            
            if (!lockMovement) processMove();

            if (followHeadMovement) followHmdOffset();
        }

        private void OnDisable()
        {

            jumpButton.action.started -= JumpEnabled;
            jumpButton.action.canceled -= JumpDisabled;
            jumpButton.action.Disable();
            
            rotAction.action.started -= OnRotPerformed;
            rotAction.action.canceled -= OnRotCanceled;
            rotAction.action.Disable();
            
            turnAction.action.performed -= OnTurnPerformed;
            turnAction.action.canceled -= OnTurnCanceled;
            turnAction.action.Disable();
            
            moveAction.action.performed -= OnMovePerformed;
            moveAction.action.canceled -= OnMoveCanceled;
            moveAction.action.Disable();
        }
        
        private void OnRotPerformed(InputAction.CallbackContext context)
        {
            if (!lockRotation)
            {
                processRotation(context);
            }
        }
        
        private void OnMovePerformed(InputAction.CallbackContext context)
        {
            movementInput = context.ReadValue<Vector2>();
        }

        private void OnMoveCanceled(InputAction.CallbackContext context)
        {
            movementInput = Vector2.zero;
        }

        private void OnRotCanceled(InputAction.CallbackContext context)
        {
        }
        
        private void OnTurnPerformed(InputAction.CallbackContext context)
        {
            controllerTurnInput = context.ReadValue<Vector2>();

        }

        private void OnTurnCanceled(InputAction.CallbackContext context)
        {
            controllerTurnInput = Vector2.zero;
        }
        
        private void JumpEnabled(InputAction.CallbackContext context)
        {
            jumpTrigger = true;
        }

        private void JumpDisabled(InputAction.CallbackContext context)
        {
            jumpTrigger = false;
        }
    }
}