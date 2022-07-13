available_classes = {
    clone_trooper_ph1 = {
        name = "Clone Trooper Phase 1",
        class = "Trooper",
        model = "models/player/swbtc/phase 1 clone trooper.mdl",
        weapons = {
            {
                name = "DC-15a",
                weapon = "weapon_752_dc15a"
            },
            {
                name = "DC-17",
                weapon = "weapon_752_dc17"
            }
        }
    },
    clone_trooper_ph2 = {
        name = "Clone Trooper Phase 2",
        class = "Trooper",
        model = "models/player/cody/commander cody.mdl",
        weapons = {
            {
                name = "DC-15a",
                weapon = "weapon_752_dc15a"
            },
            {
                name = "DC-17",
                weapon = "weapon_752_dc17"
            },
            {
                name = "DC-17M-AT",
                weapon = "weapon_752_dc17m_at"
            },
            {
                name = "DC-17M-BR",
                weapon = "weapon_752_dc17m_br"
            }
        }
    }
}


classes_info = {
    Trooper = {
        hp = 300,
        jump_power = 260,
        walk_speed = 155,
        run_speed = 215
    },
}

map_classes = {
    available_classes["clone_trooper_ph1"],
    available_classes["clone_trooper_ph2"]
}