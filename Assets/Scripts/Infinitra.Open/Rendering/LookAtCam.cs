//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//
using UnityEngine;

namespace Infinitra.Open.Rendering
{
    public class LookAtCam : MonoBehaviour
    {
        private Transform _cameraTransform;

        void Start()
        {
            _cameraTransform = Camera.main.transform;
        }

        void LateUpdate()
        {
            Vector3 directionToCamera = _cameraTransform.position - transform.position;

            directionToCamera.y = 0;

            // Set the rotation to face the camera
            transform.rotation = Quaternion.LookRotation(-directionToCamera);
        }
    }
}