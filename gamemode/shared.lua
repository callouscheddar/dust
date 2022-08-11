GM.Name = "Pickle"
GM.Author = "callousCheddar"
GM.Website = "https://github.com/callouscheddar/pickle"
GM.Email = ""
GM.BaseClass = ""

citizen_models = {}
citizen_models[1] = "models/player/Group01/male_01.mdl"
citizen_models[2] = "models/player/Group01/male_02.mdl"
citizen_models[3] = "models/player/Group01/male_03.mdl"
citizen_models[4] = "models/player/Group01/male_04.mdl"
citizen_models[5] = "models/player/Group01/male_05.mdl"
citizen_models[6] = "models/player/Group01/male_06.mdl"
citizen_models[7] = "models/player/Group01/male_07.mdl"
citizen_models[8] = "models/player/Group01/male_08.mdl"
citizen_models[9] = "models/player/Group01/male_09.mdl"



local Player = FindMetaTable("Player")

Player.values = {}
Player.values["hunger"]         = 1
Player.values["energyRate"]     = 1
Player.values["stamina"]        = 100
Player.values["sprintRate"]     = 0.065
Player.values["speedWalk"]      = 125
Player.values["speedSprint"]    = 225
Player.values["hasStamina"]     = true
Player.values["race"]           = "" -- default human
Player.values["skillPoints"]    = 10
Player.values["skills"]         = {
    strength        = 0,
    intelligence    = 0,
    agility         = 0,
}
Player.values["trait"]          = ""

/*
    Getters & Setters for player data
*/

-- HUNGER
function Player:GetHunger()
    return self.values.hunger
end

function Player:SetHunger(hunger)
    self.values.hunger = hunger
end

--  STAMINA
function Player:GetStamina()
    return self.values.stamina
end

function Player:SetStamina(stamina)
    self.values.stamina = stamina
end

-- SPRINT SPEED
function Player:GetSpeedSprint()
    return self.values.speedSprint
end

function Player:SetSpeedSprint(sprintSpeed)
    self.values.speedSprint = sprintSpeed
end

-- SKILL POINTS
function Player:GetSkillPoints()
    return self.values.skillPoints
end

function Player:SetSkillPoints(amount) 
    local points = GetSkillPoints()
    local newPoints = self.values.skillPoints + amount
    if points > 10 or newPoints < 0 then 
        print("Cannot have more than 10 points, or less than 0.") 
        return 
    end
    self.values.skillPoints = self.values.skillPoints + amount
end

-- SKILLS
function Player:GetSkills()
    return self.values.skills
end

function Player:SetSkills(skill, amount)
    local skills = self:GetSkills()
    local newAmount = skills[skill] + amount
    if newAmount < 0 then
        print("Cannot set skills less then 0") 
    end
    skills[skill] = newAmount
end


player_races = {}
player_races[1] = {
    name = "Human",
    description = "j mufukka wheels bitch"
}
player_races[2] = {
    name = "Ghoul",
    description = "Ugly mufukka"
}
player_races[3] = {
    name = "Borg",
    description = "robot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shitrobot n shit"
}

player_skills = {}
player_skills[1] = {
    name = "Strength",
    description = "Stat for lifting weights"
}
player_skills[2] = {
    name = "Intelligence",
    description = "Thinkin wit ur head"
}
player_skills[3] = {
    name = "Agility",
    description = "farts"
}
player_skill_points = 10

player_traits = {}
player_traits[1] = {
    name = "Drunk",
    description = "A need for alcohol"
}
player_traits[2] = {
    name = "Stupid",
    description = "Lack of intelligence, high strength"
}
player_traits[3] = {
    name = "Near-Blind",
    description = "Holy shit.. I'm blind!"
}
