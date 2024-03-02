/** 
 * INFINITRA © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0. 
 * To view a copy of this license,
 * visit http://creativecommons.org/licenses/by-nc-sa/4.0/
 */

using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Infinitra.GUI
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