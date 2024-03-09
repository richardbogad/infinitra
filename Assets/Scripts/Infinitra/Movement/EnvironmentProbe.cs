// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using InfinitraCore.Utils;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.XR;

namespace Infinitra.Movement
{
    public class EnvironmentProbe : MonoBehaviour
    {
        public AudioReverbZone reverbZone;
        public CharacterController charaController;
        public GameObject deviceSimulator;

        public float maxDistance = 100f;

        [FormerlySerializedAs("avgProbeDistance")]
        public float medianDistance;

        public bool isGrounded;
        public bool initializing = true;
        public float DistanceUp;
        public float DistanceDown;
        public float DistanceLeft;
        public float DistanceRight;
        public float DistanceForward;
        public float DistanceBack;

        private void FixedUpdate()
        {
            ProbeEnvironment();
            AdjustReverb();
            var heightHalf = charaController.height * 0.6f;

            if (XRSettings.isDeviceActive) deviceSimulator.SetActive(false);

            if (initializing)
            {
                isGrounded = DistanceDown < 100.0f;
                if (isGrounded)
                    initializing = false;
                else
                    return;
            }
            else
            {
                isGrounded = DistanceDown < heightHalf;
            }
        }

        private void AdjustReverb()
        {
            var distanceFactor = medianDistance / maxDistance;
            reverbZone.decayTime = Mathf.Lerp(distanceFactor, 0.1f, 20.0f);
            reverbZone.reflectionsDelay = Mathf.Lerp(distanceFactor, 0.0f, 0.3f);
            reverbZone.reverbDelay = Mathf.Lerp(distanceFactor, 0.0f, 0.1f);
        }

        private void ProbeEnvironment()
        {
            // Assuming xrrigCamera is set to the camera within the XR Rig
            if (charaController == null) return;

            // Adjust directions based on camera orientation
            DistanceForward = CheckDistance(charaController.transform.forward);
            DistanceBack = CheckDistance(-charaController.transform.forward);
            DistanceRight = CheckDistance(charaController.transform.right);
            DistanceLeft = CheckDistance(-charaController.transform.right);
            DistanceUp = CheckDistance(charaController.transform.up);
            DistanceDown = CheckDistance(-charaController.transform.up);

            float[] distances =
                { DistanceUp, DistanceDown, DistanceLeft, DistanceRight, DistanceForward, DistanceBack };
            medianDistance = Calculation.calculateCappedMedian(distances, maxDistance);
        }

        private float CheckDistance(Vector3 direction)
        {
            RaycastHit hit;
            if (Physics.Raycast(charaController.transform.position, direction, out hit)) return hit.distance;
            return maxDistance; // Return a very large number if no object is hit
        }
    }
}