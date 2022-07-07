AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include("shared.lua")

-- Импорт всех файлов из паки Controllers
AddCSLuaFile("controllers/lobby_controller/cl_lobby_controller.lua")
include("controllers/lobby_controller/sv_lobby_controller.lua")



