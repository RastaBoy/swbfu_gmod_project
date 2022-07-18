local ply = FindMetaTable("Player")

local teams = {}

base_class_info = {
    trooper = {
        hp = 250,
        ammo = 60,
        walk_speed = 100,
        run_speed = 260
    },
    commando = {
        hp = 540,
        ammo = 240,
        walk_speed = 100,
        run_speed = 260
    }
}

classes_info = {
    {
        name = "Clone Trooper",
        model = "models/test.mdl",
        base_class = "trooper",
        weapons = {
            {
                name = "temp-1",
                value = "weapon_temp1"
            }
        },
    },
}

teams[0] = {
    name = "PVE",
    color = Vector(0, 0, 1.0)
}

teams[1] = {
    name = "EnemyTeam",
    color = Vector(1.0, 0, 0)
}

teams[2] = {
    name = "Neutral",
    color = Vector(1.0, 1.0, 0)
}


-- Статусы --
BFU_NOT_SELECTED = 1
BFU_SELECTED = 2
BFU_NEED_TO_CHANGE = 3
BFU_IN_GAME = 4


function InitPVEClasses()
    print(game.GetMap()..".bfinfo")
    if (file.Exists("maps/"..game.GetMap()..".bfinfo", "GAME")) then
        print("I found it")
        PrintTable(classes_info)
        local fileInfo = file.Read("maps/"..game.GetMap()..".bfinfo", "GAME")
        classes_info = util.JSONToTable(fileInfo)["classes_info"]
        PrintTable(classes_info)
    else
        print("Nothing founded.")
    end
end



function ply:SetupTeam(teamIds) 
    if (not teams[teamIds]) then return end
    
    self:SetTeam( teamIds )
    self:SetPlayerColor( teams[teamIds].color )
end


function ply:SpawnByClass(class_info)
    PrintTable(class_info)
end

ply.BFU_STATUS = BFU_NOT_SELECTED

hook.Add("OnGamemodeLoaded", "InitPVEClasses", InitPVEClasses)