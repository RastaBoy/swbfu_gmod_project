available_classes = {
    clone_trooper_ph1 = {
        name = "Clone Trooper Phase 1",
        class = "Trooper",
        model = "models/player/swbtc/phase 1 clone trooper.mdl",
        weapons = {
            "Weapon 1",
            "Weapon 2"
        }
    },
    clone_trooper_ph2 = {
        name = "Clone Trooper Phase 2",
        class = "Trooper",
        model = "models/player/cody/commander cody.mdl",
        weapons = {
            "Weapon 1",
            "Weapon WOW"
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