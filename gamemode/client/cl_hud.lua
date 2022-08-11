-- HUD elements to hide
local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudZoom = true,
	CHudWeaponSelection = false,
}

-- Hides HL2 HUD elements
hook.Add("HUDShouldDraw", "HideHUD", function(name)
	if hide[name] then return false end
end)


timer.Create("hungerTimer", 2, 0, function()
	local ply = LocalPlayer()
	ply.values.hunger = ply.values.hunger - (1 * ply.values.energyRate)
end)


-- override paint function, clear base functionality
function GM:HUDPaint()
end

-- health bar
hook.Add("HUDPaint", "cl_hud_HealthBar", function()
	local ply = LocalPlayer()

    if !ply:Alive() then return end

    local hbCol = Color(255, 0, 0, 250)
    local hbBg = Color(0, 0, 0, 210)
    local plyH = math.Clamp(ply:Health(), 0, ply:GetMaxHealth())
    local scrw, scrh = ScrW(), ScrH()

    surface.SetDrawColor(hbBg)
    surface.DrawRect(scrw * .0275, scrh * .955, 100 * 3, 10)
    surface.SetDrawColor(hbCol)
    surface.DrawRect(scrw * .025, scrh * .95, plyH * 3, 10)
end)

-- hunger bar
hook.Add("HUDPaint", "cl_hud_HungerBar", function()
	local ply = LocalPlayer()

    if !ply:Alive() then return end

    local hbCol = Color(0, 255, 0, 250)
    local hbBg = Color(0, 0, 0, 210)
    local scrw, scrh = ScrW(), ScrH()
	local hunger = math.Clamp(ply.values.hunger, 0, 200)

    surface.SetDrawColor(hbBg)
    surface.DrawRect(scrw * .0275, scrh * .935, 50 * 4, 10)
    surface.SetDrawColor(hbCol)
    surface.DrawRect(scrw * .025, scrh * .930, hunger, 10)
end)

hook.Add("HUDPaint", "cl_hud_StaminaBar", function()
	local ply = LocalPlayer()

    if !ply:Alive() then return end
	
    local ply = LocalPlayer()
    local hbCol = Color(0, 0, 255, 250)
    local hbBg = Color(0, 0, 0, 210)
    local scrw, scrh = ScrW(), ScrH()

    surface.SetDrawColor(hbBg)
    surface.DrawRect(scrw * 0.85, scrh * .955, 100 * 2, 10)
    surface.SetDrawColor(hbCol)
    surface.DrawRect(scrw * .8475, scrh * .950, ply.values.stamina * 2, 10)
end)

/*
Wiki Examples
hook.Add("PostDrawOpaqueRenderables", "example", function()
	-- Get the game's camera angles
	local angle = EyeAngles()

	-- Only use the Yaw component of the angle
	angle = Angle( 0, angle.y, 0 )

	-- Apply some animation to the angle
	-- angle.y = angle.y + math.sin( CurTime() ) * 50

	-- Correct the angle so it points at the camera
	-- This is usually done by trial and error using Up(), Right() and Forward() axes
	angle:RotateAroundAxis( angle:Up(), -90 )
	angle:RotateAroundAxis( angle:Forward(), 90 )

	-- A trace just for a position
	local trace = LocalPlayer():GetEyeTrace()
	local pos = trace.HitPos

	-- Raise the hitpos off the ground by 20 units and apply some animation
	pos = pos + Vector( 0, 0, math.cos( CurTime() / 0.4 ) + 20 )

	-- Notice the scale is small, so text looks crispier
	cam.Start3D2D( pos, angle, 1 )
		-- Get the size of the text we are about to draw
		local text = "Testing"
		surface.SetFont( "Default" )
		local tW, tH = surface.GetTextSize( "Testing" )

		-- This defines amount of padding for the box around the text
		local pad = 5

		-- Draw a rectable. This has to be done before drawing the text, to prevent overlapping
		-- Notice how we start drawing in negative coordinates
		-- This is to make sure the 3d2d display rotates around our position by its center, not left corner
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( -tW / 2 - pad, -pad, tW + pad * 2, tH + pad * 2 )

		-- Draw some text
		draw.SimpleText( "Testing", "Default", -tW / 2, 0, color_white )
	cam.End3D2D()
end )

hook.Add("PostDrawOpaqueRenderables", "example", function()
	local trace = LocalPlayer():GetEyeTrace()
	local angle = trace.HitNormal:Angle()
		
	render.DrawLine( trace.HitPos, trace.HitPos + 8 * angle:Forward(), Color( 255, 0, 0 ), true )
	render.DrawLine( trace.HitPos, trace.HitPos + 8 * -angle:Right(), Color( 0, 255, 0 ), true )
	render.DrawLine( trace.HitPos, trace.HitPos + 8 * angle:Up(), Color( 0, 0, 255 ), true )
		
	cam.Start3D2D( trace.HitPos, angle, 1 )
		surface.SetDrawColor( 255, 165, 0, 255 )
		surface.DrawRect( 0, 0, 8, 8 )
		render.DrawLine( Vector( 0, 0, 0 ), Vector( 8, 8, 8 ), Color( 100, 149, 237, 255 ), true )
	cam.End3D2D()
end )
*/
