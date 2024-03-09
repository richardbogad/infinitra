// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using UnityEngine;

namespace Infinitra.Movement
{
    public class WindSound : MonoBehaviour
    {
        public EnvironmentProbe probe;
        public AudioSource windSound;
        public Movement movement; // Reference to the Movement component
        public float minDistance = 10f; // Minimum distance to start hearing the wind
        public float maxDistance = 200f; // Distance at which wind sound is at maximum volume
        public float volumeChangeSpeed = 0.3f; // Speed at which the volume changes

        public float doublePitchSpeed = 10.0f; // How much the pitch changes with speed
        public float fullVolumeSpeed = 10.0f; // How much the volume increases with speed, 10% per m/s
        private float currentVolume;

        private float targetVolume; // Target volume based on environment

        private void Update()
        {
            // Adjust wind sound based on surrounding geometry and movement speed
            AdjustAudioBasedOnEnvironment();

            // Smoothly interpolate wind sound volume towards the target volume
            currentVolume = Mathf.Lerp(currentVolume, targetVolume, Time.deltaTime * volumeChangeSpeed);

            windSound.volume = currentVolume + movement.moveVector.magnitude / fullVolumeSpeed;
            windSound.pitch = 1 + movement.moveVector.magnitude / doublePitchSpeed;
        }

        private void AdjustAudioBasedOnEnvironment()
        {
            var averageDistance = probe.medianDistance;

            // Calculate target volume based on average distance
            targetVolume = CalculateVolumeBasedOnDistance(averageDistance);
        }

        private float CalculateVolumeBasedOnDistance(float averageDistance)
        {
            return Mathf.Clamp01((averageDistance - minDistance) / (maxDistance - minDistance));
        }
    }
}