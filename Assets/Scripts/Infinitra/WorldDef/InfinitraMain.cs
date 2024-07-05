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
        
        public InputActionReference menuAction;
        
        private XROrigin xrOrigin;
        private Movement.Movement movement;
        private Camera camera;
        private bool started;
        private IBlockManager blockManager;

        // Component Initialization Step
        private void Awake()
        {
            ComponentLoader.awake();
            GameObject goXrOrigin = AssetTools.getInGameObjectByName<GameObject>("XR Origin");
            xrOrigin = goXrOrigin.GetComponent<XROrigin>();
            movement = goXrOrigin.GetComponent<Movement.Movement>();
            camera = AssetTools.getInGameObjectByName<Camera>("Main Camera");
        }
        
        // Component Linking and Registration Step
        private void OnEnable()
        {
            blockManager = ComponentLoader.blockManager;
            
            ComponentLoader.blockManager.registerXrOrigin(xrOrigin);
            ComponentLoader.uiVisualizer.registerXrOrigin(xrOrigin);
            ComponentLoader.userContr.registerXrOrigin(xrOrigin);
            menuAction.action.started += ComponentLoader.userContr.showMenu;
            
            ComponentLoader.onEnable();
        }

        // Routine Startup Step
        private void Start()
        {
            ComponentLoader.start();

            HardwareBenchmark benchmark = new HardwareBenchmark();
            benchmark.RunBenchmarksAsync();
            
            blockManager.changeQuality(benchmark.cpuScore, benchmark.gpuScore);
            
            started = true;
        }

        // Recurrent Calculation Step
        private void Update()
        {
            if (!started) return;

            ComponentLoader.update(Time.deltaTime);
        }

        // Shutdown Step
        private void OnDisable()
        {
            ComponentLoader.onDisable();
            Debug.Log("Main exit after " + Time.time + " seconds.");
        }
    }
}