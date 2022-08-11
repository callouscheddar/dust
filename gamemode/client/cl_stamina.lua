hook.Add("CreateMove", "Burger Sprint", function(cmd)
	local ply = LocalPlayer()
	local NewButtons = cmd:GetButtons()

	if cmd:KeyDown(IN_SPEED) and !ply.values.hasStamina then
        NewButtons = NewButtons - IN_SPEED
	end
	
	cmd:SetButtons(NewButtons)
end)

-- check if play has stamina, control stamina
hook.Add("Think", "cl_hud_IsSprinting", function()
    local ply = LocalPlayer()

	if ply:IsSprinting() and ply.values.stamina > 0 or ply.values.hunger <= 0 then
		ply.values.stamina = ply.values.stamina - ply.values.sprintRate
		ply.values.energyRate = 5
	elseif ply.values.stamina < 100 then
		ply.values.stamina = ply.values.stamina + ply.values.sprintRate
		ply.values.energyRate = 1
	end

	if ply.values.stamina < 1 then
		ply.values.hasStamina = false
	end
    
	if ply.values.stamina > 10 then
		ply.values.hasStamina = true
	end
end)