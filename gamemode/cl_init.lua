include("shared.lua")
include("client/cl_nametags.lua")
include("client/cl_hud.lua")
include("client/cl_creation.lua")
include("client/cl_stamina.lua")

surface.CreateFont( "CustomFont", {
	font = "ShareTechMono-Regular", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 13,
	weight = 500,
})