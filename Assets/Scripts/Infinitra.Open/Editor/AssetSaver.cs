//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//

using System.IO;
using UnityEditor;
using UnityEngine;

namespace Infinitra.Open.Editor
{
    public class AssetSaver : UnityEditor.Editor
    {
    
        public static void Save(string name, Mesh mesh)
        {
            mesh.name = name;
        
            // Get the folder path of this script
            string scriptPath = AssetDatabase.GetAssetPath(MonoScript.FromScriptableObject(CreateInstance<AssetSaver>()));
            string directoryPath = Path.GetDirectoryName(scriptPath);
        
            // Create the asset in the same directory as the script
            string assetPath = Path.Combine(directoryPath, $"{name}.asset");
            AssetDatabase.CreateAsset(mesh, assetPath);
        
            // Focus the project window and select the new asset
            EditorUtility.FocusProjectWindow();
            Selection.activeObject = mesh;
        
        }
    }
}
