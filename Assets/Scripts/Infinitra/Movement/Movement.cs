// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System.Collections.Generic;
using System.Reflection;
using Infinitra.Tools;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Serialization;
using UnityEngine.XR;
using UnityEngine.XR.Interaction.Toolkit.Inputs.Simulation;
using UnityEngine.XR.Interaction.Toolkit.Samples.DeviceSimulator;

namespace Infinitra.Movement
{
    public class Movement : MonoBehaviour
    {
        public InputActionReference jumpButton;
        public InputActionReference moveAction; // Reference to your 2D movement action
        public InputActionReference rotAction;
        public InputActionReference turnAction;
        
        public float gravityAccel = -1f; // -9.81f;
        public float jumpSpeed = 5f;
        public float fallSpeed = -50f; // Maximum fall speed to prevent infinite acceleration
        public float moveSpeedWalking = 3f;
        public float moveSpeedFlying = 1f;

        public float moveAccelerationWalking = 10f;
        public float moveAccelerationFlying = 5f;
        public bool followHeadMovement = true;

        public float rotationSensitivity = 0.2f;
        public float turnSensitivity = 100f;
        private readonly float friction = 3.0f;
        
        // This vector stores the actual movement.
        public Vector3 moveVector = Vector3.zero;
        public bool jetPack = true;
        
        private XROrigin xrRig;
        private EnvironmentProbe probe;
        private CharacterController charaController;
        private GameObject cameraOffset;
        private Camera camera;
        private float heightHalf;
        

        private bool jumpTrigger;
        private Vector2 movementInput;
        private Vector2 turnInput;
        private Vector3 playerPosLast;
        private Vector3 hmdOffsetLast;

        private void Awake()
        {
            xrRig = GetComponent<XROrigin>();
            probe = GetComponent<EnvironmentProbe>();
            charaController = GetComponent<CharacterController>();
            cameraOffset = UnityTools.getChildGameObject(gameObject, "Camera Offset");
            camera = GetComponentInChildren<Camera>();

        }

        private void FixedUpdate()
        {

            if (!Vector2.zero.Equals(turnInput))
            {
                float rotationX = turnInput.x * turnSensitivity * Time.deltaTime;
                Vector3 currentRotation = transform.eulerAngles;
                transform.rotation = Quaternion.Euler(0f, currentRotation.y + rotationX, 0f);
            }
            
            heightHalf = charaController.height * 0.6f;

            var playerPos = charaController.transform.position;

            var isGrounded = probe.isGrounded;

            var moveAccelFactor = 1.0f;
            if (!isGrounded)
                // Don't accelerate fast while flying
                moveAccelFactor = 0.2f;

            // Calculate intended horizontal movement
            var accelInputVec = new Vector3(this.movementInput.x, 0, this.movementInput.y);
            var cameraYaw = Quaternion.Euler(0, xrRig.Camera.transform.eulerAngles.y, 0);
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
            if (jetPack && moveVector.y < maxMoveSpeedXZ) moveVector.y += accelInputRotated.y * Time.deltaTime * moveAcceleration;
            
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

        private void Update() {
            if (followHeadMovement)
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
        }

        private void OnEnable()
        {
            jumpButton.action.started += JumpEnabled;
            jumpButton.action.canceled += JumpDisabled;
            
            rotAction.action.started += OnRotPerformed;
            rotAction.action.canceled += OnRotCanceled;
            
            turnAction.action.performed += OnTurnPerformed; // use "performed" for snap turn
            turnAction.action.canceled += OnTurnCanceled;
            moveAction.action.Enable();
            
            moveAction.action.performed += OnMovePerformed;
            moveAction.action.canceled += OnMoveCanceled;
            moveAction.action.Enable();
        }

        private void OnDisable()
        {

            jumpButton.action.started -= JumpEnabled;
            jumpButton.action.canceled -= JumpDisabled;
                
            rotAction.action.started -= OnRotPerformed;
            rotAction.action.canceled -= OnRotCanceled;
            
            turnAction.action.performed -= OnTurnPerformed;
            turnAction.action.canceled -= OnTurnCanceled;
            turnAction.action.Disable();
            
            moveAction.action.performed -= OnMovePerformed;
            moveAction.action.canceled -= OnMoveCanceled;
            moveAction.action.Disable();
        }

        private void OnMovePerformed(InputAction.CallbackContext context)
        {
            movementInput = context.ReadValue<Vector2>();
        }

        private void OnMoveCanceled(InputAction.CallbackContext context)
        {
            movementInput = Vector2.zero;
        }

        private void OnRotPerformed(InputAction.CallbackContext context)
        {
            Vector2 input = context.ReadValue<Vector2>();
            
            float rotationX = input.x * rotationSensitivity;
            float rotationY = -input.y * rotationSensitivity;

            Vector3 currentRotation = transform.eulerAngles;

            transform.rotation = Quaternion.Euler(currentRotation.x + rotationY, currentRotation.y + rotationX, 0f);
        }

        private void OnRotCanceled(InputAction.CallbackContext context)
        {
        }
        
        private void OnTurnPerformed(InputAction.CallbackContext context)
        {
            turnInput = context.ReadValue<Vector2>();

        }

        private void OnTurnCanceled(InputAction.CallbackContext context)
        {
            turnInput = Vector2.zero;
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