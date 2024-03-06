using UnityEngine;

public class AnimRotation : MonoBehaviour
{
    public Vector3 rotEuler = new Vector3(0, 1, 0);
    public float rotationSpeed = 10f;
    public bool globalRotation = true;
    private Quaternion _rotInitial = Quaternion.identity;
    private Quaternion _rotGlobal = Quaternion.identity;

    void Start()
    {
        _rotInitial = gameObject.transform.rotation; // Take the initial rotation
    }

    void Update()
    {
        Quaternion rotDelta = Quaternion.Euler(rotEuler * (rotationSpeed * Time.deltaTime));
        if (globalRotation)
        {
            _rotGlobal *= rotDelta;
            gameObject.transform.rotation = _rotGlobal * _rotInitial;
        }
        else
        {
            gameObject.transform.rotation *= rotDelta;
        }
    }
}