local MHUD = {}

local boxWidthLerp3D, boxWidthDescLerp3D, alphaLerp3D, animationHUD, alphaLerpHUD = 0, 0, 0, ScrW() * 0 - 250, 0

surface.CreateFont( "3D_Font", {
	
	font = "Verdana",
	extended = true,
	size = 32,
	weight = 500,
	outline = true,

})

surface.CreateFont( "3D_Font_Desc", {
	
	font = "Verdana",
	extended = true,
	size = 24,
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

--[[
======================================================================
==============================CLASSIC HUD===============================
======================================================================
]]

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

--[[
======================================================================
===============================MAIN HUD================================
======================================================================
]]

function MHUD.DrawHUD()

	local locply = LocalPlayer()

	if not LocalPlayer().HUDEnable then
			
		animationHUD = Lerp(FrameTime(), animationHUD, ScrW() * 0)
		alphaLerpHUD = Lerp(FrameTime(), alphaLerpHUD, 175)
		
	else
			
		animationHUD = Lerp(FrameTime(), animationHUD, ScrW() * 0 - 250)
		alphaLerpHUD = Lerp(FrameTime(), alphaLerpHUD, 0)
		
	end
	
	box(1, animationHUD, ScrH() - 250, 250, 35, Color(35, 35, 35, alphaLerpHUD))
	box(1, animationHUD, ScrH() - 250, 5, 35, Color(255, 255, 255, alphaLerpHUD))

	box(1, animationHUD, ScrH() - 200, 250, 35, Color(35, 35, 35, alphaLerpHUD))
	box(1, animationHUD, ScrH() - 200, 5, 35, Color(255, 255, 255, alphaLerpHUD))

	box(1, animationHUD, ScrH() - 150, 250, 35, Color(35, 35, 35, alphaLerpHUD))
	box(1, animationHUD, ScrH() - 150, 5, 35, Color(255, 255, 255, alphaLerpHUD))

	box(1, animationHUD, ScrH() - 100, 250, 35, Color(35, 35, 35, alphaLerpHUD))
	box(1, animationHUD, ScrH() - 100, 5, 35, Color(255, 255, 255, alphaLerpHUD))

	box(1, animationHUD, ScrH() - 50, 250, 35, Color(35, 35, 35, alphaLerpHUD))
	box(1, animationHUD, ScrH() - 50, 5, 35, Color(255, 255, 255, alphaLerpHUD))

	text(LocalPlayer():Nick(), 'Font', animationHUD + 125, ScrH() - 243, Color(255, 255, 255, alphaLerpHUD), TEXT_ALIGN_CENTER)
	text('ЗДОРОВЬЕ', 'Font2', animationHUD + 125, ScrH() - 195, Color(255, 255, 255, alphaLerpHUD), TEXT_ALIGN_CENTER)
	text(LocalPlayer():Health(), 'SFont', animationHUD + 125, ScrH() - 180, Color(255, 255, 255, alphaLerpHUD), TEXT_ALIGN_CENTER)
	text('БРОНЕЖИЛЕТ', 'Font2', animationHUD + 125, ScrH() - 145, Color(255, 255, 255, alphaLerpHUD), TEXT_ALIGN_CENTER)
	text(LocalPlayer():Armor(), 'SFont', animationHUD + 125, ScrH() - 130, Color(255, 255, 255, alphaLerpHUD), TEXT_ALIGN_CENTER)
	text('ОРУЖИЕ', 'Font2', animationHUD + 125, ScrH() - 95, Color(255, 255, 255, alphaLerpHUD), TEXT_ALIGN_CENTER)
	
	if LocalPlayer():Health() > 0 and IsValid(LocalPlayer():GetActiveWeapon()) then

		text(LocalPlayer():GetActiveWeapon():GetPrintName(), 'SFont', animationHUD + 125, ScrH() - 80, Color(255, 255, 255, alphaLerpHUD), TEXT_ALIGN_CENTER)
	
	end

	text('ПАТРОНЫ', 'Font2', animationHUD + 125, ScrH() - 45, Color(255, 255, 255, alphaLerpHUD), TEXT_ALIGN_CENTER)
	
	if LocalPlayer():Health() > 0 and IsValid(LocalPlayer():GetActiveWeapon()) then
		
		text(LocalPlayer():GetActiveWeapon():Clip1() .. ' / ' .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), 'SFont', animationHUD + 125, ScrH() - 30, Color(255, 255, 255, alphaLerpHUD), TEXT_ALIGN_CENTER)

	end

end

hook.Add('HUDPaint', 'DrawHUD', MHUD.DrawHUD)

--[[
======================================================================
===============================BIND HUD================================
======================================================================
]]

function MHUD.ButtonActivate(ply, button)
		
	if input.GetKeyName(button) == 'F9' then

		if not ply.HUDEnable then
				
			ply.HUDEnable = true
			
		else
				
			ply.HUDEnable = false

		end
		
	end

end

hook.Add("PlayerButtonDown", "ButtonActivate", MHUD.ButtonActivate)

--[[
======================================================================
===============================3D2D HUD================================
======================================================================
]]

function MHUD.HeadNicks(ply)

	local locply = LocalPlayer()
	local entTrace = locply:GetEyeTrace().Entity
	
	if not entTrace:IsPlayer() then 

		if boxWidthLerp3D > 0 or boxWidthDescLerp3D > 0 or alphaLerp3D > 0 then
			
			boxWidthLerp3D = 0
			boxWidthDescLerp3D = 0
			alphaLerp3D = 0

		end

		return 

	end

	if not entTrace:Alive() then return end
	if ply == locply then return end 
	if entTrace:SetNoDraw() then return end
	
	local Distance = locply:GetPos():Distance(entTrace:GetPos())

	if Distance > 300 then return end
 
	local offset = Vector(0, 0, 85)
	local ang = locply:EyeAngles()
	local pos = entTrace:GetPos() + offset + ang:Up()

	local frontPlayerNick = entTrace:Nick()
	local description = entTrace:GetPData('Description', 'Нет описания для данного персонажа!')

	local widthN, heightN = surface.GetTextSize(frontPlayerNick)
	local widthD, heightD = surface.GetTextSize(description)
	 
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)
		
	cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.1)

		boxWidthLerp3D = Lerp(0.01, boxWidthLerp3D, 1.8 * widthN)
		alphaLerp3D = Lerp(0.001, alphaLerp3D, 125)

		box(7, -boxWidthLerp3D / 2, 0, boxWidthLerp3D, 50, Color(35, 35, 35, alphaLerp3D))
		text(frontPlayerNick, '3D_Font', 0, 5, Color(255, 255, 255, alphaLerp3D), TEXT_ALIGN_CENTER)

		boxWidthDescLerp3D = Lerp(0.01, boxWidthDescLerp3D, 1.1 * widthD)

		box(7, -boxWidthDescLerp3D / 2, 65, boxWidthDescLerp3D, 50, Color(35, 35, 35, alphaLerp3D))
		text(description, '3D_Font_Desc', 0, 76, Color(255, 255, 255, alphaLerp3D), TEXT_ALIGN_CENTER)

	cam.End3D2D()
 
end

 hook.Add("PostPlayerDraw", "HeadNicks", MHUD.HeadNicks)
