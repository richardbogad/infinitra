//
// Copyright (c) 2025 Richard Bogad.
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.
//

using Infinitra.Core.Components;
using Infinitra.Open.Avatars;
using Infinitra.Open.World.Objects;
using Infinitra.Shared.Avatars;
using Infinitra.Shared.ServerComm.Firestore;
using Infinitra.Shared.ServerComm.ModelRest;
using Infinitra.Shared.World.Objects;
using UnityEngine;

namespace Infinitra.Open.World
{
    public class InfinitraMain : MonoBehaviour
    {
 
        // Routine Initialization Step
        public void Awake()
        {
            CompLoader.RegisterUserLocalFactory(Appearance.DRONE, new AvatarDroneLocalFactory());
            CompLoader.RegisterUserLocalFactory(Appearance.DUMMY, new AvatarDummyLocalFactory());
            
            CompLoader.RegisterUserRemoteFactory(typeof(ObjectSnapshotDrone), new AvatarDroneRemoteFactory());
            CompLoader.RegisterUserRemoteFactory(typeof(ObjectSnapshotDummy), new AvatarDummyRemoteFactory());
            
            CompLoader.RegisterUserAppearanceFactory(Appearance.DRONE, new AvatarDroneAppearanceFactory());
            CompLoader.RegisterUserAppearanceFactory(Appearance.DUMMY, new AvatarDummyAppearanceFactory());
            
            CompLoader.RegisterConsumableAppearanceFactory(ConsumeableAction.JETPACK_1m, new JetPackSoundFactory());
            
            CompLoader.awake();
        }

        // Routine Startup Step
        public void Start()
        {
            CompLoader.start();
        }

        // Recurrent Frame Step
        public void Update()
        {
            CompLoader.update(Time.deltaTime);
        }
    }
}