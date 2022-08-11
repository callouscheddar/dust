local t = ""

local INPUT_LABEL = {}

function INPUT_LABEL:Init()
    self:Dock(TOP)
    self:DockMargin(10, 5, 10, 0)
    self:SetTextColor(Color(0, 0, 0))
    self:SetFont("CustomFont")
end

local COMBO_BOX = {}

function COMBO_BOX:Init()
    self:Dock(TOP)
    self:DockMargin(10, 0, 10, 0)
end

-- local SKILL_WANG = {}

-- function SKILL_WANG:Init()
--     self:Dock(LEFT)
--     self:HideWang()
--     self:SetMinMax(0, 10)
--     self:SetDecimals(0)
-- end

vgui.Register("InputLabel", INPUT_LABEL, "DLabel")
vgui.Register("ComboBox", COMBO_BOX, "DComboBox")
-- vgui.Register("SkillWang", SKILL_WANG, "DNumberWang")


concommand.Add("open_menu", function()
    local scrw, scrh = ScrW(), ScrH()
    local ply = LocalPlayer()

    local color_black = Color(0, 0, 0)

    local inpName, inpRace, inpSkill, inpTrat

    local menu = vgui.Create("DFrame")
    menu:SetSize(scrw, scrh)
    menu:MakePopup()

    /*
        PLAYER INPUT PANEL
        Character Name, Race, Skill
    */

    local inputPanel = vgui.Create("DPanel", menu)
    inputPanel:SetWide(scrw/2.05)
    inputPanel:Dock(LEFT)
    inputPanel:DockMargin(10, 0, 10, 0)    

    /*
        DESCRIPTION PANEL
    */

    local descriptionPanel = vgui.Create("DPanel", inputPanel)
    descriptionPanel:SetWide(inputPanel:GetWide() / 2)
    descriptionPanel:Dock(RIGHT)
    
    // PLAYER NAME VGUI
    local nameLabel = vgui.Create("InputLabel", inputPanel)
    nameLabel:SetText("Write Your Name: ")
    
    local nameInput = vgui.Create("DTextEntry", inputPanel)
    nameInput:Dock(TOP)
    nameInput:DockMargin(10, 0, 10, 0)
    nameInput:SetPlaceholderText("Enter Name (20 Characters Max, No Numbers!)")
    nameInput:SetNumeric(false)
    function nameInput:OnChange()
        print(self:GetValue())
    end
    
    // RACE VGUI
    local raceLabel = vgui.Create("InputLabel", inputPanel)
    local raceCombo = vgui.Create("ComboBox", inputPanel)
    local raceDesc = vgui.Create("InputLabel", inputPanel)
    
    raceLabel:SetText("Select your race: ")
    
    raceCombo:SetValue("Pick a Race")
    for _, value in ipairs(player_races) do
        raceCombo:AddChoice(value.name)
    end
    
    function raceCombo:OnSelect(num, val, data)
        if IsValid(raceDesc) then
            raceDesc:SetText("Description: ".. player_races[num].description)
            raceDesc:SetAutoStretchVertical(true)
        end
    end
    
    raceDesc:SetText("You have no selected a skill yet.")
    
    // TRAIT VGUI
    local traitLabel = vgui.Create("InputLabel", inputPanel)
    local traitCombo = vgui.Create("ComboBox", inputPanel)
    local traitDesc = vgui.Create("DLabel", inputPanel)
    
    traitLabel:SetText("Select your Trait: ")
    
    traitCombo:SetValue("Pick a Trait")
    for _, value in ipairs(player_traits) do
        traitCombo:AddChoice(value.name)
    end
    function traitCombo:OnSelect(num, val, data)
        if IsValid(traitDesc) then
            traitDesc:SetText("Description: " .. player_traits[num].description)
        end
    end

    traitDesc:Dock(TOP)
    traitDesc:SetTextColor(color_black)
    traitDesc:SetText("You haven't selected a trait yet.")
    traitDesc:DockMargin(10, 5, 10, 0)
    
    // SKILL VGUI
    local skillHeader = vgui.Create("InputLabel", inputPanel)
    local skillPanels = {}
    local skillsAmount = {}
    local skillsLabels = {}
    local skillsAdd = {}
    local skillsSub = {}
    
    skillHeader:SetText("Assign Your Skill Points: ")
    
    for index, skill in ipairs(player_skills) do
        -- panel to hold name, current points, and buttons
        skillPanels[index] = vgui.Create("DPanel", inputPanel)
        skillPanels[index]:Dock(TOP)
        skillPanels[index]:DockMargin(10, 0, 10, 0)

        -- skills name labels
        skillsLabels[index] = vgui.Create("DLabel", skillPanels[index])
        skillsLabels[index]:Dock(LEFT)
        skillsLabels[index]:SetTextColor(color_black)
        skillsLabels[index]:SetText(skill.name)

        -- current points in said skill
        skillsAmount[index] = vgui.Create("DLabel", skillPanels[index])
        skillsAmount[index]:Dock(LEFT)
        skillsAmount[index]:SetTextColor(color_black)
        skillsAmount[index]:SetText("0")
        skillsAmount[index].skill = skill.name

        -- add points vgui
        skillsAdd[index] = vgui.Create("DButton", skillPanels[index])
        skillsAdd[index]:Dock(LEFT)
        skillsAdd[index]:SetText("+")
        skillsAdd[index]:SetWide(24)
        skillsAdd[index].skill = skill.name

        -- subtract points vgui
        skillsSub[index] = vgui.Create("DButton", skillPanels[index])
        skillsSub[index]:Dock(LEFT)
        skillsSub[index]:SetText("-")
        skillsSub[index]:SetWide(24)
        skillsSub[index].skill = skill.name
    end

    -- updates our skillsAmount vgui w/ proper skill amount
    function UpdateSkillsAmount() 
        local skills = ply:GetSkills()
        for index, value in ipairs(skillsAmount) do
            local skillName = string.lower(skillsAmount[index].skill)
            local skillAmount = ply.values.skills[skillName]
            print(skillAmount)
            skillsAmount[index]:SetText(skillAmount)
        end
    end

    function UpdateTotalSkillPoints()

    end

    -- add functionality to doclick for plus skill btn's
    for index, value in ipairs(skillsAdd) do
        value.DoClick = function()
            local result = ply:SetSkills(value.skill, 1)
            UpdateSkillsAmount()
        end
    end

    for index, value in ipairs(skillsSub) do
        value.DoClick = function()
            local result = ply:SetSkills(value.skill, -1)
            print(result)
            UpdateSkillsAmount()
        end
    end

    -- check to see change on skillsvgui
    -- for index, value in ipairs(skillsVGUI) do
    --     function value:OnValueChange(val)
    --         print(val)
    --     end
    --     -- local curPoints = ply:GetSkillPoints()
    --     -- if curPoints < 0 then return end
    --     -- ply:SetSkillPoints(val)
    -- end

    local skillPoints = vgui.Create("DLabel", inputPanel)

    skillPoints:Dock(TOP)
    skillPoints:DockMargin(10, 5, 10, 0)
    skillPoints:SetTextColor(color_black)
    skillPoints:SetText("Available Points: " .. player_skill_points)

    -- local skillWang = vgui.Create("ComboBox", inputPanel)
    -- skillCombo:SetValue("Pick a Skill")
    -- for _, value in ipairs(player_skills) do
    --     skillCombo:AddChoice(value.name)
    -- end

    /*
        MODEL PANEL
    */

    local modelPanel = vgui.Create("DPanel", menu)
    modelPanel:SetWide(scrw/2.05)
    modelPanel:Dock(RIGHT)
    modelPanel:DockMargin(10, 0, 10, 0)

    local model = vgui.Create("DModelPanel", modelPanel)
    model:Dock(FILL)
    model:SetModel(ply:GetModel())
    model:SetFOV(60)
    function model:LayoutEntity(ent)
        ent:SetAngles(Angle(0, 50 + (SysTime() * 50), 0))
    end

    UpdateSkillsAmount()
end)

/* gmod wiki reference
local PANEL = {}

function PANEL:Init()

	self:SetText_Base( "" )
	self:SetText( "Time for something different!" )
    self:MakePopup()
end

function PANEL:Paint( aWide, aTall )

	local TextX, TextY = 0, 0
	local TextColor = Color( 255, 0, 0, 255 )

	surface.SetFont( self:GetFont() or "default" )
	surface.SetTextColor( TextColor )
	surface.SetTextPos( TextX, TextY )
	surface.DrawText( self:GetText() )

end

-- And here we go:
PANEL.SetText_Base = FindMetaTable( "Panel" ).SetText

function PANEL:SetText( aText ) 

	self.Text = tostring( aText ) 

end

function PANEL:GetText() 

	return self.Text or "" 

end

vgui.Register( "NewPanel", PANEL, "Panel" )
*/
