-- Gets a player by their username/nickname
util.GetPlayer = function(nick)
    for k, v in pairs(ents:GetAll()) do
        if type(v) == 'Player' then
            if v:Nick() == nick then
                return v
            end
        end
    end
end

util.DebugPrint = function(msg)
    local time = math.Round(RealTime() / 60) .. " |"
    if type(msg) == 'table' then
        print(debugString)
        PrintTable(msg)
    end
    if PRINT_DEBUG then
        print(debugString)
        print(time .. " " .. msg)
    end
end
