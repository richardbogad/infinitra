// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System.Collections.Generic;
using InfinitraCore.Rendering;
using InfinitraCore.Threading;
using InfinitraCore.WorldAPI;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.UI;

namespace Infinitra.WorldDef
{
    public class FractalMain : MonoBehaviour
    {
        public XROrigin xrOrigin;
        public Camera mainCamera;
        public List<CanvasFadeOut> canvasFadeOuts;
        public Slider loadingSlider;
        public Movement.Movement movement;

        private readonly List<IBlockManager> blockManagers = new();

        private bool loading = true;
        private MainThreadDispatcher mainThreadDispatcher;

        private MatMeshRenderer matMeshRenderer;


        private async void Start()
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

        private void Update()
        {
            float totalPercentageCalculated = 0.0f;

            foreach (var bm in blockManagers)
            {
                bm.updateCamPos(xrOrigin.transform.position);
                totalPercentageCalculated += bm.getPercentageCalculated();
            }

            if (blockManagers.Count > 0)
                totalPercentageCalculated /= blockManagers.Count; // TODO average calc. is not right

            Debug.Log("Block calculation status: " + totalPercentageCalculated);

            if (loading)
            {
                float loadingProgress = Mathf.Sqrt(Mathf.Clamp01(totalPercentageCalculated / 0.05f));
                loadingSlider.value = loadingProgress;

                if (loadingProgress >= 1.0f)
                {
                    mainCamera.cullingMask |= 1 << Settings.renderLayer;
                    loading = false;
                    Debug.Log("Block calculation status reached loading goal: " + totalPercentageCalculated);
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

            List<IBlockManager.BlockOption> blockOptions = new();
            
            float blockSize = 20.0f;
            IBlockManager blockManager = BlockManagerFactory.getBlockManager(10.0f, blockSize, 20, 1, 3, blockSize*2, blockSize*3,
                blockCreatorDef, 5, blockOptions);
            blockManagers.Add(blockManager);
        }

        private void setupHQ()
        {
            BlockCreatorDefs blockCreatorDef = new BlockCreatorDefs();
            blockCreatorDef.addCalcLayer(CalcLayer.FRACTAL_VIS);
            blockCreatorDef.addCalcLayer(CalcLayer.INTERACTORS);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_SECTIONIZER);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_TREE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_GUIDE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_FENCE);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_LIGHT);
            blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_STRIP);
            // blockCreatorDef.addCalcLayer(CalcLayer.DETAIL_CRYSTAL);

            List<IBlockManager.BlockOption> blockOptions = new();

            float blockSize = 16.0f;
            IBlockManager blockManager = BlockManagerFactory.getBlockManager(10.0f, blockSize, 16, 4, 6, blockSize*2, blockSize*3,
                blockCreatorDef, 5, blockOptions);
            blockManagers.Add(blockManager);

            // blockOptions = new List<IBlockManager.BlockOption> { IBlockManager.BlockOption.CULLING_CELL };
            blockCreatorDef = new BlockCreatorDefs();
            blockCreatorDef.addCalcLayer(CalcLayer.FRACTAL_VIS);

        }
    }
}