AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("client/cl_nametags.lua")
AddCSLuaFile("client/cl_hud.lua")
AddCSLuaFile("client/cl_creation.lua")
AddCSLuaFile("client/cl_stamina.lua")

util.AddNetworkString("OutOfStamina")
util.AddNetworkString("ResetStamina")

include("shared.lua")

hook.Add("PlayerInitialSpawn", "init_InitalSpawn", function(ply, trans)
    local message = ply:Nick() .. " has joined the server, their IP: " .. ply:IPAddress()
    PrintMessage(HUD_PRINTTALK, message)
    
    // set speed of player
    ply:SetWalkSpeed(player_values.speedWalk)
    ply:SetRunSpeed(player_values.speedSprint)
end)

hook.Add("PlayerSpawn", "init_PlayerSpawn", function(ply, trans)
    local randIndex = math.random(#citizen_models)
    local randCol = Vector(math.Rand(0, 1), math.Rand(0, 1), math.Rand(0, 1))
    local map = game.GetMap()
    local spawnPos = Vector(-1976, -1982, -399)

    -- Give the player a random model on spawn
    ply:SetModel(citizen_models[randIndex])
    ply:SetPlayerColor(randCol)

    ply:SetWalkSpeed(player_values.speedWalk)
    ply:SetRunSpeed(player_values.speedSprint)

    -- Spawn player at window area on gm_construct
    if map == "gm_construct" and spawnPos then
        ply:SetPos(spawnPos)
    end
end)

