# Pickle
A garry's mod gamemode. The exact project goal isn't established other than learn GLua (and lua itself) and create an interesting gamemode.

## Naming & Project Conventions:
## Functions:
    PascelCase
    ex. DoThisFunction()
## Tables:
    snake_case
    citizen_outfits = {}
## Variables:
    camelCase
    ex. variableNumberOne
## Hook Identifiers
    filename_HookName or  filename_Description
    (full lowercase filename, PascelCase Description)
    ex. 
    hook.Add("PlayerInitialSpawn", "init_PrintHello", function()
        -- do something
    end)
## Comments:
    Single line use -- not // (-- Looks cleaner)
    Multi line use /* */ not --[[]] (Not use second variation to quick uncomment blocks of code)
    ex.
    -- Single Line
    /*
        Multi-Line
    */