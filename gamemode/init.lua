AddCSLuaFile('cl_init.lua')

include('shared.lua')

hook.Add("PlayerInitialSpawn", "init_InitalSpawn", function(ply, trans)
    local message = ply:Nick() .. " has joined the server, their IP: " .. ply:IPAddress()
    PrintMessage(HUD_PRINTTALK, message)
end)