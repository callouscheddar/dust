include('shared.lua')

local function SetStats(stat1, stat2, stat3)
	net.Start("SetStats")
		net.WriteUInt(stat1, 4)
		net.WriteUInt(stat2, 4)
		net.WriteUInt(stat3, 4)
	net.SendToServer()
end

local function GetStats()
	net.Start("GetStats")
	net.SendToServer()

	local stats = {}
	net.Receive("GetStats", function()
		stats = net.ReadTable()
	end)
	PrintTable(stats)
	return stats
end

local function Skills()
	-- Check if frame is active, close if true
	if IsValid(frame) then return end

	local sreenW, screenH = ScrW(), ScrH()
	local fWidth, fHeight = ScrW() * 0.25, ScrH() * 0.225
	local frame = vgui.Create("DFrame")
	frame:SetTitle("Skills Menu")
	frame:SetSize(fWidth, fHeight)
	frame:SetPos(sreenW / 2 - fWidth / 2, screenH / 2 - fHeight / 2)
	frame:MakePopup()
	frame:SetScreenLock(true)
	-- frame:SetBackgroundBlur(true)

	local sWidth = 50

	local slider1 = vgui.Create("DNumSlider", frame)
	slider1:SetPos(25, 30)
	slider1:SetSize(fWidth - 25, sWidth)
	slider1:SetText("Strength")
	slider1:SetMin(0)
	slider1:SetMax(10)
	slider1:SetDecimals(0)	

	local slider2 = vgui.Create("DNumSlider", frame)
	slider2:SetPos(25, 60)
	slider2:SetSize(fWidth - 25, sWidth)
	slider2:SetText("Agility")
	slider2:SetMin(0)
	slider2:SetMax(10)
	slider2:SetDecimals(0)

	local slider3 = vgui.Create("DNumSlider", frame)
	slider3:SetPos(25, 90)
	slider3:SetSize(fWidth - 25, sWidth)
	slider3:SetText("Intelligence")
	slider3:SetMin(0)
	slider3:SetMax(10)
	slider3:SetDecimals(0)

	local submit = vgui.Create("DButton", frame)
	submit:SetPos(25, 150)
	submit:SetSize(fWidth - 50, 35)
	submit:SetText("Submit")
	function submit:DoClick()
		local stat1 = math.Round(slider1:GetValue())
		local stat2 = math.Round(slider2:GetValue())
		local stat3 = math.Round(slider3:GetValue())

		local total = stat1 + stat2 + stat3
		if total > 10 then
			print("You can only spend 10 points.")
		else
			SetStats(stat1, stat2, stat3)
			frame:Close()
		end
	end
end

concommand.Add("getstats", GetStats)
concommand.Add("statmenu", Skills)