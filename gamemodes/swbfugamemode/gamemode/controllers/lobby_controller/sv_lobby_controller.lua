
util.AddNetworkString( "SelectClass" )
util.AddNetworkString( "PlayerClassSelected" )

function SendClassesMenu(ply)
    net.Start("SelectClass")
        net.WriteTable(classes_info)
    net.Send(ply)
end

function ManagePlayer(ply)
    print("I MANAGE")
    print(ply.BFU_STATUS)
    if (ply.BFU_STATUS == BFU_NOT_SELECTED or ply.BFU_STATUS == BFU_NEED_TO_CHANGE) then
        print("Player doesn't have selected class!")
        SendClassesMenu(ply)
        GAMEMODE:PlayerSpawnAsSpectator(ply)
        print("Player spawn as spectator...")
    end

    if (ply.BFU_STATUS == BFU_SELECTED) then
        print("Player now in game...")
    end

end


hook.Add("PlayerSpawn", "BFUManagePlayer", ManagePlayer)