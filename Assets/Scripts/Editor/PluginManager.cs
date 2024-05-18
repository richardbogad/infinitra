// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using UnityEditor;
using UnityEngine;
using System.IO;

[InitializeOnLoad]
public static class DllAsmdefManager
{
    
    static DllAsmdefManager()
    {
        string dllPath = "Assets/Plugins/InfinitraCore.dll";
        string asmdefPath = "Assets/Scripts/InfinitraCore/InfinitraCore.asmdef";

        // Check if DLL exists
        bool dllExists = File.Exists(dllPath);

        // Load and modify the ASMDEF file
        string json = File.ReadAllText(asmdefPath);
        AsmdefFile asmdef = JsonUtility.FromJson<AsmdefFile>(json);
        
        // Toggle autoReferenced based on DLL presence
        asmdef.autoReferenced = !dllExists; // Disable auto-referencing if DLL exists, enable if it doesn't

        // Write changes back to the ASMDEF file
        File.WriteAllText(asmdefPath, JsonUtility.ToJson(asmdef, true));

        // Refresh the Asset Database
        AssetDatabase.Refresh();
    }

    private class AsmdefFile
    {
        public string name;
        public string rootNamespace;
        public string[] references;
        public string[] includePlatforms;
        public string[] excludePlatforms;
        public bool allowUnsafeCode;
        public bool overrideReferences;
        public string[] precompiledReferences;
        public bool autoReferenced;
        public string[] defineConstraints;
        public string[] versionDefines;
        public bool noEngineReferences;

    }
}