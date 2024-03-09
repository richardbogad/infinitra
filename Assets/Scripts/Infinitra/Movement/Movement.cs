// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.InputSystem;

namespace Infinitra.Movement
{
    public class Movement : MonoBehaviour
    {
        public InputActionReference jumpButton;
        public InputActionReference moveAction; // Reference to your 2D movement action
        public XROrigin xrRig;

        public float gravityValue = -9.81f; // Standard gravity acceleration
        public float jumpVelocity = 5.0f;
        public float fallSpeed = -20.0f; // Maximum fall speed to prevent infinite acceleration
        public float moveSpeedWalking = 3.0f;
        public float moveSpeedFlying = 1.0f;

        public float moveAcellerationWalking = 10.0f;
        public float moveAcellerationFlying = 5.0f;

        public EnvironmentProbe probe;

        // This vector stores the movement.
        public Vector3 moveVector = Vector3.zero;

        private CharacterController charaController;

        private readonly float friction = 3.0f;
        private float heightHalf;
        private readonly bool jetPack = true;

        private bool jumpTrigger;
        private Vector2 movementInput;

        private Vector3 playerPosLast;


        private void Awake()
        {
            charaController = GetComponent<CharacterController>();
        }

        private void FixedUpdate()
        {
            heightHalf = charaController.height * 0.6f;


            var playerPos = charaController.transform.position;

            var isGrounded = probe.isGrounded;

            var moveAccelerateReducer = 1.0f;
            if (!isGrounded)
                // don't acellerate fast while flying
                moveAccelerateReducer = 0.2f;

            // horizontal movement
            var movementInputVec = new Vector3(this.movementInput.x, 0, this.movementInput.y);
            var cameraYaw = Quaternion.Euler(0, xrRig.Camera.transform.eulerAngles.y, 0);
            var movementInput = cameraYaw * movementInputVec;


            // only accelerate if the speed is within the limits
            var moveSpeed = isGrounded ? moveSpeedWalking : moveSpeedFlying;
            if (new Vector3(moveVector.x, 0.0f, moveVector.z).magnitude < moveSpeed)
            {
                var moveAcelleration = isGrounded ? moveAcellerationWalking : moveAcellerationFlying;
                moveVector += movementInput * (Time.deltaTime * moveAcelleration * moveAccelerateReducer);
            }

            // gravity acceleration
            moveVector.y += gravityValue * Time.deltaTime;

            if (jumpTrigger)
            {
                if (jetPack)
                {
                    moveVector.y += moveAcellerationFlying * Time.deltaTime;
                }
                else if (isGrounded)
                {
                    moveVector.y += jumpVelocity;
                    jumpTrigger = false;
                }
            }

            if (isGrounded)
            {
                // restrict downward movement
                if (moveVector.y < 0.0) moveVector.y = -moveVector.y * 0.25f;
            }
            else
            {
                // collision while jumping
                var isBlockedUp = probe.DistanceUp < heightHalf;
                if (isBlockedUp && moveVector.y > 0.0) moveVector.y = 0.0f;
            }


            float friction_factor;
            var friction_vector = moveVector;
            if (isGrounded)
            {
                friction_factor = 1.0f;

                // apply ground friction only to the normal component of the movement vector
                if (!movementInput.Equals(Vector3.zero))
                    friction_vector *= Vector3.Cross(moveVector, movementInput.normalized).magnitude / moveVector.magnitude;
            }
            else
            {
                // moving friction reduced only when flying or actively moving
                friction_factor = 0.125f;
                // limit too fast speed downwards
                if (moveVector.y < fallSpeed) moveVector.y -= moveVector.y * Time.deltaTime * friction_factor;
            }

            moveVector.x -= friction_vector.x * Time.deltaTime * friction * friction_factor;
            moveVector.z -= friction_vector.z * Time.deltaTime * friction * friction_factor;

            // update position
            charaController.Move(moveVector * Time.deltaTime);

            var playerVel = (playerPos - playerPosLast) / Time.deltaTime;
            playerPosLast = playerPos;
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

        private void JumpEnabled(InputAction.CallbackContext obj)
        {
            jumpTrigger = true;
        }

        private void JumpDisabled(InputAction.CallbackContext obj)
        {
            jumpTrigger = false;
        }
    }
}