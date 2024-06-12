// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System.Collections.Generic;
using Infinitra.Tools;
using InfinitraCore.WorldAPI;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.UI;

namespace Infinitra.WorldDef
{
    public class FractalMain : MonoBehaviour
    {
        // TODO look up dependencies automatically
        public XROrigin xrOrigin;
        public Camera camera;
        public Slider loadingSlider;
        public Movement.Movement movement;
        public GameObject deviceSimulator;

        private readonly List<IBlockManager> blockManagers = new();

        private bool loading = true;
        Canvas canvasLoading;
        
        private async void Start()
        {
            HardwareBenchmark benchmark = new HardwareBenchmark();

            await benchmark.RunBenchmarksAsync();

            IBlockManager blockManager = createBlockManager(benchmark.cpuScore);
            blockManagers.Add(blockManager);

            foreach (var bm in blockManagers) bm.run();

            canvasLoading = UnityTools.getObjectByName<Canvas>("Canvas Loading");
            UnityTools.showCanvas(camera, canvasLoading);
        }

        private void Update()
        {
            float totalPercentageCalculated = 0.0f;

            foreach (var bm in blockManagers)
            {
                bm.updateCamPos(xrOrigin.transform.position);
                bm.workOnMainThread();
                totalPercentageCalculated += bm.getPercentageCalculated();
            }

            if (blockManagers.Count > 0)
                totalPercentageCalculated /= blockManagers.Count; // TODO average calc. is not right

            Debug.Log("Block calculation status: " + totalPercentageCalculated);

            if (loading)
            {
                float loadingProgress = Mathf.Sqrt(Mathf.Clamp01(totalPercentageCalculated / 0.02f));
                loadingSlider.value = loadingProgress;

                if (loadingProgress >= 1.0f)
                {
                    loading = false;
                    Debug.Log("Block calculation status reached loading goal: " + totalPercentageCalculated);
                    
                    UnityTools.hideCanvas(camera, canvasLoading);
                    movement.enabled = true;
                }
            }
            
            // TODO think about XRSettings.isDeviceActive 

        }

        
        private void OnApplicationQuit()
        {
            Debug.Log("Main exit after " + Time.time + " seconds.");
            foreach (var bm in blockManagers) bm.exit();
        }


        private IBlockManager createBlockManager(float cpuScore)
        {
            BlockCreatorDefs blockCreatorDef = new();
            blockCreatorDef.addCalcLayer(CalcLayer.FRACTAL_VIS);
            //blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_SECTIONIZER);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_TREE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_STRIPTOP);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_FENCE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_LIGHT);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_STRIPBOTTOM);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_PIPE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_GRASS);
            //blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_ROOF);

            float smallestBlockSize = 16.0f;
            IBlockManager blockManager;
            if (cpuScore > 400.0)
            {
                blockManager = BlockManagerFactory.getBlockManager(10.0f, smallestBlockSize, 16, 4, 5,
                    smallestBlockSize*2, 1000, blockCreatorDef, 5);
            }
            else if (cpuScore > 300.0)
            {
                blockManager = BlockManagerFactory.getBlockManager(10.0f, smallestBlockSize, 16, 3, 5,
                    smallestBlockSize*2, smallestBlockSize*3, blockCreatorDef, 5);
            }
            else if (cpuScore > 200.0)
            {
                blockManager = BlockManagerFactory.getBlockManager(10.0f, smallestBlockSize, 16, 2, 5,
                    smallestBlockSize*2, smallestBlockSize*3, blockCreatorDef, 5);
            }
            else
            {
                blockManager = BlockManagerFactory.getBlockManager(10.0f, smallestBlockSize, 16, 2, 4,
                    smallestBlockSize*2, smallestBlockSize*3, blockCreatorDef, 5);
            }

            return blockManager;

        }
    }
}