


-- 
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

        ply:SetObserverMode(0)
        ply:UnSpectate()        

        ply:SetModel(player_choice["model"])
        ply:SetSlowWalkSpeed(140)
        ply:SetWalkSpeed(155) 
        ply:SetRunSpeed(215)
        ply:SetMaxSpeed(215)
        ply:SetJumpPower(160)
        ply:Spawn()
end)


hook.Add("PlayerSpawn", "SWBFUClassSelector", ClassSelector)