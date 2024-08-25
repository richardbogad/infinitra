// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using InfinitraCore.Calculation;
using UnityEngine;

namespace Infinitra.Movement
{
    public class EnvironmentProbe : MonoBehaviour
    {

        public float maxDistance = 100f;

        public float medianDistance;

        public float DistanceUp;
        public float DistanceDown;
        public float DistanceLeft;
        public float DistanceRight;
        public float DistanceForward;
        public float DistanceBack;

        private AudioReverbZone reverbZone;

        private Camera camera;
        
        private void Awake()
        {
            camera = GetComponentInChildren<Camera>();
            reverbZone = GetComponent<AudioReverbZone>();
        }
        
        private void FixedUpdate()
        {
            ProbeEnvironment();
            AdjustReverb();
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
            if (camera == null) return;

            // Adjust directions based on camera orientation
            DistanceForward = CheckDistance(camera.transform.forward);
            DistanceBack = CheckDistance(-camera.transform.forward);
            DistanceRight = CheckDistance(camera.transform.right);
            DistanceLeft = CheckDistance(-camera.transform.right);
            DistanceUp = CheckDistance(camera.transform.up);
            DistanceDown = CheckDistance(-camera.transform.up);

            float[] distances =
                { DistanceUp, DistanceDown, DistanceLeft, DistanceRight, DistanceForward, DistanceBack };
            medianDistance = Various.calculateCappedMedian(distances, maxDistance);
        }

        private float CheckDistance(Vector3 direction)
        {
            RaycastHit hit;
            if (Physics.Raycast(camera.transform.position, direction, out hit)) return hit.distance;
            return maxDistance; // Return a very large number if no object is hit
        }
    }
}