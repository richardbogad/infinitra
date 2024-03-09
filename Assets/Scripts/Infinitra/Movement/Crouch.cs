// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using UnityEngine;
using UnityEngine.InputSystem;

namespace Infinitra.Movement
{
    public class Crouch : MonoBehaviour
    {
        [SerializeField] private InputActionReference button;

        public bool crouch;
        private CharacterController characterController;
        private readonly float crouchHeight = 0.8f;
        private float elapsedTime;
        private readonly float standHeight = 2.0f;
        private float startHeight;

        private readonly float transitionTime = 0.2f; // Adjust as needed

        private void Awake()
        {
            characterController = GetComponent<CharacterController>();
        }

        private void FixedUpdate()
        {
            if (crouch && elapsedTime < transitionTime)
            {
                var newHeight = Mathf.Lerp(startHeight, crouchHeight, elapsedTime / transitionTime);
                characterController.height = newHeight;
                elapsedTime += Time.fixedDeltaTime;
            }
            else if (!crouch && elapsedTime < transitionTime)
            {
                var newHeight = Mathf.Lerp(startHeight, standHeight, elapsedTime / transitionTime);
                characterController.height = newHeight;
                elapsedTime += Time.fixedDeltaTime;
            }
        }

        private void OnEnable()
        {
            button.action.started += OnCrouchStarted;
            button.action.canceled += OnCrouchCanceled;
        }

        private void OnDisable()
        {
            button.action.started -= OnCrouchStarted;
            button.action.canceled -= OnCrouchCanceled;
        }

        private void OnCrouchStarted(InputAction.CallbackContext context)
        {
            crouch = true;
            elapsedTime = 0.0f;
            startHeight = characterController.height;
        }

        private void OnCrouchCanceled(InputAction.CallbackContext context)
        {
            crouch = false;
            elapsedTime = 0.0f;
            startHeight = characterController.height;
        }
    }
}