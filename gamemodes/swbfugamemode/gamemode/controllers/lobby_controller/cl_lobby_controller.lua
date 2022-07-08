AddCSLuaFile()
include("gui/main_menu.lua")

local player_selected_class = 1

net.Receive("SelectClass", function()
    print("Message received...")
    -- Подгрузка таблицы от сервера --
    local classesTable = net.ReadTable()
    -- Основной шаблон --
    local classSelector = vgui.Create( "PlayerClassSelector" )
    -- Отображение модели --
    local modelViewerPanel = vgui.Create("DPanel", classSelector)
    modelViewerPanel:SetPos(600, 260)
    modelViewerPanel:SetSize(400, 700)

    local modelViewer = vgui.Create("DModelPanel", modelViewerPanel)
    modelViewer:SetSize(400, 700)
    modelViewer:SetModel(classesTable[player_selected_class]["model"])

    -- Начинаем добавлять кнопки --
    local btnW = 300
    local btnH = 100

    for key, value in pairs(classesTable) do
        PrintTable(value)
        local Button = vgui.Create("DButton", classSelector)
        Button:SetText(value["name"])
        Button:SetPos(150, 150 + ((btnH + 10)*key))
        Button:SetSize(btnW, btnH)
        Button.DoClick = function()
            player_selected_class = key
            modelViewer:SetModel(classesTable[player_selected_class]["model"])
        end
    end

    
    --PrintTable(classesTable)
end)