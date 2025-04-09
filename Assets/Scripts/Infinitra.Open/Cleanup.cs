//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//
using UnityEngine;

namespace Infinitra.Open
{
    public class Cleanup : MonoBehaviour
    {
        [SerializeField] public int frameInterval = 1000;

        private int frameId;

        private void Update()
        {
            frameId += 1;

            if (frameId % frameInterval == 0) Resources.UnloadUnusedAssets();
        }
    }
}