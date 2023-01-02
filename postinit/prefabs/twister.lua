local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable("twister2",
{
    {"turbine_blades",   1.00},
    {"goldnugget",   1.00},
    {"goldnugget",   1.00},
    {"goldnugget",   1.00},
    {"staff_tornado",   1.00},
    {"staff_tornado",   1.00},
})

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable('twister2')
    end

end

AddPrefabPostInit("twister", postinit)
