local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable('stalker',
{
    {"goldnugget",    1.00},
    {"goldnugget",    1.00},
    {"goldnugget",    1.00},
    {"goldnugget",    1.00},
})

local function postinitfn(inst)

    if not TheWorld.ismastersim then return end

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable('stalker')
    end

end

AddPrefabPostInit("stalker", postinitfn)