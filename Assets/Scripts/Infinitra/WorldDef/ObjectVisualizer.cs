// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System.Collections.Generic;
using InfinitraCore.Calculation;
using InfinitraCore.Objects;
using InfinitraCore.WorldCore;
using UnityEngine;

namespace Infinitra.WorldDef
{
    internal class ObjectVisualizer
    {
        private static readonly float collisionTime = 3f;
        private static readonly float totalMoveTime = 1.0f;
        
        private Dictionary<string, GameObject> userGos = new();
        private Dictionary<string, ReferenceWrapper<float>> userCollisionTime = new();
        private Dictionary<string, ReferenceWrapper<Vector3>> position = new();
        private Dictionary<string, ReferenceWrapper<Vector3>> moveDirection = new();

        internal void UpdateObjects(Dictionary<string, Vector> userPositions, float deltaTime)
        {

            if (deltaTime > totalMoveTime) deltaTime = totalMoveTime;
            
            foreach (KeyValuePair<string, Vector> entry in userPositions)
            {
                string objectId = entry.Key;
                Vector3 destPosition = UnityConversions.ToVector3(entry.Value);

                if (!userGos.TryGetValue(objectId, out GameObject go))
                {
                    GameObject userPrefab = AssetCache<GameObject>.LoadResourceAsset("Objects/User");
                    go = GameObject.Instantiate(userPrefab);
                    go.name = "user-" + objectId;

                    userGos.Add(objectId, go);
                    go.transform.position = destPosition;
                    userCollisionTime.Add(objectId, new ReferenceWrapper<float>(0f));
                    position.Add(objectId, new ReferenceWrapper<Vector3>(destPosition));
                    moveDirection.Add(objectId, new ReferenceWrapper<Vector3>(Vector3.zero));
                }

                UpdateObjectMovement(objectId, go, destPosition, deltaTime);
            }

            RemoveInactiveObjects(userPositions);
        }

        private void UpdateObjectMovement(string objectId, GameObject go, Vector3 destPosition, float deltaTime)
        {
            userCollisionTime.TryGetValue(objectId, out ReferenceWrapper<float> collisionTime);
            position.TryGetValue(objectId, out ReferenceWrapper<Vector3> lastPosition);
            moveDirection.TryGetValue(objectId, out ReferenceWrapper<Vector3> lastMoveDirection);

            CharacterController charController = go.GetComponent<CharacterController>();
                
            Vector3 sourcePosition = go.transform.position;
            Vector3 relPos = destPosition - sourcePosition;

            Vector3 movement = relPos * (deltaTime / totalMoveTime); // move to dest in half a sec
            Vector3 lastMovementNorm = (sourcePosition - lastPosition.Value).normalized;

            if (collisionTime.Value < ObjectVisualizer.collisionTime)
            {
                if (Vector3.Dot(lastMovementNorm, lastMoveDirection.Value) < 0.95f)
                {
                    collisionTime.Value += deltaTime;
                }
                else
                {
                    collisionTime.Value = 0f;
                }

                charController.Move(movement);
            }
            else 
            {
                go.transform.position += movement;
                collisionTime.Value -= deltaTime;
            }

            lastPosition.Value = sourcePosition;
            lastMoveDirection.Value = relPos.normalized;
        }

        private void RemoveInactiveObjects(Dictionary<string, Vector> userPositions)
        {
            LinkedList<string> deletedKeys = new();
            foreach (KeyValuePair<string, GameObject> entry in userGos)
            {
                if (!userPositions.ContainsKey(entry.Key))
                {
                    Object.DestroyImmediate(entry.Value);
                    deletedKeys.AddLast(entry.Key);
                }
            }

            foreach (string key in deletedKeys)
            {
                userGos.Remove(key);
                userCollisionTime.Remove(key);
                position.Remove(key);
                moveDirection.Remove(key);
            }
        }
    }
}