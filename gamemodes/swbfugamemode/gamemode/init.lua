AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include("shared.lua")


function GM:PlayerConnect(name, ip)
    print(name .. " connected")
end

function GM:PlayerSpawn( ply )
	GM:PlayerSpawnAsSpectator( ply )
end

function GM:PlayerSpawnAsSpectator( ply )
    print("Player spawn as spectator")
end


function GM:PlayerCanJoinTeam(ply, team)
    return true
end

function GM:MenuStart()
    print("Menu Start!")
end

function GM:PlayerInitialSpawn(player)
    print("PlayerInitialSpawn")
    player:SetTeam(1)
    player:SetClassID(1)
    PrintTable(player:GetPlayerInfo())
end

