GLOBAL.setfenv(1, GLOBAL)

function c_allplayergotoslotmachine()
    local slotmachine = c_findtag("slotmachine")
    local x,y,z = slotmachine.Transform:GetWorldPosition()
    for k,v in pairs(AllPlayers) do
        v.Transform:SetPosition(x,y,z)
    end
end
