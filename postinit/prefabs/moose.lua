local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable( 'moose',
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
        inst.components.lootdropper:SetChanceLootTable('moose')
    end

end

AddPrefabPostInit("moose", postinit)
