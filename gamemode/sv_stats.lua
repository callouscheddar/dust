StatsDb = {}

--[[
    Creates the stats table.
    returns -> (bool)
]] 
StatsDb.Create = function()
    local result = sql.Query("CREATE TABLE IF NOT EXISTS stats (steamId INTEGER, str INTEGER, agi INTEGER, int INTEGER, FOREIGN KEY(steamId) REFERENCES users(steamId));")
    return result
end

--[[
    Deletes the stats table.
    returns -> null
]] 
StatsDb.Delete = function()
    local result = sql.Query("DROP TABLE IF EXISTS stats")
end

--[[
    Deletes and creates the table
    returns -> null
]] 
StatsDb.Reset = function()
    StatsDb.Delete()
    StatsDb.Create()
    util.DebugPrint("StatsDb Reset")
end

--[[
    Get all from the stats table.
    returns -> (table)
]] 
StatsDb.Get = function(ply)
    local steam64 = ply:SteamID64()
    local result = sql.Query("SELECT str, agi, int FROM stats WHERE steamId = " .. steam64 .. ";")
    if result then
        util.DebugPrint("Get Query success, returning data.")
        return result
    else
        util.DebugPrint("Get Query failed to get stats from user.")
        return false
    end
end

--[[
    Inserts a stats for player in the stats table.
    returns -> (bool)
]] 
StatsDb.Insert = function(ply, stats)
    if !IsValid(ply) or type(stats) ~= 'table' then return end 
    if not (stats.str and stats.agi and stats.int) then
        stats = {
            str = 0,
            agi = 0,
            int = 0
        }
    end
    if not StatsDb.Get(ply) then
        local steam64 = sql.SQLStr(ply:SteamID64())
        local result = sql.Query("INSERT INTO stats (steamId, str, agi, int) VALUES (" .. steam64 .. ", ".. stats.str .." , ".. stats.agi .." , ".. stats.int ..");" )
        if result then
            util.DebugPrint("Stats were added for " .. ply:Nick() .. " .")
        else
            util.DebugPrint("Could not insert stats into table, might already exist or error.")
        end
    end
end

--[[
    Inserts a stats for player in the stats table.
    returns -> (bool)
]] 
StatsDb.Update = function(ply, stats)
    if !IsValid(ply) or type(stats) ~= 'table' then return end 
    if StatsDb.Get(ply) then
        local steam64 = ply:SteamID64()
        if stats.str and stats.str and stats.str then
            local result = sql.Query("UPDATE stats SET str = ".. stats.str ..", agi = ".. stats.agi ..", int = ".. stats.int .." WHERE steamId = " .. steam64 .. ";" )
            util.DebugPrint("Stats were updated for " .. ply:Nick() .. ".")
        else
            util.DebugPrint("Some stats were not provided, query failed.")
        end
    end
end