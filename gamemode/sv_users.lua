UsersDb = {}

--[[
    Creates the users table.
    returns -> (bool)
]] 
UsersDb.Create = function()
    local result = sql.Query("CREATE TABLE IF NOT EXISTS users (steamId INT PRIMARY KEY, username TEXT);")
    return result
end

--[[
    Deletes the users table.
    returns -> null
]] 
UsersDb.Delete = function()
    local result = sql.Query("DROP TABLE IF EXISTS users")
end

--[[
    Deletes and creates the table
    returns -> null
]] 
UsersDb.Reset = function()
    UsersDb.Delete()
    UsersDb.Create()
end


--[[
    Get all from the users table.
    returns -> (table)
]] 
UsersDb.Get = function()
    local result = sql.Query("SELECT * FROM users")
    print(type(result))
    if result then
        if type(result) == 'table' then
            PrintTable(result)
        end
        return result
    else
        print("Get Query failed or users table already exists.")
    end
end

--[[
    Checks for a player in users, based on steamid64
    in the users table.
    returns -> (bool/table)
]] 
UsersDb.Check = function(ply)
    local result = sql.Query("SELECT steamId, username FROM users WHERE (steamId = " .. sql.SQLStr(ply:SteamID64()) .. ");")
    util.DebugPrint(result)
    return result
end

--[[
    Inserts a player in the users table.
    returns -> (bool)
]] 
UsersDb.Insert = function(ply)
    if !IsValid(ply) or type(ply) ~= 'player' then return end
    if not UsersDb.Check(ply) then
        local steam64 = sql.SQLStr(ply:SteamID64())
        local username = sql.SQLStr(ply:Nick())
        local result = sql.Query("INSERT INTO users (steamId, username) VALUES (" .. steam64 .. ", ".. username ..");" )
        if result then
            util.DebugPrint("User was added to the users table.")
        else
            util.DebugPrint("Could not insert user into users table, user might already exist or error in syntax.")
        end
    end
end

--[[
    Inserts a player in the users table.
    returns -> (bool/table)
]] 
UsersDb.Clear = function()
    local result = sql.Query("DELETE FROM users;")
    util.DebugPrint("Users table has been cleared.. I hope you know what you've done.")
    return result
end