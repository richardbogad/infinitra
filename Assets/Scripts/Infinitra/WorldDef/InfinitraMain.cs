// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System;
using InfinitraCore.Objects;
using InfinitraCore.WorldAPI;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.UI;

namespace Infinitra.WorldDef
{
    public class InfinitraMain : MonoBehaviour
    {
        // TODO look up dependencies automatically
  
        private XROrigin xrOrigin;
        private Movement.Movement movement;
        private Camera camera;
        private bool started;
        private IBlockManager blockManager;

        // Component Initialization Step
        private void Awake()
        {
            CompLoader.awake();
            GameObject goXrOrigin = AssetTools.getInGameObjectByName<GameObject>("XR Origin (XR Rig)");
            xrOrigin = goXrOrigin.GetComponent<XROrigin>();
            movement = goXrOrigin.GetComponent<Movement.Movement>();
            camera = AssetTools.getInGameObjectByName<Camera>("Main Camera");
        }
        
        // Component Linking and Registration Step
        private void OnEnable()
        {
            blockManager = CompLoader.blockManager;
            
            CompLoader.blockManager.registerXrOrigin(xrOrigin);
            CompLoader.uiVisualizer.registerXrOrigin(xrOrigin);
            CompLoader.userContr.registerXrOrigin(xrOrigin);
            
            CompLoader.onEnable();
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
        }

        // Shutdown Step
        private void OnDisable()
        {
            CompLoader.onDisable();
            Debug.LogFormat("Main exit after {0} seconds.", Time.time);
        }
    }
}