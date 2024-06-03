// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using UnityEngine;

namespace Infinitra.Tools
{
    public static class UnityTools
    {

        public static GameObject getChildGameObject(GameObject fromGameObject, string withName) {
            Transform[] ts = fromGameObject.transform.GetComponentsInChildren<Transform>();
            foreach (Transform t in ts) if (t.gameObject.name == withName) return t.gameObject;
            return null;
        }
        
        public static void enableLayer(Camera camera, int layerNum) {
            camera.cullingMask |= 1 << layerNum;
        }
        
        public static void disableLayer(Camera camera, int layerNum) {
            camera.cullingMask &= ~(1 << layerNum);
        }
    }
}