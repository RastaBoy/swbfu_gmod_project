AddCSLuaFile()

net.Receive("SelectClass", function()
    local Frame = vgui.Create( "DFrame" )
    Frame:SetTitle( "Test panel" )
    Frame:SetSize( 300,300 )
    Frame:Center()			
    Frame:MakePopup()
    Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 0, 0, 0, w, h, Color( 231, 76, 60, 150 ) ) -- Draw a red box instead of the frame
    end
            
    local Button = vgui.Create("DButton", Frame)
    Button:SetText( "Click me I'm pretty!" )
    Button:SetTextColor( Color(255,255,255) )
    Button:SetPos( 100, 100 )
    Button:SetSize( 100, 30 )
    Button.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) ) -- Draw a blue button
    end
    Button.DoClick = function()
        print( "I was clicked!" )
    end
end)