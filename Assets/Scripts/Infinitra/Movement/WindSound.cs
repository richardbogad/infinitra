// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using UnityEngine;
using UnityEngine.Serialization;

namespace Infinitra.Movement
{
    public class WindSound : MonoBehaviour
    {

        public float minDistance = 10f; // Minimum distance to start hearing the wind
        public float maxDistance = 200f; // Distance at which wind sound is at maximum volume
        public float volumeChangeSpeed = 0.3f; // Speed at which the volume changes

        public float doublePitchSpeed = 10.0f; // How much the pitch changes with speed
        public float fullVolumeSpeed = 10.0f; // How much the volume increases with speed, 10% per m/s
        
        private float currentVolume;
        private float targetVolume; // Target volume based on environment
        
        private EnvironmentProbe probe;
        private AudioSource audioSource;
        private Movement movement; // Reference to the Movement component

        private void Awake()
        {
            audioSource = GetComponent<AudioSource>();
            movement = GetComponentInParent<Movement>();
            probe = GetComponentInParent<EnvironmentProbe>();
        }
        
        private void Update()
        {
            // Adjust wind sound based on surrounding geometry and movement speed
            targetVolume = CalculateTargetVolume();

            // Smoothly interpolate wind sound volume towards the target volume
            currentVolume = Mathf.Lerp(currentVolume, targetVolume, Time.deltaTime * volumeChangeSpeed);

            audioSource.volume = currentVolume + movement.velocity.magnitude / fullVolumeSpeed;
            audioSource.pitch = 1 + movement.velocity.magnitude / doublePitchSpeed;
        }

        private float CalculateTargetVolume()
        {
            var averageDistance = probe.medianDistance;

            // Calculate target volume based on average distance
            return Mathf.Clamp01((averageDistance - minDistance) / (maxDistance - minDistance));
        }

    }
}