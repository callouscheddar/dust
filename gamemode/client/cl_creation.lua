local t = ""
print("test")


local INPUT_LABEL = {}

function INPUT_LABEL:Init()
    self:Dock(TOP)
    self:DockMargin(10, 5, 10, 0)
    self:SetTextColor(Color(0, 0, 0))
end

local COMBO_BOX = {}

function COMBO_BOX:Init()
    self:Dock(TOP)
    self:DockMargin(10, 0, 10, 0)
end

vgui.Register("InputLabel", INPUT_LABEL, "DLabel")
vgui.Register("ComboBox", COMBO_BOX, "DComboBox")


concommand.Add("open_menu", function()
    local scrw, scrh = ScrW(), ScrH()
    local ply = LocalPlayer()

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
    
    local raceLabel = vgui.Create("InputLabel", inputPanel)
    raceLabel:SetText("Select your race: ")
    
    local raceCombo = vgui.Create("ComboBox", inputPanel)
    raceCombo:SetValue("Pick a Race")
    for _, value in ipairs(player_races) do
        raceCombo:AddChoice(value.name)
    end
    
    local raceDesc = vgui.Create("InputLabel", inputPanel)
    raceDesc:SetText("")
    
    function raceCombo:OnSelect(num, val, data)
        print("Changed", IsValid(raceDesc))
        if IsValid(raceDesc) then
            raceDesc:SetText("Test")
        end
    end
    
    local skillLabel = vgui.Create("InputLabel", inputPanel)
    skillLabel:SetText("Select your Skill: ")
    
    local skillCombo = vgui.Create("ComboBox", inputPanel)
    skillCombo:SetValue("Pick a Skill")
    for _, value in ipairs(player_skills) do
        skillCombo:AddChoice(value.name)
    end

    local traitLabel = vgui.Create("InputLabel", inputPanel)
    traitLabel:SetText("Select your Trait: ")
    
    local traitCombo = vgui.Create("ComboBox", inputPanel)
    traitCombo:SetValue("Pick a Trait")
    for _, value in ipairs(player_traits) do
        traitCombo:AddChoice(value.name)
    end
    

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
