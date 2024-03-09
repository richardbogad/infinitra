// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using UnityEngine;

namespace Infinitra.Movement
{
    [RequireComponent(typeof(AudioSource))]
    public class StepSound : MonoBehaviour
    {
        public Movement movement;
        public EnvironmentProbe probe;
        public AudioClip[] footstepSounds; // Array of footstep sound clips

        public float speedThreshold = 1.0f;
        public float stepIntervalBase = 2.0f; // Base interval between steps at normal speed
        public float speedIntervalDouble = 3.0f;

        private AudioSource audioSource;
        private float groundedTimer;
        private float stepTimer;

        private void Start()
        {
            audioSource = GetComponent<AudioSource>();
        }

        private void Update()
        {
            var moveVector = new Vector3(movement.moveVector.x, 0.0f, movement.moveVector.z);
            var speed = moveVector.magnitude;

            // Adjust the stepTimer based on the character's speed
            stepTimer -= Time.deltaTime * speed;
            groundedTimer -= Time.deltaTime;

            groundedTimer = Mathf.Clamp01(groundedTimer);

            if (probe.isGrounded)
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
            if (footstepSounds.Length > 0)
            {
                // Randomly select a footstep sound to play
                var index = Random.Range(0, footstepSounds.Length);
                audioSource.clip = footstepSounds[index];
                audioSource.Play();
            }
        }
    }
}