local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable( 'bearger',
{
    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             1.00},
    {'goldnugget',             0.50},
    {'goldnugget',             0.50},
    {'goldnugget',             0.50},
    {'goldnugget',             0.50},
    {'icepack',      0.50},
	{'icebox_blueprint',      1.00},
    {'goldnugget',      1.00},
	{'goldnugget',      1.00},
	{'goldnugget',      0.50},

	{'cutstone',      1.00},
    {'cutstone',      1.00},
	{'cutstone',      0.33},
    {'cutstone',      0.33},

    {'blueprint',      1.00},
    {'chesspiece_bearger_sketch', 1.00},
})

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    inst:RemoveComponent("drownable")

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable('bearger')
    end

end

AddPrefabPostInit("bearger", postinit)
