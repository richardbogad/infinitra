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
            GoAppearanceUpdater goAppearanceUpdater = GameObject.AddComponent<GoAppearanceUpdater>();
            
            Appearance = new AvatarDroneAppearance();
            Appearance.Init(this);
            goAppearanceUpdater.appearance = Appearance;
        }
        
        public override void DeinitImpl()
        {
            Appearance.Deinit();
            GoAppearanceUpdater goAppearanceUpdater = GameObject.GetComponent<GoAppearanceUpdater>();
            if (goAppearanceUpdater != null)
            {
                Object.Destroy(goAppearanceUpdater);
            }
        }

        public override void OnDamage()
        {
            Appearance.OnDamage();
        }

        public override ObjectSnapshotUser ToSnapshot()
        {
            ObjectSnapshotDrone snap = new();
            snap.position = Transform.goPosition;
            snap.rotation = Transform.goRotation;
            snap.timestamp = Timestamp.GetCurrentTimestamp();
            return snap;
        }

        protected override void OnDeathImpl()
        {
            Appearance.OnDeath();
        }

        protected override void OnRespawnImpl()
        {
            Appearance.OnRespawn();
        }
    }
    
    internal class AvatarDroneRemote : GoUserRemote
    {
        private float userCollisionTime;
        private float transcendanceTime;

        private static readonly float rotateSpeed = 90;
        
        public override ObjectSnapshot snapshotInterpol { get; set; }
        
        public override string Name => "Drone";
        public override string ModelPath => "Objects/UserDrone";
        
        public override void Visualize()
        {
            Log.Info("Creating GameObject remote for object id: {0}", objectId);
            
            GameObject = AssetCache.InstantiatePrefab(ModelPath);
            charController = GameObject.GetComponent<CharacterController>();
            if (charController == null) charController = GameObject.AddComponent<CharacterController>();
 
            charController.height = modelConfig.charHeight;
            charController.radius = modelConfig.charRadius;
            charController.center = UnityConversions.ToUnity(modelConfig.charOffset);

            Appearance = new AvatarDroneAppearance();
            Appearance.Init(this);
            
            GoAppearanceUpdater goAppearanceUpdater = GameObject.AddComponent<GoAppearanceUpdater>();
            goAppearanceUpdater.appearance = Appearance;
        }

        public override void InterpolateSnapshots(DateTime currentDateTimeCorrected, ObjectSnapshot last, ObjectSnapshot lastPrev)
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
                UnityConversions.ToUnity(Transform.goRotation), 
                UnityConversions.ToUnity(destRotation), 
                timeDelta * rotateSpeed
            );
            Transform.goRotation = UnityConversions.FromUnity(newRotation);
        }

        public override void GroundChange(object arg1, bool ground)
        {
        }

        public override void ApplySnapshot(string name, ObjectSnapshot snapshot)
        {
            Transform.goPosition = snapshot.position;
            Transform.goRotation = snapshot.rotation;
            hoverLabel = name;
        }

        protected override void OnDeathImpl()
        {
            Appearance.OnDeath();
        }

        protected override void OnRespawnImpl()
        {
            Appearance.OnRespawn();
        }
    }
    
    internal class AvatarDroneAppearance : GoAppearance
    {
        private static readonly SoundClips droneVertSounds;
        private static readonly SoundClips droneHoriSounds;
        private static readonly SoundClips damageSounds;
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
            
            damageSounds = new();
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat1", 0.5f, false, priority: 50);
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat2", 0.5f, false, priority: 50);
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat3", 0.5f, false, priority: 50);
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat4", 0.5f, false, priority: 50);
            damageSounds.load();
        }

        public override void Init(IGoUser go)
        {
            this.goUser = go;
            
            audioSources = new AudioSource[3];
            audioSources[0] = go.GameObject.AddComponent<AudioSource>();
            audioSources[0].spatialBlend = 1f;
            audioSources[1] = go.GameObject.AddComponent<AudioSource>();
            audioSources[1].spatialBlend = 1f;
            audioSources[2] = go.GameObject.AddComponent<AudioSource>();
            audioSources[2].spatialBlend = 1f;
            
            droneHoriSounds.PlaySound(audioSources[0]);
            droneVertSounds.PlaySound(audioSources[1]);
        }

        public override void Deinit()
        {
            Object.Destroy(audioSources[0]);
            Object.Destroy(audioSources[1]);
        }

        public override void OnDeath()
        {
            Deinit();
        }

        public override void OnRespawn()
        {
            Init(goUser);
        }

        public override void OnDamage()
        {
            damageSounds.PlaySound(audioSources[2]);
        }

        public override void Update(float timeDelta)
        {
            UpdateDroneSound(audioSources[0], new Vector(goUser.velocity.x, 0, goUser.velocity.z));
            UpdateDroneSound(audioSources[1], new Vector(0, goUser.velocity.y, 0), volFactor: 0.5f);
        }

        private void UpdateDroneSound(AudioSource audioSourceLoop, Vector movementVector, float volFactor = 1f)
        {
            if (audioSourceLoop == null) return;
            
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