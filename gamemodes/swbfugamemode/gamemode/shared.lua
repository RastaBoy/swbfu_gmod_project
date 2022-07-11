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
    print("I AM SPAWNED!")
end 