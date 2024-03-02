using System;
using UnityEngine;
using UnityEditor;

public class CreateCubeMesh : Editor
{
    [MenuItem("Assets/Create/Cube", false, 10000)]
    public static void Create()
    {
        Mesh mesh = BuildCube(1, 1, 1);
        string name = "Cube Mesh";
        mesh.name = name;
        AssetDatabase.CreateAsset(mesh, String.Format("Assets/{0}.asset", name));
        EditorUtility.FocusProjectWindow();
        Selection.activeObject = mesh;
    }

    private static Mesh BuildCube(float width, float height, float depth)
    {
        Vector3[] vertices = {
            new Vector3 (-0.5f, -0.5f, -0.5f),
            new Vector3 (+0.5f, -0.5f, -0.5f),
            new Vector3 (+0.5f, +0.5f, -0.5f),
            new Vector3 (-0.5f, +0.5f, -0.5f),
            new Vector3 (-0.5f, +0.5f, +0.5f),
            new Vector3 (+0.5f, +0.5f, +0.5f),
            new Vector3 (+0.5f, -0.5f, +0.5f),
            new Vector3 (-0.5f, -0.5f, +0.5f),
        };

        int[] triangles = {
            0, 2, 1, //face front
            0, 3, 2,
            2, 3, 4, //face top
            2, 4, 5,
            1, 2, 5, //face right
            1, 5, 6,
            0, 7, 4, //face left
            0, 4, 3,
            5, 4, 7, //face back
            5, 7, 6,
            0, 6, 7, //face bottom
            0, 1, 6
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
