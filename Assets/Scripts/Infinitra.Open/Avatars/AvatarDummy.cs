//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//

using System;
using System.Collections.Generic;
using Firebase.Firestore;
using Infinitra.Core.Appearance;
using Infinitra.Core.Fundamentals;
using Infinitra.Core.FX;
using Infinitra.Core.Objects;
using Infinitra.Shared.Fundamentals;
using Infinitra.Shared.Logging;
using Infinitra.Shared.ServerComm.Firestore;
using Infinitra.Shared.World;
using TMPro;
using UnityEngine;
using Quaternion = Infinitra.Shared.Fundamentals.Quaternion;

namespace Infinitra.Open.Avatars
{
    internal class AvatarDummyRemoteInterpolator : UserInterpolator
    {

        private static readonly float rotateSpeed = 180f;
        
        public override void InterpolateSnapshots(DateTime currentDateTimeCorrected, ObjectSnapshot last, ObjectSnapshot lastPrev)
        {
            float timeSinceLastUpdate = (float)(currentDateTimeCorrected - last.datetime).TotalSeconds;

            if (lastPrev is ObjectSnapshotDummy)
            {

                float timeDiff = (float)(last.datetime - lastPrev.datetime).TotalSeconds;

                // Position interpolation
                Vector posInterpol = Vector.Extrapol(last.position, lastPrev.position, timeDiff,
                    timeSinceLastUpdate);

                // Interpolating Rotation
                Quaternion rotInterpol = Quaternion.Extrapol(last.rotation, lastPrev.rotation, timeDiff,
                    timeSinceLastUpdate);

                ObjectSnapshotDummy transformInterpolated = new();
                transformInterpolated = new ObjectSnapshotDummy();
                transformInterpolated.timestamp = Timestamp.GetCurrentTimestamp();
                transformInterpolated.position = posInterpol;
                transformInterpolated.rotation = rotInterpol;

                snapshotInterpol = transformInterpolated;
            }
        }

        public override void UpdateMovementRemoteImpl(FoldBackTransform transform, float timeDelta, Vector newVelocity, Vector velocityReal)
        {
            Vector snapRot = snapshotInterpol.rotation.ToEulerAngles();
            Quaternion destRotation = Quaternion.Euler(0, (float)snapRot.y, 0);
            
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

    internal abstract class AvatarDummyFootstepAppearance : MovementAppearanceEncVal
    {
        private readonly float speedThreshold = 1.0f;
        private readonly float stepIntervalBase = 2.0f;
        private readonly float speedIntervalDouble = 3.0f;

        private float groundedTimer;
        private float stepTimer;

        private SoundClips footStepSounds;
        private static readonly SoundClips damageSounds;

        private static Dictionary<uint, SoundClips> clipDict = new();

        private AudioSourceWrapper audioSource0;
        private AudioSourceWrapper audioSource1;

        static AvatarDummyFootstepAppearance()
        {
            SoundClips sound = new();
            sound.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step0", 0.5f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step1", 0.5f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step2", 0.5f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step3", 0.5f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step4", 0.5f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step5", 0.5f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step6", 0.5f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step7", 0.5f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step8", 0.5f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Floor/Floor_step9", 0.5f, priority: 50);
            sound.load();
            clipDict.Add(EncVal.encValBuilding, sound);
            clipDict.Add(EncVal.encValUrbanFloor, sound);

            sound = new();
            sound.addSound("Sounds/Classic Footstep SFX/Forest/Forest_ground_step0", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Forest/Forest_ground_step1", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Forest/Forest_ground_step2", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Forest/Forest_ground_step3", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Forest/Forest_ground_step4", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Forest/Forest_ground_step5", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Forest/Forest_ground_step6", 0.35f, priority: 50);
            sound.load();
            clipDict.Add(EncVal.encValGrass, sound);

            sound = new();
            sound.addSound("Sounds/Classic Footstep SFX/Ground/Ground_Step0", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Ground/Ground_Step1", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Ground/Ground_Step2", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Ground/Ground_Step3", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Ground/Ground_Step4", 0.35f, priority: 50);
            sound.load();
            clipDict.Add(EncVal.encValGround, sound);

            sound = new();
            sound.addSound("Sounds/Classic Footstep SFX/Rock/Rocky_ground_step0", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Rock/Rocky_ground_step1", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Rock/Rocky_ground_step2", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Rock/Rocky_ground_step3", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Rock/Rocky_ground_step4", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Rock/Rocky_ground_step5", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Rock/Rocky_ground_step6", 0.35f, priority: 50);
            sound.addSound("Sounds/Classic Footstep SFX/Rock/Rocky_ground_step7", 0.35f, priority: 50);
            sound.load();
            clipDict.Add(EncVal.encValSnow, sound);

            damageSounds = new();
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat1", 0.5f, priority: 50);
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat2", 0.5f, priority: 50);
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat3", 0.5f, priority: 50);
            damageSounds.addSound("Sounds/SpaceSFX/beat/beat4", 0.5f, priority: 50);
            damageSounds.load();
        }

        public override void Init()
        {
            base.Init();
            audioSource0 = GetOrAddAudioSource(0);
            audioSource1 = GetOrAddAudioSource(1);
        }

        public override void OnDeath()
        {
        }

        public override void OnRespawn()
        {
        }

        public override void OnDamage()
        {
            audioSource1.Play(damageSounds);
        }

        public override void UpdateImpl(float timeDelta)
        {
            ProcessFootStepSounds(new Vector(UserMoveable.velocity.x, 0, UserMoveable.velocity.z));
        }

        private void ProcessFootStepSounds(Vector moveVector)
        {
            float speed = (float)moveVector.magnitude;

            // Adjust the stepTimer based on the character's speed
            stepTimer -= Time.deltaTime * speed;
            groundedTimer -= Time.deltaTime;

            groundedTimer = Mathf.Clamp01(groundedTimer);

            if (UserMoveable.collDown)
            {
                if (groundedTimer == 0.0f)
                {
                    if (footStepSounds != null) audioSource0.Play(footStepSounds);
                }
                else if (speed > speedThreshold && stepTimer <= 0)
                {
                    // Reset the timer based on speed, with a minimum threshold to prevent steps from being too rapid
                    if (footStepSounds != null) audioSource0.Play(footStepSounds);
                    stepTimer = stepIntervalBase / (2.0f * speed / speedIntervalDouble);
                }

                groundedTimer += 1.0f;
            }
        }

        protected override void ChangedEncVal(object sender, uint encVal)
        {
            try
            {
                footStepSounds = clipDict[encVal];
            }
            catch (Exception)
            {
                // No warning necessary.
            }
        }
    }

    internal class AvatarDummyRemoteAppearance : AvatarDummyFootstepAppearance
    {
        public override string Name => "Dummy";
        public override string Modelpath => "Objects/UserDummy";
        
        private Animator animator;
        private RuntimeAnimatorController animationController;

        
        public override void Init()
        {
            base.Init();

            GameObject gameObject = AssetCache.InstantiatePrefab(Modelpath);
            gameObject.transform.SetParent(GameObject.transform, false);
            gameObject.transform.localPosition = Vector3.zero;
            
            animationController = AssetCache.LoadResourceAsset<RuntimeAnimatorController>("Animations/BasicMotions");
            animator = gameObject.GetComponentInChildren<Animator>();
            animator.runtimeAnimatorController = animationController;
            
            Label = gameObject.GetComponentInChildren<TextMeshPro>();
        }

        public override void OnDeath()
        {
            base.OnDeath();
            animator.SetTrigger("DeadChange");
            animator.SetBool("Dead", true);
        }

        public override void OnRespawn()
        {
            base.OnRespawn();
            animator.SetBool("Dead", false);
        }

        public override void SetVelocity(Vector velocity)
        {
            double speed = new Vector(velocity.x, 0, velocity.z).magnitude;
            animator.SetFloat("Speed", (float)speed);
        }

        public override void OnGroundChange(object arg1, bool ground)
        {
            animator.SetBool("Ground", ground);
            if (!ground) animator.SetTrigger("GroundChange");
        }
    }
        
    internal class AvatarDummyLocalAppearance : AvatarDummyFootstepAppearance
    {

        public override string Modelpath { get; }
        public override string Name { get; }
        
        private EnvironmentProbe envProbe;
        private WindSound wind;

        private static readonly SoundClips windSound;

        static AvatarDummyLocalAppearance()
        {
            windSound = new SoundClips();
            windSound.addSound("Sounds/wind", 0, true, priority: 50);
            windSound.load();
        }

        public override void Init()
        {
            base.Init();

            envProbe = GetOrAddComponent<EnvironmentProbe>();
            wind = GetOrAddComponent<WindSound>();
            wind.windSound = windSound;
        }

        public override void SetVelocity(Vector velocity)
        {
        }

        public override void OnGroundChange(object arg1, bool ground)
        {
        }
    }

    internal class AvatarDummyInterpolatorFactory : GenericFactory<UserInterpolator>
    {
        public override UserInterpolator NewInstance()
        {
            return new AvatarDummyRemoteInterpolator();
        }
    }

    internal class AvatarDummyRemoteAppearanceFactory : GenericFactory<UserAppearance>
    {
        public override UserAppearance NewInstance()
        {
            return new AvatarDummyRemoteAppearance();
        }
    }

    internal class AvatarDummyLocalAppearanceFactory : GenericFactory<UserAppearance>
    {
        public override UserAppearance NewInstance()
        {
            return new AvatarDummyLocalAppearance();
        }
    }
}

