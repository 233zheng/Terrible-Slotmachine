local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable('dragonfly',
{
    {'armorruins',             1.00},
    {'ruinshat',1.00},
    {'ruins_bat', 1.00},
    {'lavae_egg',                 0.33},
    {'cutlass',      1.00},


    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             1.00},
    {'armordragonfly',    1.00},
	{'obsidianfirepit_blueprint',    1.00},
	{'obsidian',             1.00},
	{'obsidian',             1.00},
	{'obsidian',             1.00},
	{'obsidian',             1.00},
	{'obsidian',             0.50},

	{'blueprint',             1.00},

    {'goldnugget',       1.00},
    {'goldnugget',       1.00},
    {'goldnugget',       1.00},
    {'goldnugget',       1.00},

    {'goldnugget',       0.50},
    {'goldnugget',       0.50},
    {'goldnugget',       0.50},
    {'goldnugget',       0.50},
    {'goldnugget',         0.50},
})

local _SoftReset
local function SoftReset(inst, ...)
    inst.components.health:SetCurrentHealth(10000)
    if _SoftReset ~= nil then
		_SoftReset(inst, ...)
	end
end

local function UpdatePlayerTargets(inst)
    local toadd = {}
    local toremove = {}
    local pos = inst.components.knownlocations:GetLocation("spawnpoint")

    for k, v in pairs(inst.components.grouptargeter:GetTargets()) do
        toremove[k] = true
    end
    for i, v in ipairs(FindPlayersInRange(pos.x, pos.y, pos.z, TUNING.DRAGONFLY_RESET_DIST, true)) do
        if toremove[v] then
            toremove[v] = nil
        else
            table.insert(toadd, v)
        end
    end

    for k, v in pairs(toremove) do
        inst.components.grouptargeter:RemoveTarget(k)
    end
    for i, v in ipairs(toadd) do
        inst.components.grouptargeter:AddTarget(v)
    end
end

local function TryGetNewTarget(inst)
    UpdatePlayerTargets(inst)

    local new_target = inst.components.grouptargeter:SelectTarget()
    if new_target ~= nil then
        inst.components.combat:SetTarget(new_target)
    end
end

local function TrySoftReset(inst)
    if inst.SoftResetTask == nil then
        --print(string.format("Dragonfly - Start soft reset task @ %2.2f", GetTime()))
        inst.SoftResetTask = inst:DoTaskInTime(10, SoftReset)
    end
end

local function OnTargetDeathTask(inst)
    inst._ontargetdeathtask = nil
    TryGetNewTarget(inst)
    if inst.components.combat.target == nil and inst.components.grouptargeter.num_targets <= 0 then
        TrySoftReset(inst)
    end
end

local _RetargetFn
local RETARGET_MUST_TAGS = { "_combat" }
local RETARGET_CANT_TAGS = { "prey", "smallcreature", "INLIMBO","lavae" }
local function RetargetFn(inst, ...)
    local range = inst:GetPhysicsRadius(0) + 16
    return FindEntity(
            inst,
            16,
            function(guy)
                return inst.components.combat:CanTarget(guy)
                    and (   guy.components.combat:TargetIs(inst) or
                            guy:IsNear(inst, range)
                        )
            end,
            RETARGET_MUST_TAGS,
            RETARGET_CANT_TAGS
        )
end

local _OnAttacked
local function OnAttacked(inst, data, ...)
    if data.attacker ~= nil then
        local target = inst.components.combat.target
            inst.components.combat:SetTarget(data.attacker)
    end
    if _OnAttacked ~= nil then
        _OnAttacked(inst, data, ...)
    end
end

local function postinitfn(inst)

    if not TheWorld.ismastersim then return end

	inst:RemoveComponent("stuckdetection")

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable('dragonfly')
    end

    if inst.components.combat then
        inst.components.combat:SetRetargetFunction(3, RetargetFn)
    end

    inst._ontargetdeathtask = nil
    inst._ontargetdeath = function()
        if inst._ontargetdeathtask == nil then
            inst._ontargetdeathtask = inst:DoTaskInTime(2, OnTargetDeathTask)
        end
    end

    inst:ListenForEvent("attacked", OnAttacked)

end

AddPrefabPostInit("dragonfly", postinitfn)
