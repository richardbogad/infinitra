// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using InfinitraCore.Shared;
using UnityEditor;
using UnityEngine;

public class CreateMeshes : Editor
{
    [MenuItem("Assets/Create/Marching", false, 10000)]
    public static void CreateMarching()
    {
        int size = 16;
        bool[,,] map = new bool[size, size, size];

        for (int x = 0; x < size; x++)
        {
            for (int y = 0; y < size; y++)
            {
                for (int z = 0; z < size; z++)
                {
                    float xn = x / (float)16;
                    float yn = y / (float)16;
                    float zn = z / (float)16;

                    xn = Various.MapTo(x, 0, 16, 0.5f, 1.0f);
                    yn = Various.MapTo(y, 0, 16, 0.0f, 1.0f);
                    zn = Various.MapTo(z, 0, 16, 0.0f, 1.0f);
                    
                    float value = Mathf.PerlinNoise(yn, Mathf.PerlinNoise(xn, zn));
                    map[x, y, z] = value > 0.5;
                }
            }    
        }
        
        //var mesh = mapToMesh(map);

        //AssetSaver.Save("Test Mesh", mesh);
    }

   
    
    [MenuItem("Assets/Create/Cube", false, 10000)]
    public static void CreateCube()
    {
        Mesh mesh = BuildCube(1, 1, 1);
        AssetSaver.Save("Cube Mesh", mesh);
    }
    
    [MenuItem("Assets/Create/Cylinder", false, 10000)]
    public static void CreateCylinder()
    {
        Mesh mesh = CylinderMesh(1, 1, 1);
        NormalizeMesh(mesh);
        AssetSaver.Save("Cylinder Mesh", mesh);
    }
    
    [MenuItem("Assets/Create/Quad", false, 10000)]
    public static void BuildQuad()
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
        
        AssetSaver.Save("Quad Mesh", mesh);
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


    private static Mesh CylinderMesh(float width, float height, float depth)
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
