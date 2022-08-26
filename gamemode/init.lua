AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('sv_users.lua')
include('sv_stats.lua')
include('sv_util.lua')
include('shared.lua')

util.AddNetworkString("SetStats")
util.AddNetworkString("GetStats")

local UsersDb = UsersDb or {}
local StatsDb = StatsDb or {}

PRINT_DEBUG = true

local testUser = util.GetPlayer('randomCheese')

function GM:Initialize()
    util.DebugPrint("Initializing function running, creating users table.")
    UsersDb.Create()
    StatsDb.Create()
end

function GM:PlayerInitialSpawn(ply, bool)
    UsersDb.Insert(ply)
    ply.stats = {}
end

net.Receive("SetStats", function(len, ply)
    local stats = {
        str = net.ReadInt(8),
        agi = net.ReadInt(8),
        int = net.ReadInt(8)
    }
    PrintTable(stats)
    StatsDb.Update(ply, stats)

    -- agility
    -- local newSpeed = ply:GetRunSpeed() * stats.agi
    -- ply:SetRunSpeed(newSpeed)

    -- strength
    -- local newHealth = ply:GetMaxHealth() * stats.str
    -- ply:SetMaxHealth(newHealth)
    -- ply:SetHealth(ply:GetMaxHealth())
end)

net.Receive("GetStats", function(len, ply)
    net.Start("GetStats")
        local stats = StatsDb.Get(ply)
        PrintTable(stats)
        -- net.WriteTable(StatsDb.Get(ply), 30)
    net.Send(ply)
end)