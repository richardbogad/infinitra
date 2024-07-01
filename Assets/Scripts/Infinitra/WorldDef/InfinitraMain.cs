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

        private IBlockManager blockManager;

        private bool awakened = false;

        private XROrigin xrOrigin;
        private Movement.Movement movement;
        private Camera camera;


        private void OnEnable()
        {
            menuAction.action.started += Instances.userContr.showMenu;
        }

        private void Awake()
        {

            GameObject goXrOrigin = AssetTools.getInGameObjectByName<GameObject>("XR Origin");
            xrOrigin = goXrOrigin.GetComponent<XROrigin>();
            movement = goXrOrigin.GetComponent<Movement.Movement>();
            camera = AssetTools.getInGameObjectByName<Camera>("Main Camera");

            Instances.mainThreadQueue = Instances.mainThreadQueue;
            Instances.uiVisualizer.registerXrOrigin(xrOrigin);


            HardwareBenchmark benchmark = new HardwareBenchmark();

            benchmark.RunBenchmarksAsync();

            blockManager = createBlockManager(benchmark.cpuScore, benchmark.gpuScore);
            blockManager.run();

            Instances.userContr.initialize(xrOrigin, blockManager);

            awakened = true;
        }
        
        private void FixedUpdate()
        {
            if (!awakened) return;
            
            blockManager.fixedUpdate(Time.deltaTime);
        }
        private void Update()
        {
            if (!awakened) return;

            blockManager.updateCamPos(xrOrigin.transform.position);
            blockManager.workOnMainThread(Time.deltaTime);
            
            Instances.mainThreadQueue.mainThread();
            Instances.uiVisualizer.mainThread();
            Instances.userContr.mainThread();
        }


        private void OnApplicationQuit()
        {
            Debug.Log("Main exit after " + Time.time + " seconds.");
            blockManager?.exit();
            Instances.userContr.exit();
        }
        
        private DetailLevel GetDetailLevel(float score, float[] scoreThresholds, DetailLevel[] detailLevels, int[] valueThresholds, ref int value)
        {
            int i = detailLevels.Length-1;
            while (i > 0)
            {
                if (score > scoreThresholds[i]) break;
                i--;
            }                    
            
            value = Math.Min(valueThresholds[i], value);
            
            return detailLevels[i];
        }
        
        private IBlockManager createBlockManager(float cpuScore, float gpuScore)
        {
            int blockSizes = 5;
            
            BlockCreatorDefs blockCreatorDef = new();
            blockCreatorDef.addCalcLayer(CalcLayer.FRACTAL_VIS);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_TREE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_STRIPTOP);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_FENCE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_LIGHT);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_STRIPBOTTOM);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_PIPE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_GRASS);
            //blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_ROOF);

            float[] scoreThresholds = { 0.0f, 200.0f, 400.0f, 800.0f, 1600.0f };
            DetailLevel[] detailLevels = 
            {
                DetailLevel.MINIMUM, DetailLevel.LOW, DetailLevel.MEDIUM, DetailLevel.HIGH, DetailLevel.ULTRA
            };
            int[] blockSizeThresholds = { 1, 2, 3, 4, 5 };
            
            DetailLevel cpuPerf = GetDetailLevel(cpuScore, scoreThresholds, detailLevels, blockSizeThresholds, ref blockSizes);
            DetailLevel gpuPerf = GetDetailLevel(gpuScore, scoreThresholds, detailLevels, blockSizeThresholds, ref blockSizes);
            
            Debug.Log($"PERF CPU perf. {cpuPerf}, GPU {gpuPerf}, blockSize {blockSizes}");

            float smallestBlockSize = 16.0f;
            IBlockManager blockManager;

            blockManager = ObjectFactory.getBlockManager(10.0f, smallestBlockSize, 16, blockSizes, 5,
                    smallestBlockSize*2, smallestBlockSize*16, blockCreatorDef, 5);

            return blockManager;

        }
    }
}