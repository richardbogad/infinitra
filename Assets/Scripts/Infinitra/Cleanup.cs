/** 
 * INFINITRA © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0. 
 * To view a copy of this license,
 * visit http://creativecommons.org/licenses/by-nc-sa/4.0/
 */

using UnityEngine;

namespace Infinitra
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