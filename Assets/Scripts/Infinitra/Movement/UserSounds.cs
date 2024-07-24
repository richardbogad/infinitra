// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using InfinitraCore.WorldAPI;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.XR.Interaction.Toolkit;
using UnityEngine.XR.Interaction.Toolkit.Locomotion;
using Random = UnityEngine.Random;

namespace Infinitra.Movement
{
    [RequireComponent(typeof(AudioSource))]
    public class UserSounds : MonoBehaviour, IUserSounds
    {

        private readonly SoundClips footstepSounds = new();
        private readonly SoundClips teleportMode = new();
        private readonly SoundClips teleportModeCancel = new();
        private readonly SoundClips teleportSelect = new();
        private readonly SoundClips teleportEnqueue = new();
        private readonly SoundClips teleporting = new();
        
        
        public float speedThreshold = 1.0f;
        public float stepIntervalBase = 2.0f;
        public float speedIntervalDouble = 3.0f;
        
        private float groundedTimer;
        private float stepTimer;
        
        private AudioSource audioSource;
        private AudioSource audioSourceLoop;
        private Movement movement;
        private EnvironmentProbe probe;

        private bool teleportSelectionValid;
        
        private void Awake()
        {
            AudioSource[] audioSources = GetComponents<AudioSource>();
            audioSource = audioSources[0];
            audioSourceLoop = audioSources[1];

            movement = GetComponentInParent<Movement>();
            probe = GetComponentInParent<EnvironmentProbe>();
            
            footstepSounds.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step0", 0.7f, false);
            footstepSounds.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step1", 0.7f, false);
            footstepSounds.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step2", 0.7f, false);
            footstepSounds.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step3", 0.7f, false);
            footstepSounds.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step4", 0.7f, false);
            footstepSounds.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step5", 0.7f, false);
            footstepSounds.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step6", 0.7f, false);
            footstepSounds.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step7", 0.7f, false);
            footstepSounds.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step8", 0.7f, false);
            footstepSounds.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step9", 0.7f, false);
            
            teleportMode.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_12", 0.5f, false);
            teleportMode.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_13", 0.5f, false);
            teleportMode.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_15", 0.5f, false);
            
            teleportModeCancel.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_09", 0.5f, false);
            teleportModeCancel.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_14", 0.5f, false);
            
            teleportSelect.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_03", 0.02f, true, pitch: 2.0f);
            
            teleportEnqueue.addSound("Sounds/SpaceSFX/lowpitch/noise/noise03", 0.7f, false);
            teleporting.addSound("Sounds/SpaceSFX/lowpitch/hit/hit12", 0.7f, false);
            
            footstepSounds.load();
            teleportMode.load();
            teleportModeCancel.load();
            teleportSelect.load();
            teleportEnqueue.load();
            teleporting.load();
        }

        private void OnEnable()
        {
            CompLoader.userContr.setUserSoundScript(this);
        }

        private void Update()
        {
            processFootStepSounds();
        }

        private void processFootStepSounds()
        {
            var moveVector = new Vector3(movement.moveVector.x, 0.0f, movement.moveVector.z);
            var speed = moveVector.magnitude;

            // Adjust the stepTimer based on the character's speed
            stepTimer -= Time.deltaTime * speed;
            groundedTimer -= Time.deltaTime;

            groundedTimer = Mathf.Clamp01(groundedTimer);

            if (probe.collisionDown)
            {
                if (groundedTimer == 0.0f)
                {
                    PlayFootstepSound();
                }
                else if (speed > speedThreshold && stepTimer <= 0)
                {
                    // Reset the timer based on speed, with a minimum threshold to prevent steps from being too rapid
                    PlayFootstepSound();
                    stepTimer = stepIntervalBase / (2.0f * speed / speedIntervalDouble);
                }

                groundedTimer += 1.0f;
            }
        }

        private void PlayFootstepSound()
        {
            footstepSounds.playSound(audioSource);
        }

        public void PlayTeleportModeStart(InputAction.CallbackContext context)
        {
            teleportMode.playSound(audioSource);
        }
        
        public void PlayTeleportCancel(InputAction.CallbackContext context)
        {
            teleportModeCancel.playSound(audioSource);
        }
        
        public void PlayTeleportSelectEntered(SelectEnterEventArgs arg0)
        {
            teleportSelect.playSound(audioSourceLoop);
            teleportSelectionValid = true;
        }
        
        public void PlayTeleportSelectExited(SelectExitEventArgs arg0)
        {
            audioSourceLoop.Stop();
            teleportSelectionValid = false;
        }

        public void PlayTeleportModeStop(InputAction.CallbackContext context)
        {
            if (teleportSelectionValid) teleportEnqueue.playSound(audioSource);
        }
        
        public void PlayTeleporting(LocomotionProvider locomotionProvider)
        {
            teleporting.playSound(audioSource);
        }
    }
}