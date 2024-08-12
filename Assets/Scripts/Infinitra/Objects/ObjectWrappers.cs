// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using InfinitraCore.Objects;
using UnityEngine;

namespace Infinitra.Objects
{
    public interface IGameObject
    {
        string Name { get; set; }
        
        Vector3 Position { get; set; }
        
        string Label { get; set; }
        
        void Move(Vector3 movement);
        void Destroy();

    }

    public interface IGameObjectFactory
    {
        IGameObject InstantiatePrefab(string prefabPath);
    }
    
    public class GameObjectWrapper : IGameObject
    {
        private readonly GameObject _gameObject;

        public GameObjectWrapper(GameObject gameObject)
        {
            _gameObject = gameObject;
        }

        public string Name
        {
            get => _gameObject.name;
            set => _gameObject.name = value;
        }

        public Vector3 Position
        {
            get => _gameObject.transform.position;
            set => _gameObject.transform.position = value;
        }

        public string Label
        {
            get {                
                var textMesh = _gameObject.GetComponentInChildren<TextMesh>();
                return textMesh.text;
            }
            set { 
                var textMesh = _gameObject.GetComponentInChildren<TextMesh>();
                textMesh.text = value;
            }
        }

        public void Move(Vector3 movement)
        {
            var charController = _gameObject.GetComponent<CharacterController>();
            charController?.Move(movement);
        }

        public void Destroy()
        {
            Object.Destroy(_gameObject);
        }
    }

    public class GameObjectFactory : IGameObjectFactory
    {
        public IGameObject InstantiatePrefab(string prefabPath)
        {
            var go = AssetCache.InstantiatePrefab(prefabPath);
            return new GameObjectWrapper(go);
        }
    }
}