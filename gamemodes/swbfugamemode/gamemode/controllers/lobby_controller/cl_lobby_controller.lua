AddCSLuaFile()
include("gui/main_menu.lua")

local player_selected_class = 1

net.Receive("SelectClass", function()
    print("Message received...")
    local classSelector = vgui.Create( "PlayerClassSelector" )
    -- Начинаем добавлять кнопки --
    local classesTable = net.ReadTable()

    local btnW = 300
    local btnH = 100

    for key, value in pairs(classesTable) do
        PrintTable(value)
        local Button = vgui.Create("DButton", classSelector)
        Button:SetText(value["name"])
        Button:SetPos(150, 150 + ((btnH + 10)*key))
        Button:SetSize(btnW, btnH)
        Button.DoClick = function()
            print("Before:" .. player_selected_class)
            player_selected_class = key
            print("After:" .. player_selected_class)
        end

    end

    --PrintTable(classesTable)
end)