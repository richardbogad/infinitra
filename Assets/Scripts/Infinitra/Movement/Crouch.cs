// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Serialization;

namespace Infinitra.Movement
{
    public class Crouch : MonoBehaviour
    {
        [SerializeField] private InputActionReference button;
        public bool isCrouching;
        
        private readonly float crouchHeight = 0.8f;
        private readonly float standHeight = 2.0f;
        private readonly float transitionTime = 0.2f; // Adjust as needed
        
        private CharacterController characterController;
        private float elapsedTime;
        private float startHeight;

        private void Awake()
        {
            characterController = GetComponent<CharacterController>();
        }

        private void FixedUpdate()
        {
            if (isCrouching && elapsedTime < transitionTime)
            {
                var newHeight = Mathf.Lerp(startHeight, crouchHeight, elapsedTime / transitionTime);
                characterController.height = newHeight;
                elapsedTime += Time.fixedDeltaTime;
            }
            else if (!isCrouching && elapsedTime < transitionTime)
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
            isCrouching = true;
            elapsedTime = 0.0f;
            startHeight = characterController.height;
        }

        private void OnCrouchCanceled(InputAction.CallbackContext context)
        {
            isCrouching = false;
            elapsedTime = 0.0f;
            startHeight = characterController.height;
        }
    }
}