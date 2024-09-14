// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using InfinitraCore.Components;
using InfinitraCore.FX;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.XR.Interaction.Toolkit;
using UnityEngine.XR.Interaction.Toolkit.Locomotion;

namespace Infinitra.Movement
{

    [RequireComponent(typeof(AudioSource))]
    public class UserSounds : MonoBehaviour, IUserSounds
    {
        private readonly SoundClips teleportMode = new();
        private readonly SoundClips teleportModeCancel = new();
        private readonly SoundClips teleportSelect = new();
        private readonly SoundClips teleportEnqueue = new();
        private readonly SoundClips teleporting = new();

        private AudioSource audioSource;
        private AudioSource audioSourceLoop1;

        private bool teleportSelectionValid;

        private void Awake()
        {
            InitializeAudioSources();
            LoadAllSounds();
        }

        private void InitializeAudioSources()
        {
            AudioSource[] audioSources = GetComponents<AudioSource>();
            audioSource = audioSources[0];
            audioSourceLoop1 = audioSources[1];
        }

        private void LoadAllSounds()
        {
            teleportMode.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_12", 0.5f);
            teleportMode.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_13", 0.5f);
            teleportMode.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_15", 0.5f);
            teleportModeCancel.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_09", 0.5f);
            teleportModeCancel.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_14", 0.5f);
            teleportSelect.addSound("Sounds/UI Sfx/Wav/Click_Electronic/Click_Electronic_03", 0.02f, true, pitch: 2.0f);
            teleportEnqueue.addSound("Sounds/SpaceSFX/lowpitch/noise/noise03", 0.7f);
            teleporting.addSound("Sounds/SpaceSFX/lowpitch/hit/hit12", 0.7f, pitch: 1.125f);

            teleportMode.load();
            teleportModeCancel.load();
            teleportSelect.load();
            teleportEnqueue.load();
            teleporting.load();
        }

        private void OnEnable()
        {
            CompLoader.regUserSoundScript(this);
        }

        public void PlayTeleportModeStart(InputAction.CallbackContext context)
        {
            teleportMode.playSound(audioSource);
        }

        public void PlayTeleportCancel(InputAction.CallbackContext context)
        {
            teleportModeCancel.playSound(audioSource);
        }

        public void PlayTeleportSelectEntered(SelectEnterEventArgs arg0)
        {
            teleportSelect.playSound(audioSourceLoop1);
            teleportSelectionValid = true;
        }

        public void PlayTeleportSelectExited(SelectExitEventArgs arg0)
        {
            audioSourceLoop1.Stop();
            teleportSelectionValid = false;
        }

        public void PlayTeleportModeStop(InputAction.CallbackContext context)
        {
            if (teleportSelectionValid) teleportEnqueue.playSound(audioSource);
        }

        public void PlayTeleporting(LocomotionProvider locomotionProvider)
        {
            teleporting.playSound(audioSource);
        }
    }
}
