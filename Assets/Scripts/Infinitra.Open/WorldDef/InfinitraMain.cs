//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//
using Infinitra.Core.Components;
using Infinitra.Core.Objects;
using Unity.XR.CoreUtils;
using UnityEngine;

namespace Infinitra.Open.WorldDef
{
    public class InfinitraMain : MonoBehaviour
    {
        private XROrigin xrOrigin;
        private bool started;

        // Component Initialization Step
        private void Awake()
        {
            GameObject goXrOrigin = AssetTools.getInGameObjectByName<GameObject>("XR Origin (XR Rig)");
            xrOrigin = goXrOrigin.GetComponent<XROrigin>();
        }
        
        // Component Linking and Registration Step
        private void OnEnable()
        {
        }

        // Routine Startup Step
        private void Start()
        {
            CompLoader.start();
            started = true;
        }

        // Recurrent Calculation Step
        private void Update()
        {
            if (!started) return;

            CompLoader.update(Time.deltaTime);
        }
    }
}