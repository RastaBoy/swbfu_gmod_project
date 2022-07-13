BFUPlayers = {}

-- Описание модели игрока --
-- BFUPlayer = {
--     player_info = ...,
--     status = ...,
--     selected_class = ...
-- }
-- Статусы --
local BFU_NOT_SELECTED = 1
local BFU_SELECTED = 2
local BFU_NEED_TO_CHANGE = 3
local BFU_IN_GAME = 4

util.AddNetworkString( "SelectClass" )
util.AddNetworkString( "PlayerClassSelected" )

local function ClassSelector(ply)
    MsgN("Player SPAWNED " .. ply:Nick())
    net.Start("SelectClass")
        net.WriteTable(map_classes)
    net.Send(ply)
    print("Message sended")

end



net.Receive("PlayerClassSelected", function(len, ply)
    local player_choice = net.ReadTable()   
    print("Class Selected!")    
    for _, obj in pairs(BFUPlayers) do
        if obj["player_info"] == ply then
            obj["status"] = BFU_SELECTED
            obj["selected_class"] = player_choice
        end
    end
    ply:Spawn()
end)

local function BFUPlayerSpawn(ply, class_info) 
    for _, obj in pairs(BFUPlayers) do
        if obj["player_info"] == ply then
            obj["status"] = BFU_IN_GAME
        end
    end

    ply:SetModel(class_info["model"])
    
    -- HP --
    ply:SetMaxHealth(classes_info[class_info["class"]]["hp"])
    ply:SetHealth(classes_info[class_info["class"]]["hp"])
    -- WALK AND JUMPING --
    ply:SetSlowWalkSpeed(classes_info[class_info["class"]]["walk_speed"] - 15)
    ply:SetWalkSpeed(classes_info[class_info["class"]]["walk_speed"]) 
    ply:SetRunSpeed(classes_info[class_info["class"]]["run_speed"])
    ply:SetMaxSpeed(classes_info[class_info["class"]]["run_speed"])
    ply:SetJumpPower(classes_info[class_info["class"]]["jump_power"])

    ply:SetMoveType(2)

    for _, obj in pairs(class_info["weapons"]) do
        ply:Give(obj["weapon"])
    end

    ply:SetObserverMode(0)
    ply:UnSpectate()        

    ply:Spawn()
end


local function ManagePlayer(ply)
    for _, obj in pairs(BFUPlayers) do
        if obj["player_info"] == ply then
            -- Если игрок уже существует --
            if obj["status"] == BFU_NOT_SELECTED then 
                ClassSelector(ply)
                GAMEMODE:PlayerSpawnAsSpectator( ply )
                print("Player need to select class")
                return
            end

            if obj["status"] == BFU_SELECTED then
                print("Player class selected and now player should spawn")
                BFUPlayerSpawn(ply, obj["selected_class"])
                return
            end

            if obj["status"] == BFU_IN_GAME then
                return
            end
        end
    end
    -- Если игрок впервые подключился -- 
    table.insert(BFUPlayers, {
        player_info = ply,
        status = BFU_NOT_SELECTED,
        selected_class = {}
    })
    print("Player added")
    ManagePlayer(ply)
end


hook.Add("PlayerSpawn", "BFUManagePlayer", ManagePlayer)