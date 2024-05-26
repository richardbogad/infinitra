// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;
using Debug = UnityEngine.Debug;

public class BuildProcess : IPreprocessBuildWithReport, IPostprocessBuildWithReport
{
    public int callbackOrder => 0;
    public string dirBuildArchive = "./archive/";

    private string obfuscarPath = "../infinitra-core/buildtools/Obfuscar.Console.exe";
    private string buildToolsPath = "../infinitra-core/buildtools/";
    private string projectDir = "./";

    public void OnPreprocessBuild(BuildReport report)
    {
        string currentVersion = PlayerSettings.bundleVersion;

        string[] versionNumbers = ExtractVersionComponents(currentVersion);
        UpdateVersion(versionNumbers);
        
        RmFile(Path.Combine(projectDir, "Assets/Plugins/InfinitraCore.dll"));
    }

    public void OnPostprocessBuild(BuildReport report)
    {
        string buildPath = report.summary.outputPath;
        string projectName = PlayerSettings.productName;
        string architecture = GetBuildArchitecture(report.summary.platform);
        string version = PlayerSettings.bundleVersion;
        string date = DateTime.Now.ToString("yyyyMMdd");

        string buildDirectory = Path.GetDirectoryName(buildPath);

        ExecuteExecutable(obfuscarPath, Path.Combine(buildToolsPath, "obfuscar.xml"), projectDir);
        CopyFile(Path.Combine(buildDirectory, "infinitra_Data/Managed/Obfuscated/InfinitraCore.dll"), Path.Combine(buildDirectory, "infinitra_Data/Managed/InfinitraCore.dll"));
        //CopyFile(Path.Combine(buildDirectory, "infinitra_Data/Managed/InfinitraCore.dll"), Path.Combine(projectDir, "Assets/Plugins/InfinitraCore.dll"));
        RmDir(Path.Combine(buildDirectory, "infinitra_Data/Managed/Obfuscated"));
        
        string zipFileName = $"{projectName}_{version}_{architecture}_{date}.zip";
        CreateZipArchive(buildDirectory, zipFileName);
    }

    public static void CopyFile(string fromFile, string toDestination)
    {
        try
        {
            if (!File.Exists(fromFile))
            {
                throw new FileNotFoundException($"Source file not found: {fromFile}");
            }

            string destDirectory = Path.GetDirectoryName(toDestination);

            if (!Directory.Exists(destDirectory))
            {
                Directory.CreateDirectory(destDirectory);
            }

            File.Copy(fromFile, toDestination, overwrite: true);

            Debug.Log($"File copied from {fromFile} to {toDestination}");
        }
        catch (Exception ex)
        {
            Debug.LogError($"Failed to copy file from {fromFile} to {toDestination}: {ex.Message}");
            throw;
        }
    }
    public static void RmFile(string filePath, bool stopOnError = false)
    {
        try
        {
            if (!File.Exists(filePath))
            {
                throw new FileNotFoundException($"File not found: {filePath}");
            }

            File.Delete(filePath);

            Debug.Log($"File {filePath} deleted");
        }
        catch (Exception ex)
        {

            if (stopOnError)
            {
                Debug.LogError($"Failed to delete file {filePath}: {ex.Message}");
                throw;
            }
            
            Debug.LogWarning($"Failed to delete file {filePath}: {ex.Message}");
        }
    }
    
    public static void RmDir(string directory)
    {
        try
        {
            if (!Directory.Exists(directory))
            {
                throw new DirectoryNotFoundException($"Source directory not found: {directory}");
            }

            Directory.Delete(directory, true);

            Debug.Log($"Directory {directory} deleted");
        }
        catch (Exception ex)
        {
            Debug.LogError($"Failed to delete directory {directory}: {ex.Message}");
            throw;
        }
    }
    
    public static string ExecuteExecutable(string executablePath, string arguments, string workingDirectory)
    {
        try
        {
            Process process = new Process();
            process.StartInfo.FileName = executablePath;
            process.StartInfo.Arguments = arguments;
            process.StartInfo.WorkingDirectory = workingDirectory;
            process.StartInfo.RedirectStandardOutput = true;
            process.StartInfo.RedirectStandardError = true;
            process.StartInfo.UseShellExecute = false;
            process.StartInfo.CreateNoWindow = true;

            process.Start();

            string output = process.StandardOutput.ReadToEnd();
            string error = process.StandardError.ReadToEnd();

            process.WaitForExit();

            if (!string.IsNullOrEmpty(error))
            {
                return $"Error: {error}";
            }

            return output;
        }
        catch (Exception ex)
        {
            return $"Exception: {ex.Message}";
        }
    }

    private string[] ExtractVersionComponents(string version)
    {
        string pattern = @"([0-9]+)\.([0-9]+)\.([0-9]+)";
        Regex regex = new Regex(pattern);
        Match match = regex.Match(version);

        if (match.Success)
        {
            string year = match.Groups[1].Value;
            string release = match.Groups[2].Value;
            string build = match.Groups[3].Value;
            return new string[] { year, release, build };
        }
        else
        {
            return null;
        }
    }

    private void UpdateVersion(string[] versionNumbers)
    {
        if (versionNumbers != null && versionNumbers.Length == 3)
        {
            if (int.TryParse(versionNumbers[0], out int year) &&
                int.TryParse(versionNumbers[1], out int release) &&
                int.TryParse(versionNumbers[2], out int build))
            {
                build++;
                string newVersion = $"{year}.{release}.{build}";
                string date = DateTime.Now.ToString("yyyyMMdd");
                PlayerSettings.bundleVersion = $"v{newVersion}";

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
                File.Delete(outputPath);
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
