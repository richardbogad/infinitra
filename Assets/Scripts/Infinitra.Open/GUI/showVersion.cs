//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//
using TMPro;
using UnityEngine;

namespace Infinitra.Open.GUI
{
    public class VersionShower : MonoBehaviour
    {
        private void Awake()
        {
            if (TryGetComponent(out TextMeshProUGUI output))
            {
                output.text = Application.version;
            }
        }
    }
}