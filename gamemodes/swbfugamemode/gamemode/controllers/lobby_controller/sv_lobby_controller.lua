


-- 
util.AddNetworkString( "SelectClass" )

local function ClassSelector(ply)
    MsgN("Player SPAWNED " .. ply:Nick())
    net.Start("SelectClass")
        net.WriteTable(map_classes)
    net.Send(ply)
    print("Message sended")
end


hook.Add("PlayerSpawn", "SWBFUClassSelector", ClassSelector)