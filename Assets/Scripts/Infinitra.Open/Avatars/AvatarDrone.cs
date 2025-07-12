//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//

using System;
using Firebase.Firestore;
using Infinitra.Core.Appearance;
using Infinitra.Core.Fundamentals;
using Infinitra.Core.FX;
using Infinitra.Core.Objects;
using Infinitra.Shared.Avatars;
using Infinitra.Shared.Fundamentals;
using Infinitra.Shared.ServerComm.Firestore;
using UnityEngine;
using Quaternion = Infinitra.Shared.Fundamentals.Quaternion;

namespace Infinitra.Open.Avatars
{
    internal class AvatarDroneRemoteInterpolator : UserInterpolator
    {
        private float userCollisionTime;
        private float transcendanceTime;

        private static readonly float rotateSpeed = 90;

        
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

        public override void UpdateMovementRemoteImpl(FoldBackTransform transform, float timeDelta, Vector newVelocity, Vector velocityReal)
        {
            Quaternion destRotation = snapshotInterpol.rotation;
            
            // Interpolating Rotation
            UnityEngine.Quaternion newRotation = UnityEngine.Quaternion.RotateTowards(
                UnityConversions.ToUnity(transform.goRotation), 
                UnityConversions.ToUnity(destRotation), 
                timeDelta * rotateSpeed
            );
            transform.goRotation = UnityConversions.FromUnity(newRotation);
        }

        public override void ApplySnapshot(FoldBackTransform transform, ObjectSnapshot snapshot)
        {
            transform.goPosition = snapshot.position;
            transform.goRotation = snapshot.rotation;
        }
    }
    
    internal abstract class AvatarDroneSoundAppearance : UserAppearance
    {
        private static readonly SoundClips droneVertSounds;
        private static readonly SoundClips droneHoriSounds;
        private static readonly SoundClips damageSounds;
        
        private AudioSourceWrapper audioSource0;
        private AudioSourceWrapper audioSource1;
        private AudioSourceWrapper audioSource2;
        
        static AvatarDroneSoundAppearance()
        {
            droneHoriSounds = new();
            droneHoriSounds.addSound(
                "Sounds/MagicSoundEffects/Spacecraft Engines/UFO/spacecraft_ufo_b_engine_loop_1x", 0.1f, true, priority: 50);
            droneHoriSounds.load();   
            
            droneVertSounds = new();
            droneVertSounds.addSound(
                "Sounds/MagicSoundEffects/Spacecraft Engines/Drone/spacecraft_drone_b_engine_loop_1x", 0.1f, true, priority: 50);
            droneVertSounds.load();
            
            damageSounds = new();
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat1", 0.5f, false, priority: 50);
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat2", 0.5f, false, priority: 50);
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat3", 0.5f, false, priority: 50);
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat4", 0.5f, false, priority: 50);
            damageSounds.load();
        }

        public override void Init()
        {
            audioSource0 = GetOrAddAudioSource(0);
            audioSource1 = GetOrAddAudioSource(1);
            audioSource2 = GetOrAddAudioSource(2);
            
            audioSource0.Play(droneHoriSounds);
            audioSource1.Play(droneVertSounds);
        }

        public override void OnDeath()
        {
        }

        public override void OnRespawn()
        {
        }

        public override void OnDamage()
        {
            audioSource2.Play(damageSounds);
        }

        public override void UpdateImpl(float timeDelta)
        {
            UpdateDroneSound(audioSource0.audioSource, new Vector(UserMoveable.velocity.x, 0, UserMoveable.velocity.z));
            UpdateDroneSound(audioSource1.audioSource, new Vector(0, UserMoveable.velocity.y, 0), volFactor: 0.5f);
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

    internal class AvatarDroneRemoteAppearance : AvatarDroneSoundAppearance
    {
        public override string Name => "Drone";
        public override string Modelpath => "Objects/UserDrone";
        
        public override void Init()
        {
            base.Init();
            
            GameObject gameObject = AssetCache.InstantiatePrefab(Modelpath);
            gameObject.transform.SetParent(GameObject.transform, false);
            gameObject.transform.localPosition = Vector3.zero;
            
            Label = gameObject.GetComponentInChildren<TextMesh>();
        }

        public override void SetVelocity(Vector velocity)
        {
        }

        public override void OnGroundChange(object arg1, bool ground)
        {
        }
    }

    internal class AvatarDroneLocalAppearance : AvatarDroneSoundAppearance
    {
        public override string Modelpath { get; }
        public override string Name { get; }

        public override void SetVelocity(Vector velocity)
        {
        }

        public override void OnGroundChange(object arg1, bool ground)
        {
        }
    }
    
    internal class AvatarDroneInterpolatorFactory : GenericFactory<UserInterpolator>
    {
        public override UserInterpolator NewInstance()
        {
            return new AvatarDroneRemoteInterpolator();
        }
    }
    
    internal class AvatarDroneLocalAppearanceFactory : GenericFactory<UserAppearance>
    {
        public override UserAppearance NewInstance()
        {
            return new AvatarDroneLocalAppearance();
        }
    }
    
    internal class AvatarDroneRemoteAppearanceFactory : GenericFactory<UserAppearance>
    {
        public override UserAppearance NewInstance()
        {
            return new AvatarDroneRemoteAppearance();
        }
    }
}