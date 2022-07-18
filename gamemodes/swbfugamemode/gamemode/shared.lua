GM.Name = "Star Wars: Battlefront Unlimited"
GM.Author = "SiTroyan"
GM.Email = "N/A"
GM.Website = "N/A"


function GM:Initialize()
    print("Hello world! \nIt is Star Wars: Battlefront Unlimited. WOW!")
    self.BaseClass.Initialize()
end

function GM:PlayerConnect(name, ip)
    print(name .. " connected")
end

function GM:PlayerSpawn(ply) 
	print("BFU STATUS: " .. ply.BFU_STATUS)
end

function GM:OnSpawnMenuOpen()
	return false;
end

function GM:ContextMenuOpen()
	return false;
end 

function GM:PlayerNoClip(ply,desiredState)
	return false;
end 


function GM:PlayerDeathSound()
	return true;
end 

function GM:DrawDeathNotice(x,y)
	return false;
end 


function GM:PlayerSpawnVehicle(ply,model,name,table)
	return false;
end 

function GM:PlayerSpawnSWEP(ply,weapon,info)
	return false;
end 

function GM:PlayerSpawnSENT(ply,class)
	return false;
end 

function GM:PlayerSpawnRagdoll(ply,model)
	return false;
end 

function GM:PlayerSpawnProp(ply,model)
	return false;
end 

function GM:PlayerSpawnObject(ply,model,skin)
	return false;
end 

function GM:PlayerSpawnNPC(ply,npc_type,weapon)
	return false;
end

function GM:PlayerSpawnEffect(ply,model)
	return false;
end 

function GM:PlayerGiveSWEP(ply,weapon,swep)
	return false;
end 

function GM:HUDAmmoPickedUp( item, amount )
	return false;
end 