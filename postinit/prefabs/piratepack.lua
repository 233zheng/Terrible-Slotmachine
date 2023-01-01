local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

local function SpawnDubloon(inst, owner)
    local dubloon = SpawnPrefab("dubloon")
    local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0, 2, 0)

    dubloon.Transform:SetPosition(pt:Get())
    local angle = owner.Transform:GetRotation()*(PI / 180)
    local sp = (math.random() + 1) * -1
    dubloon.Physics:SetVel(sp * math.cos(angle), math.random() * 2 + 8, -sp * math.sin(angle))
	dubloon.components.inventoryitem:SetLanded(false, true)
end

local _onequip
local function onequip(inst, owner, ...)
    owner.AnimState:OverrideSymbol("swap_body", "swap_pirate_booty_bag", "backpack")
    owner.AnimState:OverrideSymbol("swap_body", "swap_pirate_booty_bag", "swap_body")

    if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end

    inst.dubloon_task = inst:DoPeriodicTask(TUNING.TOTAL_DAY_TIME/4, function() SpawnDubloon(inst, owner) end)
    if _onequip ~= nil then
        _onequip(inst, owner, ...)
    end
end

-- local _onburnt
-- local function onburnt(inst, ...)
--     if inst.components.container ~= nil then
--         inst.components.container:DropEverything()
--         inst.components.container:Close()
--     end

--     local ash = SpawnPrefab("ash")
--     ash.Transform:SetPosition(inst.Transform:GetWorldPosition())

--     inst:Remove()
--     if _onburnt then
--         onburnt(inst, ...)
--     end
-- end

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    if inst.components.equippable then
        inst.components.equippable:SetOnEquip(onequip)
    end

end

AddPrefabPostInit("piratepack", postinit)
