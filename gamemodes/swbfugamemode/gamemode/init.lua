AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include("shared.lua")
include("team_setup.lua")


AddCSLuaFile( "gui/class_selector.lua" )


include("controllers/lobby_controller/sv_lobby_controller.lua")
AddCSLuaFile("controllers/lobby_controller/cl_lobby_controller.lua")



