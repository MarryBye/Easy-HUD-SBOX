local MHUD = {}

local a, b, a2, b2 = 0, 0, ScrW() * 0 - 250, 0
local HUDEnable = true

surface.CreateFont( "3D_Font", {
	
	font = "Verdana",
	extended = true,
	size = 32,
	weight = 500,
	outline = true,

})

surface.CreateFont( "Font", {
	
	font = "Roboto",
	extended = true,
	size = 20,
	weight = 1000,
	outline = true,

})

surface.CreateFont( "Font2", {
	
	font = "Roboto",
	extended = true,
	size = 15,
	weight = 1000,
	outline = true,

})

surface.CreateFont( "SFont", {
	
	font = "Roboto",
	extended = true,
	size = 13,
	weight = 1000,
	outline = true,

})

local box = function(r, x, y, w, h, c)
    
    draw.RoundedBox(r, x, y, w, h, c)

end

local rect = function(m, x, y, w, h, c)

    if m == nil then
        
        surface.SetDrawColor(c)
        surface.DrawTexturedRect(x, y, w, h)
    
    else
    
        surface.SetMaterial(Material(m))
        surface.SetDrawColor(c)
        surface.DrawTexturedRect(x, y, w, h)

    end

end

local icon = function(m, x, y, w, h, c)
    
    surface.SetMaterial(Material(m))
    surface.SetDrawColor(c)
    surface.DrawTexturedRect(x, y, w, h)

end

local text = function(s, f, x, y, c, aX, aY)
    
    if aY == nil then

        draw.SimpleText(s, f, x, y, c, aX)

    else
        
        draw.SimpleText(s, f, x, y, c, aX, aY)

    end

end

MHUD.hud_list = {

    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudSuitPower"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true

}

MHUD.HideHUD = function(name)
    
    if MHUD.hud_list[name] then 
		
        return false 
	
    end

end
    
hook.Add("HUDShouldDraw", "HideHUD", MHUD.HideHUD)

MHUD.HideMouseHUD = function()
    
    return false

end

hook.Add("HUDDrawTargetID", "HideMouseHUD", MHUD.HideMouseHUD)

MHUD.DisplayNotify = function(msg)
    
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
    surface.PlaySound("buttons/lightswitch2.wav")
    MsgC(Color(255, 20, 20, 255), "[DarkRP] ", Color(200, 200, 200, 255), txt, "\n")

end

usermessage.Hook("_Notify", MHUD.DisplayNotify) 

function MHUD.DrawHUD()

	local multHUD = FrameTime()

	if not HUDEnable then
			
		a2 = Lerp(multHUD, a2, ScrW() * 0)
		b2 = Lerp(multHUD, b2, 175)
		
	else
			
		a2 = Lerp(multHUD, a2, ScrW() * 0 - 250)
		b2 = Lerp(multHUD, b2, 0)
		
	end
	
	box(1, a2, ScrH() - 250, 250, 35, Color(35, 35, 35, b2))
	box(1, a2, ScrH() - 250, 5, 35, Color(255, 255, 255, b2))

	box(1, a2, ScrH() - 200, 250, 35, Color(35, 35, 35, b2))
	box(1, a2, ScrH() - 200, 5, 35, Color(255, 255, 255, b2))

	box(1, a2, ScrH() - 150, 250, 35, Color(35, 35, 35, b2))
	box(1, a2, ScrH() - 150, 5, 35, Color(255, 255, 255, b2))

	box(1, a2, ScrH() - 100, 250, 35, Color(35, 35, 35, b2))
	box(1, a2, ScrH() - 100, 5, 35, Color(255, 255, 255, b2))

	box(1, a2, ScrH() - 50, 250, 35, Color(35, 35, 35, b2))
	box(1, a2, ScrH() - 50, 5, 35, Color(255, 255, 255, b2))

	text(LocalPlayer():Nick(), 'Font', a2 + 125, ScrH() - 243, Color(255, 255, 255, b2), TEXT_ALIGN_CENTER)
	text('ЗДОРОВЬЕ', 'Font2', a2 + 125, ScrH() - 195, Color(255, 255, 255, b2), TEXT_ALIGN_CENTER)
	text(LocalPlayer():Health(), 'SFont', a2 + 125, ScrH() - 180, Color(255, 255, 255, b2), TEXT_ALIGN_CENTER)
	text('БРОНЕЖИЛЕТ', 'Font2', a2 + 125, ScrH() - 145, Color(255, 255, 255, b2), TEXT_ALIGN_CENTER)
	text(LocalPlayer():Armor(), 'SFont', a2 + 125, ScrH() - 130, Color(255, 255, 255, b2), TEXT_ALIGN_CENTER)
	text('ОРУЖИЕ', 'Font2', a2 + 125, ScrH() - 95, Color(255, 255, 255, b2), TEXT_ALIGN_CENTER)
	text(LocalPlayer():GetActiveWeapon():GetPrintName(), 'SFont', a2 + 125, ScrH() - 80, Color(255, 255, 255, b2), TEXT_ALIGN_CENTER)
	text('ПАТРОНЫ', 'Font2', a2 + 125, ScrH() - 45, Color(255, 255, 255, b2), TEXT_ALIGN_CENTER)
	text(LocalPlayer():GetActiveWeapon():Clip1() .. ' / ' .. LocalPlayer():GetActiveWeapon():GetMaxClip1(), 'SFont', a2 + 125, ScrH() - 30, Color(255, 255, 255, b2), TEXT_ALIGN_CENTER)


end

hook.Add('HUDPaint', 'DrawHUD', MHUD.DrawHUD)

function MHUD.ButtonActivate(ply, button)
		
	if input.GetKeyName(button) == 'F9' then

		if not HUDEnable then
				
			HUDEnable = true
			
		else
				
			HUDEnable = false
			
		end
		
	end

end

hook.Add("PlayerButtonDown", "ButtonActivate", MHUD.ButtonActivate)

hook.Add("PostPlayerDraw", "3D2DNicks", function(ply)
	
	local Distance = LocalPlayer():GetPos():Distance(ply:GetPos())

	if not IsValid(ply) then return end 
	if not ply:Alive() then return end
	if ply == LocalPlayer() then return end 
	if ply:SetNoDraw() then return end
	if Distance > 300 then return end
 
	local offset = Vector(0, 0, 85)
	local ang = LocalPlayer():EyeAngles()
	local pos = LocalPlayer():GetEyeTrace().Entity:GetPos() + offset + ang:Up()
	 
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)
		
	cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.1)

		local mult = 0.01
		local mult2 = 0.01

		if LocalPlayer():GetEyeTrace().Entity:IsPlayer() then 

			a = Lerp(mult, a, 32 * string.len(LocalPlayer():GetEyeTrace().Entity:Nick()))
			b = Lerp(mult2, b, 125)

			box(7, -a / 2, 0, a, 50, Color(35, 35, 35, b))
			text(LocalPlayer():GetEyeTrace().Entity:Nick(), '3D_Font', 0, 5, Color(255, 255, 255, b), TEXT_ALIGN_CENTER)

		else

			a = 0
			b = 0

		end

	cam.End3D2D()
 
 end)
