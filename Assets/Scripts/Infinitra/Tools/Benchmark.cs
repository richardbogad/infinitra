// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using InfinitraCore.Objects;
using UnityEngine;
using UnityEngine.Rendering;
using Debug = UnityEngine.Debug;

internal class HardwareBenchmark
{
    internal float cpuScore = -1;
    internal float gpuScore = -1;
    internal float cpuTime = -1;
    internal float gpuTime = -1;
    
    internal void RunBenchmarksAsync()
    {
        CPUBenchmarkAsync();
        GPUBenchmarkAsync();
        Debug.Log($"PERF measurement, CPU: {cpuScore} in {cpuTime}ms, GPU: {gpuScore} in {gpuTime}ms");
    }

    private void CPUBenchmarkAsync()
    {
        // Results in ~1000 for a AMD Ryzen 9 7900
        
        Stopwatch sw = new Stopwatch();
        sw.Start();

        float result = 0;
        for (int i = 0; i < 1000000; i++)
        {
            result += Mathf.Sqrt(i);
        }
        sw.Stop();
        cpuTime = (float)sw.Elapsed.TotalMilliseconds;
        cpuScore = 1000 * Environment.ProcessorCount / cpuTime;
    }

    private void GPUBenchmarkAsync()
    {
        // Results in ~1000 for a GeForce RTX 4060 Ti
        
        ComputeShader computeShader = Resources.Load<ComputeShader>("Shaders/GPUBenchmark");
 
        int maxThreadsX = SystemInfo.maxComputeWorkGroupSizeX;
        int maxThreadsY = SystemInfo.maxComputeWorkGroupSizeY;
        int maxThreadsZ = SystemInfo.maxComputeWorkGroupSizeZ;

        List<float> times = new();
        
        for (int i = 0; i < 10; i++)
        {
            Stopwatch stopwatch = new();

            stopwatch.Start();

            ComputeBuffer resultBuffer = new(1, sizeof(uint));
            uint[] resultData = new uint[1];

            computeShader.SetBuffer(0, "result", resultBuffer);

            computeShader.SetInt("numthreads_x", maxThreadsX);
            computeShader.SetInt("numthreads_y", maxThreadsY);
            computeShader.SetInt("numthreads_z", maxThreadsZ);

            computeShader.Dispatch(0, maxThreadsX, maxThreadsY, maxThreadsZ);
            resultBuffer.GetData(resultData);
            
            resultBuffer.Release();
            
            stopwatch.Stop();
            
            times.Add((float)stopwatch.Elapsed.TotalMilliseconds);
        }
        
        gpuTime = times.Average();
        gpuScore = (maxThreadsX * maxThreadsY * maxThreadsZ) / gpuTime / 600;

        // Release the buffer

    }
}