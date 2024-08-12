// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using UnityEngine;

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