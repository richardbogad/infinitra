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
using CarverSphereSmall10m = Infinitra.Open.World.Objects.CarverSphereSmall10m;

namespace Infinitra.Open.World
{
    public class InfinitraMain : MonoBehaviour
    {
        // Routine Initialization Step
        public void Awake()
        {
            CompLoader.RegisterUserRemoteFactory(Shared.Avatars.Avatar.DRONE, new AvatarDroneRemoteFactory());
            CompLoader.RegisterUserRemoteFactory(Shared.Avatars.Avatar.DUMMY, new AvatarDummyRemoteFactory());
            
            CompLoader.RegisterUserRemoteAppearanceFactory(Shared.Avatars.Avatar.DRONE, new AvatarDroneAppearanceFactory());
            CompLoader.RegisterUserRemoteAppearanceFactory(Shared.Avatars.Avatar.DUMMY, new AvatarDummyRemoteAppearanceFactory());
            
            CompLoader.RegisterUserLocalAppearanceFactory(Shared.Avatars.Avatar.DRONE, new AvatarDroneAppearanceFactory());
            CompLoader.RegisterUserLocalAppearanceFactory(Shared.Avatars.Avatar.DUMMY, new AvatarDummyLocalAppearanceFactory());
            
            CompLoader.RegisterConsumableItemAppearanceFactory(ConsumeableAction.JETPACK_1m, new JetPackSoundFactory());
            CompLoader.RegisterConsumableItemAppearanceFactory(ConsumeableAction.CARVER_SPHERE_SMALL_10m, new CarverSphereSmall10mFactory());

            CarverSphereSmall10m.Load();
            
            CompLoader.Awake();
        }

        // Routine Startup Step
        public void Start()
        {
            CompLoader.Start();
        }

        // Recurrent Frame Step
        public void Update()
        {
            CompLoader.Update(Time.deltaTime);
        }
    }
}