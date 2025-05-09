//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//

using System;
using System.Collections.Generic;
using Infinitra.Core.Components;
using Infinitra.Core.Data;
using Infinitra.Core.Objects;
using Infinitra.Core.Settings;
using Infinitra.Shared;
using Infinitra.Core.Utils;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.InputSystem;
using Quaternion = Infinitra.Shared.Quaternion;

namespace Infinitra.Open.Movement
{
    public class Movement : MonoBehaviour, IMovement
    {
        private IModelConfig modelConfig;
        private CharacterController charaController;
        private readonly EventH<Transform> camTransformChangedHandler = new();

        internal GoUserXr goUserXr;
        private XROrigin xrOrigin;
        private Camera camera;
        
        private HashSet<IMovement.LockContext> lockMovement = new();
        private bool lockRotation = true;
        private bool lockTurn = true;
        private bool originFollowHeadMovement = true;
        private bool horizontalRotation = false;
        private bool mouseInvert = false;
        private float mouseRotateFactor = 1f;
        
        private bool jumpTrigger;
        private Vector2 movementInput;
        private Vector hmdOffsetLast;

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

        // Invokes the PlayerMovedOrRotated event.
        protected virtual void OnCamTransformChanged()
        {
            camTransformChangedHandler?.Invoke(this, camera.transform);
        }

        private void processMove(float deltaTime)
        { 
            var moveAccelFactor = 1.0f;
            if (!goUserXr.collDown)
                moveAccelFactor = 0.2f;

            Vector accelInputVec = new(movementInput.x, 0, movementInput.y);
            Quaternion cameraYaw = Quaternion.Euler(0, xrOrigin.Camera.transform.eulerAngles.y, 0);
            Vector accelInputRotated = cameraYaw * accelInputVec;

            Vector velocity = goUserXr.velocity;
            
            if (jumpTrigger)
            {
                if (modelConfig.jetPack) accelInputRotated.y = 1.0f;
                else if (goUserXr.collDown)
                {
                    velocity.y += modelConfig.jumpSpeed; 
                    jumpTrigger = false;
                }
            }

            var maxMoveSpeedXZ = goUserXr.collDown ? modelConfig.moveSpeedWalking : modelConfig.moveSpeedFlying;
            var moveAcceleration = goUserXr.collDown ? modelConfig.moveAccelerationWalking : modelConfig.moveAccelerationFlying;

            bool allowXZ = false;
            Vector moveXZ = new(velocity.x, 0f, velocity.z);
            Vector inputXZ = new(accelInputRotated.x, 0f, accelInputRotated.z);
            if (moveXZ.magnitude < maxMoveSpeedXZ) allowXZ = true;
            else
            {
                float dotProduct = (float)Vector.Dot(Vector.Normalize(moveXZ), Vector.Normalize(inputXZ));
                if (dotProduct < 0.0f) allowXZ = true;
            }
            
            if (allowXZ)
            {
                velocity.x += accelInputRotated.x * deltaTime * moveAcceleration * moveAccelFactor;
                velocity.z += accelInputRotated.z * deltaTime * moveAcceleration * moveAccelFactor;
            }

            if (modelConfig.jetPack && velocity.y < maxMoveSpeedXZ)
                velocity.y += accelInputRotated.y * deltaTime * moveAcceleration;

            if (goUserXr.collDown)
            {
                if (velocity.y < bounceThreshold) velocity.y = -(velocity.y-bounceThreshold) * 0.25f;
            }
            else
            {
                if (goUserXr.collUp && velocity.y > 0.0) velocity.y = 0.0f;
            }
            
            if (velocity.y > modelConfig.fallSpeed) velocity.y += deltaTime * modelConfig.gravityAccel;

            bool hasMoved = !velocity.Equals(Vector.zero);

            if (hasMoved)
            {
                float frictionFactor = goUserXr.collDown ? 1.0f : 0.05f;
                Vector frictionVector;
                if (!accelInputRotated.Equals(Vector3.zero))
                {
                    Vector normalizedAccelInput = Vector.Normalize(accelInputRotated);
                    Vector parallelComponent = Vector.Dot(velocity, normalizedAccelInput) * normalizedAccelInput;
                    Vector normalComponent = velocity - parallelComponent;
                    frictionVector = -normalComponent * deltaTime * modelConfig.friction * frictionFactor;
                }
                else
                {
                    frictionVector = -velocity * deltaTime * modelConfig.friction * frictionFactor;
                }
                velocity += frictionVector;
            }

            goUserXr.Move(velocity, deltaTime);
            goUserXr.goPositionFromUnity();

            // If there was any input resulting in potential velocity change or actual movement
            if (accelInputVec != Vector.zero || hasMoved || jumpTrigger)
            {
                OnCamTransformChanged();
            }
        }
        
        private void processRotation(Vector2 rotationInput, Quaternion currentRotation)
        {
            Vector currentEuler = currentRotation.ToEulerAngles();
            Vector newRotation = currentEuler.Clone();
                        
            float rotYaw = rotationInput.x * modelConfig.rotationSensitivity * mouseRotateFactor;
            newRotation.y += rotYaw;

            if (!horizontalRotation)
            {
                float rotPitch = -rotationInput.y * modelConfig.rotationSensitivity;
                if (mouseInvert) rotPitch = -rotPitch;
                float testRotPitch = (float)currentEuler.x + rotPitch;
                float testRotPitchAbs = Mathf.Abs(testRotPitch);
                if (Mathf.Abs(testRotPitch) > 275f || testRotPitchAbs < 85f) newRotation.x = testRotPitch;
            }

            goUserXr.goRotationUnity = Quaternion.Euler(newRotation);
            goUserXr.goRotationFromUnity();

            // Notify about rotation for UI content refresh
            if (rotationInput != Vector2.zero)
            {
                OnCamTransformChanged();
            }
        }

        private Vector calculateOffsets()
        {
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
        
        private void followHmdOffset(Vector movedSinceLastUpdate)
        {
            if (!movedSinceLastUpdate.Equals(Vector.zero))
            {
                goUserXr.goPositionUnity += goUserXr.goRotationUnity.Value * movedSinceLastUpdate * 2;
                OnCamTransformChanged(); // HMD movement also counts as player movement
            }
        }
        
        public void alignCamera()
        {
            Vector rotEuler = goUserXr.goRotationUnity.Value.ToEulerAngles();
            rotEuler.x = 0;
            rotEuler.z = 0;
            Quaternion oldRotation = goUserXr.goRotationUnity.Value;
            goUserXr.goRotationUnity = Quaternion.Euler(rotEuler);
            if (oldRotation.Equals(goUserXr.goRotationUnity.Value))
            {
                OnCamTransformChanged();
            }
        }

        public void Update()
        {
            if (goUserXr.newRotation.HasValue)
            {
                Quaternion currentRotation = goUserXr.newRotation.Value;
                goUserXr.goRotationUnity = currentRotation;
                goUserXr.newRotation = null;
                lock(this) processRotation(Vector2.zero, currentRotation); // Process with zero input to apply the new rotation
                OnCamTransformChanged(); // External rotation change
            }
        }

        public void FixedUpdate()
        {
            float delta = Time.fixedDeltaTime;
            
            if (goUserXr.newPosition.HasValue)
            {
                goUserXr.goPositionUnity = goUserXr.newPosition.Value;
                goUserXr.newPosition = null;
                OnCamTransformChanged();
            }
            
            if (!isLockMovement()) processMove(delta); // processMove will call OnPlayerMovedOrRotated if applicable
            
            if (originFollowHeadMovement)
            {
                Vector movedSinceLastUpdate = calculateOffsets();
                followHmdOffset(movedSinceLastUpdate); // followHmdOffset will call OnPlayerMovedOrRotated if applicable
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
                OnCamTransformChanged();
            }
            else if (!isCrouching && crouchTimeElapsed < modelConfig.transitionTime)
            {
                var newHeight = Mathf.Lerp(crouchHeightStart, modelConfig.charHeight, crouchTimeElapsed / modelConfig.transitionTime);
                charaController.height = newHeight;
                crouchTimeElapsed += deltaTime;
                OnCamTransformChanged();
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
            // Unregister listeners if necessary, though CompLoader handles component lifecycle
        }

        public void OnActionRotPerformed(InputAction.CallbackContext context)
        {
            Vector2 rotationInput = context.ReadValue<Vector2>();
            if (!lockRotation && rotationInput != Vector2.zero)
            {
                Quaternion currentRotation = goUserXr.goRotationUnity.Value;
                lock(this) processRotation(rotationInput, currentRotation);
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

        public void RegisterOnTransformChange(Action action)
        {
            camTransformChangedHandler.Add(action);
        }

        public void UnregisterOnTransformChange(Action action)
        {
            camTransformChangedHandler.Remove(action);
        }

        public void setMouseInvert(bool value)
        {
            mouseInvert = value;
        }

        public void setMouseSpeed(ControlSettings.MouseSpeed value)
        {
            switch (value)
            {
                case ControlSettings.MouseSpeed.MIN:    mouseRotateFactor = 0.33f; break;
                case ControlSettings.MouseSpeed.SLOW:   mouseRotateFactor = 0.66f; break;
                case ControlSettings.MouseSpeed.MEDIUM: mouseRotateFactor = 1.0f;  break;
                case ControlSettings.MouseSpeed.HIGH:   mouseRotateFactor = 1.33f; break;
                case ControlSettings.MouseSpeed.MAX:    mouseRotateFactor = 1.66f; break;
            }
        }

        public bool isLockMovement() => lockMovement.Count > 0;
        public bool isLockTurn() => lockTurn;
        public void setLockTurn(bool value) => lockTurn = value;
        public void setLockRotation(bool value) => lockRotation = value;
        public void addLockMoveContext(IMovement.LockContext value) => lockMovement.Add(value);
        public void removeLockMoveContext(IMovement.LockContext value) => lockMovement.Remove(value);

        public void setHorizontalRotation(bool value) => horizontalRotation = value;
        public void setOriginFollowHeadMovement(bool value) => originFollowHeadMovement = value;
        public XROrigin getXrOrigin() => xrOrigin;

        public void applyModelConfig(IModelConfig config)
        {
            modelConfig = config;
            charaController = goUserXr.gameObject.GetComponent<CharacterController>();
            if (charaController == null) charaController = goUserXr.gameObject.AddComponent<CharacterController>();
            
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