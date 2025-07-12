//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//

using Infinitra.Core.Appearance;
using Infinitra.Core.FX;
using Infinitra.Core.Objects;
using Infinitra.Shared.Fundamentals;
using UnityEngine;
using UnityEngine.VFX;

namespace Infinitra.Open.World.Objects
{

    internal class JetPackAppearance : ItemAppearance
    {
        private static SoundClips jetPackClip;
        
        private AudioSourceWrapper audioSource;
        
        static JetPackAppearance()
        {
            jetPackClip = new SoundClips(); 
            jetPackClip.addSound("Sounds/MagicSoundEffects/Spacecraft Engines/Drone/spacecraft_drone_b_engine_loop_1x", 0.4f, true, priority: 50, 0.8f);
            jetPackClip.load();
        }

        public override void Init()
        {
            audioSource = GetOrAddAudioSource(0);
        }

        public override void OnActive()
        {
            audioSource.Play(jetPackClip);
        }

        public override void OnActivate()
        {
        }

        public override void OnActivateDelay()
        {
        }

        public override void OnActivateDelayCancel()
        {
        }

        public override void OnDeactivate()
        {
            audioSource.Stop();
        }

        public override void UpdateImpl(float timeDelta)
        {
            float speed = UserMoveable.velocityMag;
            float volume = Mathf.Lerp(0.25f, 0.66f, speed / 5.0f);
            float pitch = Mathf.Lerp(0.75f, 1.25f, speed / 5.0f);

            audioSource.audioSource.volume = Mathf.Lerp(audioSource.audioSource.volume, volume, Time.deltaTime * 2f);
            audioSource.audioSource.pitch = Mathf.Lerp(audioSource.audioSource.pitch, pitch, Time.deltaTime * 2f);
        }

    }

    internal class JetPackAppearanceFactory : GenericFactory<ItemAppearance>
    {
        public override ItemAppearance NewInstance()
        {
            return new JetPackAppearance();
        }
    }
    
    
    internal class CarverSphereSmall10m : ItemAppearance
    {
        private static SoundClips soundBeeping;
        private static SoundClips soundActivation;
        private static SoundClips soundActive;
        private static VisualEffectAsset visualEffectAsset;

        public static void Load()
        {
            soundBeeping = new SoundClips();
            soundBeeping.addSound("Sounds/Items/Click_Electronic_10", 0.5f, true, 30, pitch: 1f);
            soundActivation = new SoundClips();
            soundActivation.addSound("Sounds/Items/EXPLDsgn_Implode_15", 0.8f, false, 30, pitch: 1f);
            soundActive = new SoundClips();
            soundActive.addSound("Sounds/Items/AMBIENCE_TUNNEL_WIND_LOOP", 1f, true, 30, pitch: 1.25f);
            
            visualEffectAsset = AssetCache.LoadResourceAsset<VisualEffectAsset>("FX/ParticleSphereWhite");
        }

        public override void Init()
        {
            GetOrAddAudioSource(0);
            GetOrAddAudioSource(1);
        }

        public override void UpdateImpl(float timeDelta)
        {
        }

        public override void OnActivateDelay()
        {
            AnimRotation rot = GameObject.GetComponent<AnimRotation>();
            rot.SetRotationSpeed(720, 10f);
            
            GetOrAddAudioSource(0).Play(soundBeeping);
            GetOrAddAudioSource(0).ChangeVolume(1, 1);
            
            MaterialFader matFader = GetOrAddComponent<MaterialFader>();
            matFader.FadeColor("_BaseColor", Color.white, 10);
            matFader.FadeColor("_EmissiveColor", Color.white, 10);
            matFader.FadeFloat("_EmissiveIntensity", 10, 10);
            matFader.FadeFloat("_EmissiveExposureWeight", 0, 10);
            
            AnimScale scaler = GetOrAddComponent<AnimScale>();
            scaler.SetTransform(Transform);
            
            scaler.SetScale(Vector3.one * 2, 9);
            scaler.SetScale(Vector3.zero, 1, 9);
        }

        public override void OnActivateDelayCancel()
        {
            OnFadeToNormal();
        }

        public override void OnActivate()
        {
            GetOrAddAudioSource(1).Play(soundActivation);
            GetOrAddAudioSource(1).ChangeVolume(1, 1);
        }
        
        public override void OnActive()
        {
            Renderer renderer = GameObject.GetComponent<Renderer>();
            renderer.enabled = false;
            
            AnimRotation rot = GameObject.GetComponent<AnimRotation>();
            rot.SetRotationSpeed(360);
            
            MaterialFader matFader = GetOrAddComponent<MaterialFader>();
            matFader.StopAllFades();
            matFader.FadeColor("_BaseColor", Color.white, 0);
            matFader.FadeColor("_EmissiveColor", Color.white, 0);
            matFader.FadeFloat("_EmissiveIntensity", 10, 0);
            matFader.FadeFloat("_EmissiveExposureWeight", 0, 0);
            
            GetOrAddAudioSource(0).Play(soundActive);
            GetOrAddAudioSource(0).ChangeVolume(0, 1, fadeStart: 0, fadeEnd: 1);
            
            AnimScale scaler = GetOrAddComponent<AnimScale>();
            scaler.StopAllFades();
            scaler.SetTransform(Transform);
            scaler.SetScale(Vector3.one);
            
            GameObject sphere = GetOrAddChild(0);
            sphere.transform.localScale = Vector3.one * 10;

            VisualEffect visualEffect = sphere.GetComponent<VisualEffect>();
            if (visualEffect == null) visualEffect = sphere.AddComponent<VisualEffect>();
            visualEffect.visualEffectAsset = visualEffectAsset;
            visualEffect.Play();
        }

        public override void OnDeactivate()
        {
            OnFadeToNormal();
        }
        
        private void OnFadeToNormal()
        {
            Renderer renderer = GameObject.GetComponent<Renderer>();
            renderer.enabled = true;
                        
            AnimRotation rot = GameObject.GetComponent<AnimRotation>();
            rot.SetRotationSpeed(10);
            
            GetOrAddAudioSource(0).Stop();
            GetOrAddAudioSource(1).Stop();
            
            MaterialFader matFader = GetOrAddComponent<MaterialFader>();
            matFader.StopAllFades();
            matFader.ReturnToInitialState();
            
            AnimScale scaler = GetOrAddComponent<AnimScale>();
            scaler.StopAllFades();
            scaler.RevertToInitial();
            
            DestroyChild(0);
        }
    }
    
    internal class CarverSphereSmall10mFactory : GenericFactory<ItemAppearance>
    {
        public override ItemAppearance NewInstance()
        {
            return new CarverSphereSmall10m();
        }
    }
}