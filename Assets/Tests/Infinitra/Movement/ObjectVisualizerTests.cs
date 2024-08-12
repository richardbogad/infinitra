using System;
using System.Collections.Generic;
using Infinitra.Movement;
using Infinitra.Objects;
using InfinitraCore.Calculation;
using InfinitraCore.Controllers;
using Moq;
using NUnit.Framework;
using UnityEngine;

namespace Infinitra.Tests.Movement
{
    [TestFixture]
    public class ObjectVisualizerTests
    {
        private Mock<IGameObjectFactory> _mockGameObjectFactory;
        private Mock<IGameObject> _mockGameObject;
        private ObjectVisualizer _objectVisualizer;

        [SetUp]
        public void Setup()
        {
            _mockGameObjectFactory = new Mock<IGameObjectFactory>();
            _mockGameObject = new Mock<IGameObject>();
            _objectVisualizer = new ObjectVisualizer(_mockGameObjectFactory.Object);

            _mockGameObjectFactory.Setup(f => f.InstantiatePrefab(It.IsAny<string>()))
                .Returns(_mockGameObject.Object);
        }

        [Test]
        public void UpdateObjects_ShouldInstantiateAndInitializeNewObjects_WhenObjectIdNotPresent()
        {
            // Arrange
            var userPositions = new Dictionary<string, ObjectInfo>
            {
                { "user1", new ObjectInfo { position = new Vector(1, 1, 1), displayName = "User 1" } }
            };

            _mockGameObject.SetupProperty(g => g.Position);
            _mockGameObject.SetupProperty(g => g.Name);
            _mockGameObject.SetupProperty(g => g.Label);

            // Act
            _objectVisualizer.UpdateObjects(userPositions, 0.5f);

            // Assert
            _mockGameObjectFactory.Verify(f => f.InstantiatePrefab("Objects/User"), Times.Once);
            _mockGameObject.VerifySet(g => g.Name = "user-user1");
            _mockGameObject.VerifySet(g => g.Label = "User 1");
            _mockGameObject.VerifySet(g => g.Position = new Vector3(1, 1, 1));
            _mockGameObject.Verify(g => g.Move(It.IsAny<Vector3>()), Times.Once);
        }

        [Test]
        public void UpdateObjects_ShouldMoveObject_WhenObjectIdAlreadyPresent()
        {
            // Arrange
            var userPositions = new Dictionary<string, ObjectInfo>
            {
                { "user1", new ObjectInfo { position = new Vector(2, 2, 2), displayName = "User 1" } }
            };
            _mockGameObject.SetupProperty(g => g.Position, new Vector3(1, 1, 1));
            _objectVisualizer.UpdateObjects(userPositions, 0.5f);
            _mockGameObject.Reset();

            // Act
            _objectVisualizer.UpdateObjects(userPositions, 0.5f);

            // Assert
            _mockGameObject.Verify(g => g.Move(It.IsAny<Vector3>()), Times.Once);
        }

        [Test]
        public void UpdateObjects_ShouldRemoveInactiveObjects_WhenObjectNotPresentInUserPositions()
        {
            // Arrange
            var initialUserPositions = new Dictionary<string, ObjectInfo>
            {
                { "user1", new ObjectInfo { position = new Vector(1, 1, 1), displayName = "User 1" } }
            };

            var updatedUserPositions = new Dictionary<string, ObjectInfo>();

            _mockGameObject.SetupProperty(g => g.Position);

            _objectVisualizer.UpdateObjects(initialUserPositions, 0.5f);

            // Act
            _objectVisualizer.UpdateObjects(updatedUserPositions, 0.5f);

            // Assert
            _mockGameObject.Verify(g => g.Destroy(), Times.Once);
        }

        [Test]
        public void UpdateObjectMovement_ShouldHandleCollision_WhenNotMoving()
        {
            // Arrange
            var userPositions = new Dictionary<string, ObjectInfo>
            {
                { "user1", new ObjectInfo { position = new Vector(1, 1, 1), displayName = "User 1" } }
            };

            float timeDiff = 0.5f;
            int iterMove = (int)Math.Ceiling(ObjectVisualizer.collisionTime / timeDiff);
            int iterTranscendance = (int)Math.Ceiling(ObjectVisualizer.transcendanceTime / timeDiff);

            _mockGameObject.SetupProperty(g => g.Position, new Vector3(0, 0, 0));

            // Register Objects, so that the initial.Position is not called
            _objectVisualizer.UpdateObjects(userPositions, timeDiff); 
            _mockGameObject.Reset();

            // Act
            for (int i = 0; i < iterMove + iterTranscendance; i++)
            {
                _objectVisualizer.UpdateObjects(userPositions, timeDiff);
            }

            // Assert
            _mockGameObject.Verify(g => g.Move(It.IsAny<Vector3>()), Times.Exactly(iterMove));
            _mockGameObject.VerifySet(g => g.Position = It.IsAny<Vector3>(), Times.Exactly(iterTranscendance));
        }

        [Test]
        public void UpdateObjects_ShouldCapDeltaTime_WhenDeltaTimeExceedsTotalMoveTime()
        {
            // Arrange
            var userPositions = new Dictionary<string, ObjectInfo>
            {
                { "user1", new ObjectInfo { position = new Vector(1, 1, 1), displayName = "User 1" } }
            };

            _mockGameObject.SetupProperty(g => g.Position);

            // Act
            _objectVisualizer.UpdateObjects(userPositions, 2.0f);

            // Assert
            _mockGameObject.Verify(g => g.Move(It.IsAny<Vector3>()), Times.Once);
        }
    }
}