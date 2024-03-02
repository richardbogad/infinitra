/** 
 * INFINITRA © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0. 
 * To view a copy of this license,
 * visit http://creativecommons.org/licenses/by-nc-sa/4.0/
 */

using System.Collections.Generic;
using System.Reflection;
using InfinitraCore.Rendering;
using InfinitraCore.Threading;
using InfinitraCore.WorldAPI;
using UnityEngine;
using UnityEngine.UI;

namespace Infinitra.WorldDef
{
    
    public class FractalMain : MonoBehaviour
    {
        public Camera mainCamera;
        public List<CanvasFadeOut> canvasFadeOuts;
        public Slider loadingSlider;
        public Movement.Movement movement;
        
        private readonly List<IBlockManager> blockManagers = new();

        private MatMeshRenderer matMeshRenderer;
        private MainThreadDispatcher mainThreadDispatcher;
        
        private bool loading = true;


        async private void Start()
        {
            matMeshRenderer = MatMeshRenderService.getMatMeshRenderer();
            mainThreadDispatcher = MainThreadDispatcherService.getMainThreadDispatcher();
            
            HardwareBenchmark benchmark = new HardwareBenchmark();
            
            await benchmark.RunBenchmarksAsync();
            
            if (benchmark.cpuScore > 300) setupHQ(); // Reference PC: ~750
            else setupLQ();
            
            foreach (var bm in blockManagers) bm.run();
            
            mainCamera.cullingMask &= ~(1 << Settings.renderLayer);


        }

        private void setupLQ()
        {
            BlockCreatorDefs blockCreatorDef = new BlockCreatorDefs();
            blockCreatorDef.addCalcLayer(CalcLayer.FRACTAL_VIS);
            blockCreatorDef.addCalcLayer(CalcLayer.INTERACTORS);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_TREE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_GUIDE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_FENCE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_LIGHT);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_STRIP);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_CRYSTAL);

            List<IBlockManager.BlockOption> blockOptions = new() { };

            IBlockManager blockManager = BlockManagerFactory.getBlockManager(10.0f, "a", 20.0f, 20, 0.0f, 20.0f,
                blockCreatorDef, 10, blockOptions);
            blockManagers.Add(blockManager);
        }

        private void setupHQ()
        {
            BlockCreatorDefs blockCreatorDef = new BlockCreatorDefs();
            blockCreatorDef.addCalcLayer(CalcLayer.FRACTAL_VIS);
            blockCreatorDef.addCalcLayer(CalcLayer.INTERACTORS);
            //blockCreatorClose.addCalcLayer(CalcLayer.DETAIL_RCUBE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_TREE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_GUIDE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_FENCE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_LIGHT);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_STRIP);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_CRYSTAL);
                              
            List<IBlockManager.BlockOption> blockOptions = new() {};

            IBlockManager blockManager = BlockManagerFactory.getBlockManager(10.0f, "a", 20.0f, 20, 0.0f, 80.0f, blockCreatorDef, 10, blockOptions);
            blockManagers.Add(blockManager);
            
            blockOptions = new() {IBlockManager.BlockOption.CULLING_CELL};

            blockCreatorDef = new BlockCreatorDefs();
            blockCreatorDef.addCalcLayer(CalcLayer.FRACTAL_VIS);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_TREE);
            float minDist = 100.0f;
            float maxDist = 200.0f;

            blockManager = BlockManagerFactory.getBlockManager(10.0f, "bf", 20.0f, 20, minDist, maxDist, blockCreatorDef, 10,  blockOptions, Vector3.forward);
            blockManagers.Add(blockManager);

            blockManager = BlockManagerFactory.getBlockManager(10.0f, "bb", 20.0f, 20, minDist, maxDist, blockCreatorDef, 10, blockOptions, Vector3.back);
            blockManagers.Add(blockManager);

            blockManager = BlockManagerFactory.getBlockManager(10.0f, "bl", 20.0f, 20, minDist, maxDist, blockCreatorDef, 10, blockOptions, Vector3.left);
            blockManagers.Add(blockManager);

            blockManager = BlockManagerFactory.getBlockManager(10.0f, "br", 20.0f, 20, minDist, maxDist, blockCreatorDef, 10, blockOptions, Vector3.right);
            blockManagers.Add(blockManager);

            blockManager = BlockManagerFactory.getBlockManager(10.0f, "bu", 20.0f, 20, minDist, maxDist, blockCreatorDef, 10, blockOptions, Vector3.up);
            blockManagers.Add(blockManager);

            blockManager = BlockManagerFactory.getBlockManager(10.0f, "bd", 20.0f, 20, minDist, maxDist, blockCreatorDef, 10, blockOptions, Vector3.down);
            blockManagers.Add(blockManager);

            blockCreatorDef = new BlockCreatorDefs();
            blockCreatorDef.addCalcLayer(CalcLayer.FRACTAL_VIS);
            
            blockManager = BlockManagerFactory.getBlockManager(10.0f, "c", 80.0f, 20,200, 400.0f, blockCreatorDef, 10, blockOptions);
            blockManagers.Add(blockManager);
            
            blockCreatorDef = new BlockCreatorDefs();
            blockCreatorDef.addCalcLayer(CalcLayer.FRACTAL_VIS);
            
            blockManager = BlockManagerFactory.getBlockManager(10.0f, "d", 160.0f, 20,400.0f, 800.0f, blockCreatorDef, 10, blockOptions);
            blockManagers.Add(blockManager);
        }

        private void Update()
        {
            // execute blockmanager actions that require main thread execution

            float totalPercentageCalculated = 0.0f;
            
            foreach (var bm in blockManagers)
            {
                bm.updateCamPos(mainCamera.transform.position);
                totalPercentageCalculated += bm.getPercentageCalculated();
            }

            if (blockManagers.Count > 0) totalPercentageCalculated /= blockManagers.Count;

            Debug.Log("Block calculation status: "+  totalPercentageCalculated);
            
            if (loading)
            {
                float loadingProgress = Mathf.Sqrt(Mathf.Clamp01(totalPercentageCalculated / 0.01f));
                loadingSlider.value = loadingProgress;
                
                if (loadingProgress >= 1.0f)
                {
                    mainCamera.cullingMask |= 1 << Settings.renderLayer;
                    loading = false;
                    Debug.Log("Block calculation status reached loading goal: "+  totalPercentageCalculated);
                    foreach (CanvasFadeOut canvasFadeOut in canvasFadeOuts) canvasFadeOut.TriggerFadeOut();
                    movement.enabled = true;
                }
            }

            matMeshRenderer.Update();
            mainThreadDispatcher.Update();
        }

        private void OnApplicationQuit()
        {
            Debug.Log("Main exit after " + Time.time + " seconds.");
            foreach (var bm in blockManagers) bm.exit();
        }
    }
}