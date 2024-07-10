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

        public AudioClip[] footstepSounds;
        public AudioClip[] teleportMode;
        public AudioClip[] teleportModeCancel; 
        public AudioClip[] teleportSelect; 
        public AudioClip[] teleportEnqueue;
        public AudioClip[] teleporting;
        
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
            audioSourceLoop.volume = 0.1f;
            audioSourceLoop.loop = true;
            movement = GetComponentInParent<Movement>();
            probe = GetComponentInParent<EnvironmentProbe>();
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
            AudioClip[] footstepSounds = this.footstepSounds;
            AudioSource audioSource = this.audioSource;
            
            playSound(footstepSounds, audioSource);
        }

        private static void playSound(AudioClip[] footstepSounds, AudioSource audioSource)
        {
            if (footstepSounds.Length > 0)
            {
                // Randomly select a footstep sound to play
                var index = Random.Range(0, footstepSounds.Length);
                audioSource.clip = footstepSounds[index];
                audioSource.Play();
            }
        }

        public void PlayTeleportModeStart(InputAction.CallbackContext context)
        {
            playSound(teleportMode, audioSource);
        }
        
        public void PlayTeleportCancel(InputAction.CallbackContext context)
        {
            playSound(teleportModeCancel, audioSource);
        }
        
        public void PlayTeleportSelectEntered(SelectEnterEventArgs arg0)
        {
            playSound(teleportSelect, audioSourceLoop);
            teleportSelectionValid = true;
        }
        
        public void PlayTeleportSelectExited(SelectExitEventArgs arg0)
        {
            audioSourceLoop.Stop();
            teleportSelectionValid = false;
        }

        public void PlayTeleportModeStop(InputAction.CallbackContext context)
        {
            if (teleportSelectionValid) playSound(teleportEnqueue, audioSource);
        }
        
        public void PlayTeleporting(LocomotionProvider locomotionProvider)
        {
            playSound(teleporting, audioSource);
        }
    }
}