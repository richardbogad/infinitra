using System;
using UnityEngine;
using UnityEditor;

public class CreateQuadMesh : Editor
{
    [MenuItem("Assets/Create/Quad", false, 10000)]
    public static void Create()
    {
        Mesh mesh = BuildCube(1, 1, 1);
        string name = "Quad Mesh";
        mesh.name = name;
        AssetDatabase.CreateAsset(mesh, String.Format("Assets/{0}.asset", name));
        EditorUtility.FocusProjectWindow();
        Selection.activeObject = mesh;
    }

    private static Mesh BuildCube(float width, float height, float depth)
    {
        Vector3[] vertices = {
            new Vector3 (+0.5f, +0.0f, -0.5f),
            new Vector3 (-0.5f, +0.0f, -0.5f),
            new Vector3 (-0.5f, +0.0f, +0.5f),
            new Vector3 (+0.5f, +0.0f, +0.5f),
        };

        int[] triangles = {
            0, 1, 2, //face top
            0, 2, 3
        };

        Mesh mesh = new Mesh();
        mesh.Clear ();
        mesh.vertices = vertices;
        mesh.triangles = triangles;
        mesh.Optimize ();
        mesh.RecalculateNormals ();
        mesh.RecalculateBounds();
        return mesh;
    }
}
