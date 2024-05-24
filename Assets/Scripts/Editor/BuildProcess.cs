// This code was initially taken from https://www.youtube.com/watch?v=WwAN60mICsQ
using System;
using System.IO;
using System.IO.Compression;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;
using UnityEngine;

public class BuildProcess : IPreprocessBuildWithReport, IPostprocessBuildWithReport
{

    public int callbackOrder => 0;
    public string dirBuildArchive = "./archive/";

    public void OnPreprocessBuild(BuildReport report)
    {
        string currentVersion = PlayerSettings.bundleVersion;

        string[] versionNumbers = ExtractVersionComponents(currentVersion);
        UpdateVersion(versionNumbers);
    }

    public void OnPostprocessBuild(BuildReport report)
    {
        string buildPath = report.summary.outputPath; // The output path of the build
        string projectName = PlayerSettings.productName; // The project name from the build settings
        string architecture = GetBuildArchitecture(report.summary.platform);
        string version = PlayerSettings.bundleVersion;
        string date = DateTime.Now.ToString("yyyyMMdd");
        string zipFileName = $"{projectName}_{version}_{architecture}_{date}.zip";
        
        string buildDirectory = Path.GetDirectoryName(buildPath);
        CreateZipArchive(buildDirectory, zipFileName);
    }

    private string[] ExtractVersionComponents(string version)
    {
        // Regular expression pattern to match version components
        string pattern = @"([0-9]+)\.([0-9]+)\.([0-9]+)";
        Regex regex = new Regex(pattern);
        Match match = regex.Match(version);

        if (match.Success)
        {
            // Extract the year, release, and build components as strings
            string year = match.Groups[1].Value;
            string release = match.Groups[2].Value;
            string build = match.Groups[3].Value;

            // Return the components as a string array
            return new string[] { year, release, build };
        }
        else
        {
            // Return null or an empty array if the version string does not match the pattern
            return null; // Or return new string[0]; depending on your error handling preference
        }
    }

    private void UpdateVersion(string[] versionNumbers)
    {
        // Split the version string into its components
        if (versionNumbers != null && versionNumbers.Length == 3)
        {
            // Parse the year, release, and build components
            if (int.TryParse(versionNumbers[0], out int year) &&
                int.TryParse(versionNumbers[1], out int release) &&
                int.TryParse(versionNumbers[2], out int build))
            {
                // Increment the build number
                build++;

                // Reconstruct the version string with the new build number
                string newVersion = $"{year}.{release}.{build}";

                // Optional: Update the version format if you want to include a date or other information
                string date = DateTime.Now.ToString("yyyyMMdd");
                PlayerSettings.bundleVersion = $"v{newVersion}";

                // Log the new version
                Debug.Log(PlayerSettings.bundleVersion);
            }
            else
            {
                Debug.LogError("Failed to parse version components");
            }
        }
        else
        {
            Debug.LogError("Invalid version format");
        }
    }

    private string GetBuildArchitecture(BuildTarget target)
    {
        switch (target)
        {
            case BuildTarget.StandaloneWindows:
            case BuildTarget.StandaloneWindows64:
                return "win64";
            case BuildTarget.StandaloneOSX:
                return "osx";
            case BuildTarget.StandaloneLinux64:
                return "linux64";
            // Add more cases as needed for other platforms
            default:
                return "unknown";
        }
    }

    private void CreateZipArchive(string buildPath, string zipFileName)
    {
        if (Directory.Exists(buildPath))
        {

            if (!Directory.Exists(dirBuildArchive))
            {
                Directory.CreateDirectory(dirBuildArchive);
            }
            
            string outputPath = Path.Combine(dirBuildArchive, zipFileName);
            if (File.Exists(outputPath))
            {
                File.Delete(outputPath); // Delete existing zip file if it exists
            }
            ZipFile.CreateFromDirectory(buildPath, outputPath);
            Debug.Log($"Build archived at {outputPath}");
        }
        else
        {
            Debug.LogError($"Build directory not found: {buildPath}");
        }
    }
}
