// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using Infinitra.Tools;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.InputSystem;

namespace Infinitra.Movement
{
    public class Movement : MonoBehaviour
    {
        public InputActionReference jumpButton;
        public InputActionReference moveAction; // Reference to your 2D movement action

        public float gravityAccel = -1f; // -9.81f;
        public float jumpSpeed = 5.0f;
        public float fallSpeed = -50.0f; // Maximum fall speed to prevent infinite acceleration
        public float moveSpeedWalking = 3.0f;
        public float moveSpeedFlying = 1.0f;

        public float moveAccelerationWalking = 10.0f;
        public float moveAccelerationFlying = 5.0f;
        public bool followHeadMovement = true;
        
        // This vector stores the actual movement.
        public Vector3 moveVector = Vector3.zero;
        
        private XROrigin xrRig;
        private EnvironmentProbe probe;
        private CharacterController charaController;
        private GameObject cameraOffset;
        private Camera camera;
        private float heightHalf;
        
        private readonly float friction = 3.0f;
        private readonly bool jetPack = true;
        private bool jumpTrigger;
        private Vector2 movementInput;
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
            
            if (new Vector3(moveVector.x, moveVector.y, moveVector.z).magnitude < maxMoveSpeedXZ)
            {
                moveVector.x += accelInputRotated.x * Time.deltaTime * moveAcceleration * moveAccelFactor;
                moveVector.z += accelInputRotated.z * Time.deltaTime * moveAcceleration * moveAccelFactor;
                
                if (jetPack) moveVector.y += accelInputRotated.y * Time.deltaTime * moveAcceleration;
            }
            
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
            moveAction.action.performed += OnMovePerformed;
            moveAction.action.canceled += OnMoveCanceled;
            moveAction.action.Enable();
        }

        private void OnDisable()
        {
            jumpButton.action.started -= JumpEnabled;
            jumpButton.action.canceled -= JumpDisabled;
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