local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable("tigershark",
{
    {"fishmeat", 1.00},
    {"fishmeat", 1.00},
    {"fishmeat", 1.00},
    {"fishmeat", 1.00},
    {"fishmeat", 1.00},
    {"fishmeat", 1.00},
    {"fishmeat", 1.00},
    {"fishmeat", 1.00},

    {"tigereye", 1.00},
    {"tigereye", 0.50},

    {'harpoon',     1.00},

    {'goldnugget',  1.00},
    {'goldnugget',  1.00},
    {'goldnugget',  1.00},

    {"shark_gills", 1.00},
    {"shark_gills", 1.00},
    {"shark_gills", 0.33},
    {"shark_gills", 0.10},
})

local function postinitfn(inst)

    if not TheWorld.ismastersim then return end

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable('tigershark')
    end

end

AddPrefabPostInit("tigershark", postinitfn)