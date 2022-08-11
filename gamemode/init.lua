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
    ply:SetWalkSpeed(ply.values.speedWalk)
    ply:SetRunSpeed(ply.values.speedSprint)

    PlayerSetupSpawn(ply)
end)

hook.Add("PlayerSpawn", "init_PlayerSpawn", function(ply, trans)
    local randIndex = math.random(#citizen_models)
    local randCol = Vector(math.Rand(0, 1), math.Rand(0, 1), math.Rand(0, 1))


    -- Give the player a random model on spawn
    ply:SetModel(citizen_models[randIndex])
    ply:SetPlayerColor(randCol)

    PlayerSetupSpawn(ply)
end)

function PlayerSetupSpawn(ply)
    local map = game.GetMap()
    local spawnPos = Vector(-1976, -1982, -399)

    -- Spawn player at window area on gm_construct
    if map == "gm_construct" and spawnPos then
        ply:SetPos(spawnPos)
    end
end

hook.Add("Move", "cl_stamina_Sprint", function(ply, cmd)
    local NewButtons = cmd:GetButtons()
    -- check if playing is running in all directions, swimming, check their velocity, 
    
    if !ply.values.hasStamina then
        NewButtons = NewButtons - IN_SPEED
        ply:SetRunSpeed(125)
        cmd:SetMaxSpeed(125)
    end
end)
