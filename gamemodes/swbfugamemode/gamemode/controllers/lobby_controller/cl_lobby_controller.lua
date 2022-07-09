AddCSLuaFile()
include("gui/main_menu.lua")

local player_selected_class = 1

--util.AddNetworkString( "PlayerClassSelected" )

net.Receive("SelectClass", function()
    print("Message received...")
    -- Подгрузка таблицы от сервера --
    local classesTable = net.ReadTable()
    local mainMenuSize = {
        w = surface.ScreenWidth(),
        h = surface.ScreenHeight()
    }
    local columns = {
        {
            posX = 0,
            posY = 0,
            w = mainMenuSize["w"] * 1/3,
            h = mainMenuSize["h"]
        },
        {
            posX = mainMenuSize["w"] * 1/3,
            posY = 0,
            w = mainMenuSize["w"] * 1/3,
            h = mainMenuSize["h"]
        },
        {
            posX = mainMenuSize["w"] * 2/3,
            posY = 0,
            w = mainMenuSize["w"] * 1/3,
            h = mainMenuSize["h"]
        }
    }
    -- -- Колонки -- 
    -- for _, column in pairs(columns) do
    --     local col = vgui.Create("DFrame")
    --     col:SetPos(column["posX"], column["posY"])
    --     col:SetSize(column["w"], column["h"])
    --     col:MakePopup()
    -- end

    -- Основной шаблон --
    local classSelector = vgui.Create( "PlayerClassSelector" )
    -- Отображение модели --
    local mdvpSize = {
        w = 600,
        h = 800,
        stepUp = 200
    }
    local modelViewerPanel = vgui.Create("DPanel", classSelector)
    modelViewerPanel:SetPos(surface.ScreenWidth()/2 - mdvpSize["w"]/2, mdvpSize["stepUp"])
    modelViewerPanel:SetSize(mdvpSize["w"], mdvpSize["h"])

    local modelViewer = vgui.Create("DModelPanel", modelViewerPanel)
    modelViewer:SetSize(mdvpSize["w"], mdvpSize["h"])
    modelViewer:SetModel(classesTable[player_selected_class]["model"])
    modelViewer:SetCamPos(Vector(85, 0, 50))

    function modelViewerPanel:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,0))
    end
    modelViewer:SetFOV(45)

    function modelViewer:LayoutEntity(ent)
        -- Point camera toward the look pos
        local lookAng = (self.vLookatPos-self.vCamPos):Angle()
        -- Rotate the look angles based on incrementing yaw value
        lookAng:RotateAroundAxis(Vector(0, 0, 0), 0)
        -- Set camera look angles
        self:SetLookAng(lookAng)
        -- Make entity rotate like normal
        ent:SetAngles(Angle(0, 0,  0))    
    end


    -- Начинаем добавлять кнопки --
    local choiceBtnSize = {
        w = columns[1]["w"] * 0.8,
        h = 130,
        step = 20,
        stepH = 90
    }

    for key, value in pairs(classesTable) do
        local Button = vgui.Create("DButton", classSelector)
        Button:SetText(value["name"])
        Button:SetPos(
            columns[1]["posX"] + columns[1]["w"]/2 - choiceBtnSize["w"]/2, 
            choiceBtnSize["stepH"] + ((choiceBtnSize["h"] + choiceBtnSize["step"])*key)
        )
        Button:SetSize(choiceBtnSize["w"], choiceBtnSize["h"])
        Button.DoClick = function()
            player_selected_class = key
            modelViewer:SetModel(classesTable[player_selected_class]["model"])
        end

        function Button:Paint(w, h)
            draw.RoundedBox(45, 0, 0, w, h, Color(0,0,0, 250))
        end

    end

    local spawnBtnSize = {
        h = 50,
        w = 250,
        step = 50
    }
    local spawnBtn = vgui.Create("DButton", classSelector)
    spawnBtn:SetText("SPAWN")
    spawnBtn:SetPos(surface.ScreenWidth()/2 - (spawnBtnSize["w"]/2), surface.ScreenHeight() - spawnBtnSize["step"] - spawnBtnSize["h"])
    spawnBtn:SetSize(spawnBtnSize["w"], spawnBtnSize["h"])
    function spawnBtn:DoClick(self) 
        print("Spawn Me!")
        PrintTable(classesTable[player_selected_class])
    end

    -- Настройка векторов --
    -- ============================================================== --
    -- local vectorPanel = vgui.Create("DFrame", classesTable)
    -- vectorPanel:SetPos(500, 0)
    -- vectorPanel:SetSize(600, 100)
    -- vectorPanel:SetTitle("Vector Panel")
    -- vectorPanel:MakePopup()


    -- local xInput = vgui.Create("DTextEntry", vectorPanel)
    -- local x = 50
    -- xInput:SetPos(20,40)
    -- xInput:SetSize(80, 20)
    -- xInput:SetNumeric(true)


    -- local yInput = vgui.Create("DTextEntry", vectorPanel)
    -- local y = 50
    -- yInput:SetPos(105, 40)
    -- yInput:SetSize(80, 20)
    -- yInput:SetNumeric(true)

    -- local zInput = vgui.Create("DTextEntry", vectorPanel)
    -- local z = 50
    -- zInput:SetPos(185, 40)
    -- zInput:SetSize(80, 20)
    -- zInput:SetNumeric(true)

    -- local inputBtn = vgui.Create("DButton", vectorPanel)
    -- inputBtn:SetText("Set Vector")
    -- inputBtn:SetPos(280, 40)
    -- inputBtn:SetSize(80, 20)
    -- inputBtn.DoClick = function()
    --     modelViewer:SetCamPos(Vector(xInput:GetValue(), yInput:GetValue(), zInput:GetValue()))
    --     print(modelViewer:GetAnimated())
    --     print(modelViewer:GetAnimSpeed())
    -- end
    -- ============================================================== --
end)