// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System;
using System.Diagnostics;
using System.Threading.Tasks;
using UnityEngine;
using Debug = UnityEngine.Debug;

internal class HardwareBenchmark
{
    internal float cpuScore = 0;
    internal float gpuScore = 0;

    internal async Task RunBenchmarksAsync()
    {
        await CPUBenchmarkAsync();
        await GPUBenchmarkAsync();
        Debug.Log($"CPU Score: {cpuScore}, GPU Score: {gpuScore}");
    }

    private async Task CPUBenchmarkAsync()
    {
        await Task.Run(() =>
        {
            Stopwatch sw = new Stopwatch();
            sw.Start();

            float result = 0;
            for (int i = 0; i < 1000000; i++)
            {
                result += Mathf.Sqrt(i);
            }

            sw.Stop();
            cpuScore = sw.ElapsedMilliseconds * Environment.ProcessorCount;
        });
    }

    private async Task GPUBenchmarkAsync()
    {
        // GPU benchmarking in a non-MonoBehaviour context is complex because Unity's rendering operations
        // are mainly designed to be used within the main thread. For a true GPU benchmark, you would need
        // to perform operations that are meaningful for your application, which might involve rendering
        // or manipulating textures in a way that's representative of your game's workload.

        // Placeholder for GPU benchmark - Implement based on specific needs
        gpuScore = -1; // Indicate that GPU benchmarking needs a different approach
    }
}