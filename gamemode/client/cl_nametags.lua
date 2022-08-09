/*
    nametags
    Draw name above the players head
*/

-- Overwrite the HUDDrawTargetID
function GM:HUDDrawTargetID()
    local colWhite = Color(255, 255, 255)
    local pos = Vector(0, 0, 0)
    local ply = LocalPlayer()
    
    -- loop over all entities, and get pos
    for _, player in pairs(ents.GetAll()) do
        if type(player) == "Player" and player != LocalPlayer() then
            if ply:GetPos():Distance(player:GetPos()) > 150 then return end
            pos = player:EyePos()
            pos.z = pos.z + 12.5
            pos = pos:ToScreen()
            draw.DrawText(player:Nick(), "HudDefault", pos.x, pos.y, colWhite, TEXT_ALIGN_CENTER)
            break
        end
    end
end