// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using InfinitraCore.Calculation;
using UnityEngine;

namespace Infinitra.Movement
{
    public class EnvironmentProbe : MonoBehaviour
    {

        private static readonly float COLL_EPSILON = 0.1f;
        
        public float maxDistance = 100f;

        public float medianDistance;

        public bool collisionDown;
        public bool collisionUp;
        
        public float DistanceUp;
        public float DistanceDown;
        public float DistanceLeft;
        public float DistanceRight;
        public float DistanceForward;
        public float DistanceBack;
        
        private CharacterController charaController;
        private AudioReverbZone reverbZone;
        private bool initializing = true;
        
        private void Awake()
        {
            charaController = GetComponent<CharacterController>();
            reverbZone = GetComponent<AudioReverbZone>();
        }
        
        private void FixedUpdate()
        {
            ProbeEnvironment();
            AdjustReverb();


            if (initializing)
            {
                collisionDown = DistanceDown < 100.0f;
                if (collisionDown)
                    initializing = false;
                else return;
            }
            else
            {
                collisionDown = DistanceDown < COLL_EPSILON;
            }
            
            collisionUp = DistanceUp < charaController.height + COLL_EPSILON;
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
            medianDistance = Various.calculateCappedMedian(distances, maxDistance);
        }

        private float CheckDistance(Vector3 direction)
        {
            RaycastHit hit;
            if (Physics.Raycast(charaController.transform.position, direction, out hit)) return hit.distance;
            return maxDistance; // Return a very large number if no object is hit
        }
    }
}