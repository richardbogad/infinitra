// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System.Collections.Generic;
using Infinitra.Movement;
using Infinitra.Objects;
using InfinitraCore.Components;
using InfinitraCore.Controllers;
using InfinitraCore.Objects;
using Unity.XR.CoreUtils;
using UnityEngine;

namespace Infinitra.WorldDef
{
    public class InfinitraMain : MonoBehaviour
    {
        private XROrigin xrOrigin;
        private bool started;
        private IWorldController worldController;
        private ObjectVisualizer objectVisualizer;

        // Component Initialization Step
        private void Awake()
        {
            GameObject goXrOrigin = AssetTools.getInGameObjectByName<GameObject>("XR Origin (XR Rig)");
            xrOrigin = goXrOrigin.GetComponent<XROrigin>();
        }
        
        // Component Linking and Registration Step
        private void OnEnable()
        {
            CompLoader.registerXrOrigin(xrOrigin);
            worldController = CompLoader.getWorldController();
            objectVisualizer = new ObjectVisualizer(new GameObjectFactory());
        }

        // Routine Startup Step
        private void Start()
        {
            CompLoader.start();
            started = true;
        }

        // Recurrent Calculation Step
        private void Update()
        {
            if (!started) return;

            CompLoader.update(Time.deltaTime);

            Dictionary<string, ObjectInfo> userPositions = worldController.getObjectInfos();
            objectVisualizer.UpdateObjects(userPositions, Time.deltaTime);
        }

        // Shutdown Step
        private void OnApplicationQuit()
        {
            CompLoader.onQuit();
            Debug.LogFormat("Main exit after {0} seconds.", Time.time);
        }
    }
}