-- Fonts --
surface.CreateFont( "BFUClassNameFont", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 18,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "BFUWeaponsFont", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 16,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "BFUSpawnFont", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 26,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


-- Background --
local PANEL = {}
function PANEL:Init()
    self:SetSize( surface.ScreenWidth(), surface.ScreenHeight() )
    self:Center()
    self:MakePopup()
    self:ParentToHUD()
    self:SetPopupStayAtBack(true)
end
function PANEL:Paint( w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,250) )
end
vgui.Register( "BFUClassSelector", PANEL, "Panel" )   




local player_selected_class = 1

function ClassSelectorDraw(classes_info)
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
    ---------------------------------------------
    -- Основной шаблон --
    local classSelector = vgui.Create( "BFUClassSelector" )

    -- Показ модели и кнопка спавна --
     -- Отображение модели --
     local mdvpSize = {
        w = 600,
        h = 800,
        stepUp = 160
    }
    local modelViewerPanel = vgui.Create("DPanel", classSelector)
    modelViewerPanel:SetPos(surface.ScreenWidth()/2 - mdvpSize["w"]/2, mdvpSize["stepUp"])
    modelViewerPanel:SetSize(mdvpSize["w"], mdvpSize["h"])

    local modelViewer = vgui.Create("DModelPanel", modelViewerPanel)
    modelViewer:SetSize(mdvpSize["w"], mdvpSize["h"])
    modelViewer:SetModel(classes_info[player_selected_class]["model"])
    modelViewer:SetCamPos(Vector(95, 0, 50))

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
        ent:SetSequence("idle_ar2")
        -- Make entity rotate like normal
        ent:SetAngles(Angle(0, 0,  0))  
    end


    ---------------------------------------------
    -- Кнопки выбора класса --
    clsBtn = {
        w = columns[1]["w"] * 0.8,
        h = 130,
        step = 20,
        stepH = 60
    }

    for key, value in pairs(classes_info) do
        local Button = vgui.Create("DButton", classSelector)

        Button:SetText("")
        Button:SetPos(
            columns[1]["posX"] + columns[1]["w"]/2 - clsBtn["w"]/2, 
            clsBtn["stepH"] + ((clsBtn["h"] + clsBtn["step"])*key)
        )
        Button:SetSize(clsBtn["w"], clsBtn["h"])

        function Button:Paint(w, h)
            if (key == player_selected_class) then
                draw.RoundedBox(0, 0, h/5 + 2, w, h - h/5 - 2, Color(0, 0, 0, 230))
                surface.SetDrawColor(128, 128, 128, 230)
                surface.DrawOutlinedRect(0, h/5 + 2, w, h - h/5 - 2, 5)
                draw.RoundedBox(30, 0, 0, w, h/5, Color(70,130,180, 200))
                draw.SimpleText(value["name"], "BFUClassNameFont", w/2, 2, Color(0,0,0,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            else 
                surface.SetDrawColor(128, 128, 128, 150)
                surface.DrawOutlinedRect(0, h/5 + 2, w, h - h/5 - 2, 5)
                draw.RoundedBox(30, 0, 0, w, h/5, Color(70,130,180, 100))
                draw.SimpleText(value["name"], "BFUClassNameFont", w/2, 2, Color(0,0,0,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            end

            local weapons = "Weapons:\n"
            for i, val in pairs(value["weapons"]) do
                weapons = weapons .. val["name"] .. "\n"
            end

            draw.DrawText(weapons, "BFUWeaponsFont", w/2, h/3, Color(255,255,255,200), TEXT_ALIGN_CENTER)
        end

        function Button:DoClick() 
            player_selected_class = key
            modelViewer:SetModel(value["model"])
        end
    end


    -- Кнопка спавна --
    local SpawnBtn = vgui.Create("DButton", classSelector)
    local spawnBtnSizes = {
        w = columns[2]["w"] * 0.45,
        h = 40
    }

    SpawnBtn:SetText("")
    SpawnBtn:SetPos(
        columns[2]["posX"] + columns[2]["w"]/2 - spawnBtnSizes["w"]/2,
        surface.ScreenHeight() - 2*spawnBtnSizes["h"]
    )
    SpawnBtn:SetSize(
        spawnBtnSizes["w"],
        spawnBtnSizes["h"]
    )

    function SpawnBtn:Paint(w, h)
        if SpawnBtn:IsHovered() then
            draw.RoundedBox(45, 0, 0, w, h, Color(50, 50, 50, 255))
            draw.RoundedBox(45, 5, 5, w-10, h-10, Color(140, 140, 140, 255))
            draw.SimpleText("SPAWN", "BFUSpawnFont", w/2, h/2, Color(255,255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.RoundedBox(45, 0, 0, w, h, Color(50, 50, 50, 150))
            draw.RoundedBox(45, 5, 5, w-10, h-10, Color(140, 140, 140, 255))
            draw.SimpleText("SPAWN", "BFUSpawnFont", w/2, h/2, Color(255,255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end


end


