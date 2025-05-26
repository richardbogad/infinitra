//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//

using Infinitra.Core.Avatars;
using Infinitra.Core.FX;
using Infinitra.Core.Objects;
using Infinitra.Shared.Fundamentals;
using UnityEngine;

namespace Infinitra.Open.World.Objects
{

    internal class JetPackSound : GoAppearance
    {
        private IGoUser gameObject;

        private static SoundClips jetPackClip;
        
        static JetPackSound()
        {
            jetPackClip = new SoundClips(); 
            jetPackClip.addSound("Sounds/MagicSoundEffects/Spacecraft Engines/Drone/spacecraft_drone_b_engine_loop_1x", 0.4f, true, priority: 50, 0.8f);
            jetPackClip.load();
        }

        public override void Init(IGoUser go)
        {
            this.gameObject = go;
            
            audioSources = new AudioSource[1];
            audioSources[0] = go.gameObject.AddComponent<AudioSource>();
            audioSources[0].spatialBlend = 1f;
            jetPackClip.PlaySound(audioSources[0]);
        }

        public override void Update(float timeDelta)
        {
            float speed = gameObject.velocityMag;
            float volume = Mathf.Lerp(0.25f, 0.66f, speed / 5.0f);
            float pitch = Mathf.Lerp(0.75f, 1.25f, speed / 5.0f);

            audioSources[0].volume = Mathf.Lerp(audioSources[0].volume, volume, Time.deltaTime * 2f);
            audioSources[0].pitch = Mathf.Lerp(audioSources[0].pitch, pitch, Time.deltaTime * 2f);
        }

        public override void Deinit()
        {
            Object.Destroy(audioSources[0]);
        }
    }

    internal class JetPackSoundFactory : GenericFactory<GoAppearance>
    {
        public override GoAppearance NewInstance()
        {
            return new JetPackSound();
        }
    }
}