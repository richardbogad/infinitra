// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using InfinitraCore.WorldAPI;
using UnityEditor;
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
        
        private static void enableVisLayer(Camera camera, int layerNum) {
            camera.cullingMask |= 1 << layerNum;
        }
        
        private static void disableVisLayer(Camera camera, int layerNum) {
            camera.cullingMask &= ~(1 << layerNum);
        }
        
        public static void showCanvas(Camera camera, Canvas canvas)
        {
            disableVisLayer(camera, Settings.layerVisible);
            canvas.transform.position = camera.transform.position + new Vector3(0f, 0f, 10f);
        }
        
        public static void hideCanvas(Camera camera, Canvas canvas)
        {
            enableVisLayer(camera, Settings.layerVisible);
            CanvasFadeOut fadeOut = canvas.GetComponent<CanvasFadeOut>();
            fadeOut.TriggerFadeOut();
        }

        public static T getObjectByName<T>(string name) where T : Object
        {
            T[] objs = Object.FindObjectsByType<T>(FindObjectsSortMode.None);
            
            foreach (T obj in objs)
            {
                if (obj.name.Equals(name)) return obj;
            }
            return null;
        }
    }
}