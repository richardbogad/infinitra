// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System.IO;
using UnityEditor;
using UnityEngine;

public class AssetSaver : Editor
{
    
    public static void Save(string name, Mesh mesh)
    {
        mesh.name = name;
        
        // Get the folder path of this script
        string scriptPath = AssetDatabase.GetAssetPath(MonoScript.FromScriptableObject(ScriptableObject.CreateInstance<AssetSaver>()));
        string directoryPath = Path.GetDirectoryName(scriptPath);
        
        // Create the asset in the same directory as the script
        string assetPath = Path.Combine(directoryPath, $"{name}.asset");
        AssetDatabase.CreateAsset(mesh, assetPath);
        
        // Focus the project window and select the new asset
        EditorUtility.FocusProjectWindow();
        Selection.activeObject = mesh;
        
    }
}
