local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable('toadstool',
{
    {"froglegs",      1.00},
    {"meat",          1.00},
    {"meat",          1.00},
    {"meat",          1.00},
    {"meat",          0.50},
    {"meat",          0.25},

    {"ruinshat", 1.00},
    {"ruinshat",       1.00},
    {"ruinshat",       0.33},
    {"ruinshat",       0.33},

    {"blue_cap",      1.00},
    {"blue_cap",      0.33},
    {"blue_cap",      0.33},

    {"goldnugget",    1.00},
    {"goldnugget",    1.00},
    {"goldnugget",    1.00},
    {"goldnugget",    1.00},

    {"armorruins",     1.00},
    {"armorruins",     0.33},
    {"armorruins",     0.33},
    {"armorruins",   1.00},
})

local _DropShroomSkin
local function DropShroomSkin(inst, ...)
    local player--[[, rangesq]] = inst:GetNearestPlayer()
    LaunchAt(SpawnPrefab("armorruins"), inst, player, 1, 4, 2)
    if _DropShroomSkin ~= nil then
        _DropShroomSkin(inst, ...)
    end
end

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    if inst.components.health then
        inst.components.health:SetMaxHealth(TUNING.TOADSTOOL_HEALTH/2)
    end

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable("toadstool")
    end

end

AddPrefabPostInit("toadstool", postinit)
