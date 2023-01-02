local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable( 'moose2',
{
    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             1.00},
    {'goldnugget',             1.00},
    {'goldnugget',             1.00},
    {'drumstick',        1.00},
    {'drumstick',        1.00},
    {'staff_tornado',    1.00},
    {'staff_tornado',    1.00},
})

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable('moose2')
    end

end

AddPrefabPostInit("moose", postinit)
