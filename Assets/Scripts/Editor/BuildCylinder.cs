using System;
using UnityEngine;
using UnityEditor;

public class CreateCubeCylinder : Editor
{
    [MenuItem("Assets/Create/Cylinder", false, 10000)]
    public static void Create()
    {
        Mesh mesh = BuildMesh(1, 1, 1);
        string name = "Cylinder Mesh";
        mesh.name = name;
        NormalizeMesh(mesh);
        AssetDatabase.CreateAsset(mesh, String.Format("Assets/{0}.asset", name));
        EditorUtility.FocusProjectWindow();
        Selection.activeObject = mesh;
    }

    private static Mesh BuildMesh(float width, float height, float depth)
    {
        GameObject go = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
        var meshFilter = go.GetComponent<MeshFilter>();
        return meshFilter.mesh;
    }

    private static void NormalizeMesh(Mesh mesh)
    {
        Vector3[] vertices = mesh.vertices;
        
        // Calculate the bounds of the original mesh
        Bounds bounds = mesh.bounds;
        Vector3 size = bounds.size;

        // Calculate the scale required to fit the mesh within a unit cube
        float scaleX = 1f / size.x;
        float scaleY = 1f / size.y;
        float scaleZ = 1f / size.z;

        // Scale and recenter vertices
        for (int i = 0; i < vertices.Length; i++)
        {
            vertices[i].x *= scaleX;
            vertices[i].y *= scaleY;
            vertices[i].z *= scaleZ;
        }

        // Update the vertices
        mesh.vertices = vertices;

        // Recalculate bounds based on scaled vertices
        bounds = new Bounds(Vector3.zero, Vector3.zero);
        foreach (Vector3 vertex in vertices)
        {
            bounds.Encapsulate(vertex);
        }
        mesh.bounds = bounds;
    }
}