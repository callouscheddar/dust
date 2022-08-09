# Pickle
A garry's mod gamemode. The exact project goal isn't established other than learn GLua (and lua itself) to create  an interesting gamemode.

## Naming & Project Conventions:
## Functions:
    PascelCase
    ex. DoThisFunction()
## Variables:
    camelCase
    ex. variableNumberOne
## Hook Identifies
    filename_Description
    (full lowercase filename, PascelCase Description)
    ex. 
    hook.Add("PlayerInitialSpawn", "init_PrintHello", function()
    
    end)
## Comments:
    Single line use -- not // (-- Looks cleaner)
    Multi line use /* */ not --[[]] (Not use second variation to quick uncomment blocks of code)
    ex.
    -- Single Line
    /*
        Multi-Line
    */