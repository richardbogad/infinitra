// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System.Collections.Generic;
using Infinitra.Objects;
using InfinitraCore.Controllers;
using InfinitraCore.WorldCore;
using UnityEngine;
using Quaternion = UnityEngine.Quaternion;

namespace Infinitra.Movement
{

    internal class ObjectWorkItem
    {
        internal IGameObject go;
        internal float userCollisionTime;
        internal float transcendanceTime;
        internal Vector3 position;
        internal Quaternion rotation;
        internal Vector3 moveDirection;
    }
    
    internal class ObjectVisualizer
    {
        internal static readonly float collisionTime = 3f;
        internal static readonly float transcendanceTime = 2f;
        private static readonly float totalMoveTime = 1.0f;
        
        private readonly IGameObjectFactory _gameObjectFactory;

        private Dictionary<string, ObjectWorkItem> userWis = new();

        public ObjectVisualizer(IGameObjectFactory gameObjectFactory)
        {
            _gameObjectFactory = gameObjectFactory;
        }

        internal void UpdateObjects(Dictionary<string, ObjectInfo> userPositions, float deltaTime)
        {
            if (deltaTime > totalMoveTime) deltaTime = totalMoveTime;

            foreach (KeyValuePair<string, ObjectInfo> entry in userPositions)
            {
                string objectId = entry.Key;
                ObjectInfo objectInfo = entry.Value;
                Vector3 destPosition = UnityConversions.ToVector3(objectInfo.position);
                Quaternion destRotation = UnityConversions.ToUnityQuaternion(objectInfo.rotation);
                if (!userWis.TryGetValue(objectId, out ObjectWorkItem wi))
                {
                    wi = new ObjectWorkItem();
                    userWis.Add(objectId, wi);
                    
                    IGameObject go = _gameObjectFactory.InstantiatePrefab("Objects/User");
                    go.Name = "user-" + objectId;
                    go.Label = objectInfo.displayName;
                    go.Position = destPosition;
                    go.Rotation = destRotation;
                    wi.go = go;
                    wi.userCollisionTime = 0f;
                    wi.transcendanceTime = 0f;
                    wi.position = destPosition;
                    wi.moveDirection = Vector3.zero;
                }

                UpdateObjectMovement(objectInfo.displayName, wi, destPosition, destRotation, deltaTime);
            }

            RemoveInactiveObjects(userPositions);
        }

        private void UpdateObjectMovement(string displayName, ObjectWorkItem wi, Vector3 destPosition, Quaternion destRotation, float deltaTime)
        {
            IGameObject go = wi.go;
            var lastPosition = wi.position;
            var lastMoveDirection = wi.moveDirection;

            Vector3 goPosition = go.Position;
            Vector3 relPos = destPosition - goPosition;
            float moveFraction = (deltaTime / totalMoveTime);
            Vector3 movement = relPos * moveFraction;

            if (wi.transcendanceTime <= 0f)
            {
                Vector3 lastMovementNorm = (goPosition - lastPosition).normalized;
                if (Vector3.Dot(lastMovementNorm, lastMoveDirection) < 0.95f)
                {
                    wi.userCollisionTime += deltaTime;
                    if (wi.userCollisionTime >= collisionTime) wi.transcendanceTime += transcendanceTime;
                }
                else wi.userCollisionTime = 0f;

                go.Move(movement);
            }
            else
            {
                go.Position += movement;
                wi.transcendanceTime -= deltaTime;
            }

            if (go.Label != displayName) go.Label = displayName;
            go.Rotation = Quaternion.SlerpUnclamped(go.Rotation, destRotation, moveFraction);
            wi.rotation = go.Rotation;
            wi.position = goPosition;
            wi.moveDirection = relPos.normalized;
        }

        private void RemoveInactiveObjects(Dictionary<string, ObjectInfo> userPositions)
        {
            var deletedKeys = new LinkedList<string>();
            foreach (var entry in userWis)
            {
                if (!userPositions.ContainsKey(entry.Key))
                {
                    entry.Value.go.Destroy();
                    deletedKeys.AddLast(entry.Key);
                }
            }

            foreach (string key in deletedKeys)
            {
                userWis.Remove(key);
            }
        }
    }
}