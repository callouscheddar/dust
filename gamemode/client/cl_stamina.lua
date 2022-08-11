hook.Add("CreateMove", "cl_stamina_Sprint", function(cmd)
    local ply = LocalPlayer()
    local NewButtons = cmd:GetButtons()
    -- check if playing is running in all directions, swimming, check their velocity, 
    if !player_values.hasStamina then
        NewButtons = NewButtons - IN_SPEED
    end
end)


-- check if play has stamina, control stamina
hook.Add("Think", "cl_hud_IsSprinting", function()
	local ply = LocalPlayer()
	
	if ply:IsSprinting() and player_values.stamina > 0 or player_values.hunger <= 0 then
		player_values.stamina = player_values.stamina - player_values.sprintRate
		player_values.energyRate = 5
	elseif player_values.stamina < 100 then
		player_values.stamina = player_values.stamina + player_values.sprintRate
		player_values.energyRate = 1
	end

	if player_values.stamina < 1 then
		player_values.hasStamina = false
	end
    
	if player_values.stamina > 10 then
		player_values.hasStamina = true
	end
end)