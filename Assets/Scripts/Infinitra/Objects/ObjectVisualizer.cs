// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System.Collections.Generic;
using Infinitra.Objects;

namespace Infinitra.Movement
{
    internal class ObjectVisualizer
    {

        internal void UpdateObjects(Dictionary<string, GameObjectLabeled> userPositions, float deltaTime)
        {
            foreach (KeyValuePair<string, GameObjectLabeled> entry in userPositions)
            {
                GameObjectLabeled obj = entry.Value;
                obj.updateMovement(deltaTime);
            }
        }
    }
}