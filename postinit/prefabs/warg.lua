local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable('warg2',
{
    {'monstermeat',             1.00},
    {'monstermeat',             1.00},
    {'monstermeat',             1.00},
    {'monstermeat',             1.00},
    {'monstermeat',             0.50},
    {'monstermeat',             0.50},

    {'goldnugget',             1.00},
    {'goldnugget',             0.66},
    {'goldnugget',             0.33},
})

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable('warg2')
    end

end

AddPrefabPostInit("warg", postinit)
