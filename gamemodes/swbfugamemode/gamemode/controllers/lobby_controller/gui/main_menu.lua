
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

vgui.Register( "PlayerClassSelector", PANEL, "Panel" )    
