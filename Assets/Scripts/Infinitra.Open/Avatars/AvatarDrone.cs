//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//

using System;
using Firebase.Firestore;
using Infinitra.Core.Avatars;
using Infinitra.Core.Fundamentals;
using Infinitra.Core.FX;
using Infinitra.Core.Objects;
using Infinitra.Shared.Fundamentals;
using Infinitra.Shared.Logging;
using Infinitra.Shared.ServerComm.Firestore;
using UnityEngine;
using Object = UnityEngine.Object;
using Quaternion = Infinitra.Shared.Fundamentals.Quaternion;

namespace Infinitra.Open.Avatars
{
    internal class AvatarDroneLocal : GoUserLocal
    {
        public override void InitImpl()
        {
            GoAppearanceUpdater goAppearanceUpdater = gameObject.AddComponent<GoAppearanceUpdater>();
            
            GoAppearance appearance = new AvatarDroneAppearance();
            appearance.Init(this);
            goAppearanceUpdater.appearance = appearance;
        }
        
        public override void DeinitImpl()
        {
            GoAppearanceUpdater goAppearanceUpdater = gameObject.GetComponent<GoAppearanceUpdater>();
            if (goAppearanceUpdater != null)
            {
                goAppearanceUpdater.appearance.Deinit();
                Object.Destroy(goAppearanceUpdater);
            }
        }
        
        public override ObjectSnapshotBase ToSnapshot()
        {
            ObjectSnapshotDrone snapshot = new();
            snapshot.position = goPosition;
            snapshot.rotation = goRotation;
            snapshot.timestamp = Timestamp.GetCurrentTimestamp();
            return snapshot;
        }
    }
    
    internal class AvatarDroneRemote : GoUserRemote
    {
        private float userCollisionTime;
        private float transcendanceTime;
        private Vector positionIntended;

        private static readonly float rotateSpeed = 90;
        
        public override ObjectSnapshotBase snapshotInterpol { get; set; }
        
        public override string Name => "Drone";
        public override string ModelPath => "Objects/UserDrone";
        
        public override void CreateGo()
        {
            Log.Info("Creating GameObject remote for object id: {0}", objectId);
            
            gameObject = AssetCache.InstantiatePrefab(ModelPath);
            charController = gameObject.GetComponent<CharacterController>();
            if (charController == null) charController = gameObject.AddComponent<CharacterController>();
 
            charController.height = modelConfig.charHeight;
            charController.radius = modelConfig.charRadius;
            charController.center = UnityConversions.ToUnity(modelConfig.charOffset);

            AvatarDroneAppearance goAppearance = new();
            goAppearance.Init(this);
            
            GoAppearanceUpdater goAppearanceUpdater = gameObject.AddComponent<GoAppearanceUpdater>();
            goAppearanceUpdater.appearance = goAppearance;
        }

        public override void InterpolateSnapshots(DateTime currentDateTimeCorrected, ObjectSnapshotBase last, ObjectSnapshotBase lastPrev)
        {
            float timeSinceLastUpdate = (float)(currentDateTimeCorrected - last.datetime).TotalSeconds;

            if (lastPrev is ObjectSnapshotDrone)
            {

                float timeDiff = (float)(last.datetime - lastPrev.datetime).TotalSeconds;

                // Position interpolation
                Vector posInterpol = Vector.Extrapol(last.position, lastPrev.position, timeDiff,
                    timeSinceLastUpdate);
                
                Quaternion rotInterpol = Quaternion.Extrapol(last.rotation, lastPrev.rotation, timeDiff,
                    timeSinceLastUpdate);

                ObjectSnapshotDrone transformInterpolated = new();
                transformInterpolated = new ObjectSnapshotDrone();
                transformInterpolated.timestamp = Timestamp.GetCurrentTimestamp();
                transformInterpolated.position = posInterpol;
                transformInterpolated.rotation = rotInterpol;

                snapshotInterpol = transformInterpolated;
            }
        }

        public override void UpdateMovementRemoteImpl(float timeDelta, Vector newVelocity, Vector velocityReal)
        {
            Quaternion destRotation = snapshotInterpol.rotation;
            
            // Interpolating Rotation
            UnityEngine.Quaternion newRotation = UnityEngine.Quaternion.RotateTowards(
                UnityConversions.ToUnity(goRotation), 
                UnityConversions.ToUnity(destRotation), 
                timeDelta * rotateSpeed
            );
            goRotation = UnityConversions.FromUnity(newRotation);
        }

        public override void GroundChange(object arg1, bool ground)
        {
        }

        public override void ApplySnapshot(string name, ObjectSnapshotBase snapshot)
        {
            goPosition = snapshot.position;
            goRotation = snapshot.rotation;
            hoverLabel = name;
        }
    }
    
    internal class AvatarDroneAppearance : GoAppearance
    {
        private static readonly SoundClips droneVertSounds;
        private static readonly SoundClips droneHoriSounds;
        
        static AvatarDroneAppearance()
        {
            droneHoriSounds = new();
            droneHoriSounds.addSound(
                "Sounds/MagicSoundEffects/Spacecraft Engines/UFO/spacecraft_ufo_b_engine_loop_1x", 0.0f, true,
                priority: 50);
            droneHoriSounds.load();   
            
            droneVertSounds = new();
            droneVertSounds.addSound(
                "Sounds/MagicSoundEffects/Spacecraft Engines/Drone/spacecraft_drone_b_engine_loop_1x", 0.0f, true,
                priority: 50);
            droneVertSounds.load();
        }

        public override void Init(IGoUser go)
        {
            this.go = go;
            
            audioSources = new AudioSource[2];
            audioSources[0] = go.gameObject.AddComponent<AudioSource>();
            audioSources[0].spatialBlend = 1f;
            audioSources[1] = go.gameObject.AddComponent<AudioSource>();
            audioSources[1].spatialBlend = 1f;
            
            droneHoriSounds.PlaySound(audioSources[0]);
            droneVertSounds.PlaySound(audioSources[1]);
        }

        public override void Deinit()
        {
            Object.Destroy(audioSources[0]);
            Object.Destroy(audioSources[1]);
        }
        
        public override void Update(float timeDelta)
        {
            UpdateDroneSound(audioSources[0], new Vector(go.velocity.x, 0, go.velocity.z));
            UpdateDroneSound(audioSources[1], new Vector(0, go.velocity.y, 0), volFactor: 0.5f);
        }

        private void UpdateDroneSound(AudioSource audioSourceLoop, Vector movementVector, float volFactor = 1f)
        {
            float speed = (float)movementVector.magnitude;
            float volume = Mathf.Lerp(0.25f, 0.75f, speed / 5.0f);
            float pitch = Mathf.Lerp(0.25f, 1.0f, speed / 5.0f);
            
            audioSourceLoop.volume = Mathf.Lerp(audioSourceLoop.volume, volume * volFactor, Time.deltaTime * 2f);
            audioSourceLoop.pitch = Mathf.Lerp(audioSourceLoop.pitch, pitch, Time.deltaTime * 2f);
        }
    }
    
    internal class AvatarDroneLocalFactory : GenericFactory<GoUserLocal>
    {
        public override GoUserLocal NewInstance()
        {
            return new AvatarDroneLocal();
        }
    }
    
    internal class AvatarDroneRemoteFactory : GenericFactory<GoUserRemote>
    {
        public override GoUserRemote NewInstance()
        {
            return new AvatarDroneRemote();
        }
    }
    
    internal class AvatarDroneAppearanceFactory : GenericFactory<GoAppearance>
    {
        public override GoAppearance NewInstance()
        {
            return new AvatarDroneAppearance();
        }
    }
}