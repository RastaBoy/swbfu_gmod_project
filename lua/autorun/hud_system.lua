if SERVER then
	AddCSLuaFile()
end


if LocalPlayer then

    local HiddenElements = {
		['CHudHealth']=true,
		['CHudBattery']=true,
		['CHudAmmo']=true,
		['CHudSecondaryAmmo']=true
	}


    local function BFUHUDDraw()
        local ply = LocalPlayer()

        local HUDColor = Color(35, 35, 35, 255)

        local ScreenWidth, ScreenHeight = surface.ScreenWidth(), surface.ScreenHeight()
        local SegmentSizeW, SegmentSizeH = 550, 220


        draw.RoundedBox(0, 0, 0, ScreenWidth, 100, HUDColor)


        -- Левый сегмент --
        draw.RoundedBoxEx(90, 0, ScreenHeight - SegmentSizeH, SegmentSizeW, 250, HUDColor, false, true, false, false) 

        -- Правый сегмент --
        draw.RoundedBoxEx(90, ScreenWidth - SegmentSizeW, ScreenHeight - SegmentSizeH, SegmentSizeW, 250, HUDColor, true, false, false, false)


        -- Health Bar --
        local indentHW = 20
        local indentHH = 80

        local MaxHPColor = Color(0, 255, 0, 230)
        local MiddleHPColor = Color(255, 165, 0, 230)
        local LowHPColor = Color(255, 0, 0, 230)

        local healthState = ply:Health()/ply:GetMaxHealth()

        local lineCount = math.ceil(healthState*8)

        local healthColor = MaxHPColor

        if healthState >= 0.8 then
            healthColor = MaxHPColor
        elseif healthState >= 0.6 then
            healthColor = MiddleHPColor
        else
            healthColor = LowHPColor
        end

        for i = 1, lineCount do
            -- Left --        
            draw.RoundedBox(45, SegmentSizeW + indentHW, ScreenHeight - 10 - (15 * i), 140, 10, healthColor)
            -- Right --
            draw.RoundedBox(45, ScreenWidth - SegmentSizeW - indentHW - 140, ScreenHeight - 10 - (15 * i), 140, 10, healthColor)
        end

    end

    local function BFUHideHUD( elem )
        if HiddenElements[elem] then return false end
    end

    hook.Add( 'HUDShouldDraw', 'BFUHideHUD', BFUHideHUD )
	hook.Add( 'HUDPaint', 'BFUHUDDraw', BFUHUDDraw )
end