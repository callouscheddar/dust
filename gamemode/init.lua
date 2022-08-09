AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

hook.Add("PlayerInitialSpawn", "init_InitalSpawn", function(ply, trans)
    local message = ply:Nick() .. " has joined the server, their IP: " .. ply:IPAddress()
    PrintMessage(HUD_PRINTTALK, message)
end)

hook.Add("PlayerSpawn", "init_PlayerSpawn", function(ply, trans)
    local randIndex = math.random(#citizen_models)
    local randCol = Vector(math.Rand(0, 1), math.Rand(0, 1), math.Rand(0, 1))
    local map = game.GetMap()
    local spawnPos = Vector(-1976, -1982, -399)

    -- Give the player a random model on spawn
    ply:SetModel(citizen_models[randIndex])
    ply:SetPlayerColor(randCol)

    -- Spawn player at window area on gm_construct
    if map == "gm_construct" then
        ply:SetPos(spawnPos)
    end
end)

--[[ test something on player
for key, value in pairs(ents.GetAll()) do
    if type(value) == "Player" then
        
        print(value:GetPos())
    end
end
--]]
