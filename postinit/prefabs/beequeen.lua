local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable('beequeen',
{
    {'jellybean',      1.00},
    {'jellybean',      1.00},
    {'jellybean',      1.00},
    {'jellybean',      1.00},
    {'jellybean',      1.00},
    {'jellybean',      1.00},
    {'jellybean',      0.50},
    {'honeycomb',        1.00},
    {'honeycomb',        0.50},
    {'honey',            1.00},
    {'honey',            1.00},
    {'honey',            1.00},
    {'honey',            0.50},
    {'stinger',          1.00},
    {'hivehat',          1.00},
    {'bundlewrap_blueprint', 1.00},
	{'goldnugget', 1.00},
	{'goldnugget', 1.00},
	{'goldnugget', 1.00},
	{'goldnugget', 1.00},
	{'goldnugget', 1.00},
	{'goldnugget', 1.00},
})

local function PickHoney(inst)
    local rand = table.remove(inst.availablehoney, math.random(#inst.availablehoney))
    table.insert(inst.usedhoney, rand)
    if #inst.usedhoney > MAX_RECENT_HONEY then
        table.insert(inst.availablehoney, table.remove(inst.usedhoney, 1))
    end
    return rand
end

local HONEY_PERIOD = .2
local HONEY_LEVELS =
{
    {
        min_scale = .5,
        max_scale = .8,
        threshold = 8,
        duration = 1.2,
    },
    {
        min_scale = .5,
        max_scale = 1.1,
        threshold = 2,
        duration = 2,
    },
    {
        min_scale = 1,
        max_scale = 1.3,
        threshold = 1,
        duration = 4,
    },
}
----------------------------------postinit function----------------------------------------------

local _DoHoneyTrail
local function DoHoneyTrail(inst, ...)
    local level = HONEY_LEVELS[
        (not inst.sg:HasStateTag("moving") and 1) or
        (inst.components.locomotor.walkspeed <= TUNING.BEEQUEEN_SPEED and 2) or
        3
    ]

    inst.honeycount = inst.honeycount + 1

    if inst.honeythreshold > level.threshold then
        inst.honeythreshold = level.threshold
    end

    if inst.honeycount >= inst.honeythreshold then
        local hx, hy, hz = inst.Transform:GetWorldPosition()
        inst.honeycount = 0
        if inst.honeythreshold < level.threshold then
            inst.honeythreshold = math.ceil((inst.honeythreshold + level.threshold) * .5)
        end

        local fx = nil
        if TheWorld.Map:IsPassableAtPoint(hx, hy, hz) then
            fx = SpawnPrefab("honey_trail")
            fx:SetVariation(PickHoney(inst), GetRandomMinMax(level.min_scale, level.max_scale), level.duration + math.random() * .5)
        else
            fx = SpawnPrefab("splash_sink")
        end
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    end
    if _DoHoneyTrail ~= nil then
        _DoHoneyTrail(inst, ...)
    end
end

local function StartHoney(inst)
    if inst.honeytask == nil then
        inst.honeythreshold = HONEY_LEVELS[1].threshold
        inst.honeycount = math.ceil(inst.honeythreshold * .5)
        inst.honeytask = inst:DoPeriodicTask(HONEY_PERIOD, DoHoneyTrail, 0)
    end
end

local _RetargetFn
local RETARGET_MUST_TAGS = { "_combat" }
local RETARGET_CANT_TAGS = { "prey", "smallcreature", "INLIMBO","bee","beeguard" }
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
        )--, _RetargetFn(inst, ...)
end

local _OnAttacked
local function OnAttacked(inst, data, ...)
    if data.attacker ~= nil then
        local target = inst.components.combat.target
        inst.components.combat:SetTarget(data.attacker)
        inst.components.commander:ShareTargetToAllSoldiers(data.attacker)
    end
    if _OnAttacked ~= nil then
        _OnAttacked(inst, data, ...)
    end
end

local _OnAttackOther
local function OnAttackOther(inst, data, ...)
    if data.target ~= nil then
        local fx = SpawnPrefab("honey_trail")
        fx.Transform:SetPosition(data.target.Transform:GetWorldPosition())
        fx:SetVariation(PickHoney(inst), GetRandomMinMax(1, 1.3), 4 + math.random() * .5)
    end
    if _OnAttackOther ~= nil then
        _OnAttackOther(inst, data, ...)
    end
end

local _OnMissOther
local function OnMissOther(inst, ...)
    local x, y, z = inst.Transform:GetWorldPosition()
    local angle = -inst.Transform:GetRotation() * DEGREES
    local fx = SpawnPrefab("honey_trail")
    fx.Transform:SetPosition(x + TUNING.BEEQUEEN_ATTACK_RANGE * math.cos(angle), 0, z + TUNING.BEEQUEEN_ATTACK_RANGE * math.sin(angle))
    fx:SetVariation(PickHoney(inst), GetRandomMinMax(1, 1.3), 4 + math.random() * .5)
    if _OnMissOther ~= nil then
        _OnMissOther(inst, ...)
    end
end

--------------------------------------------------------------------------

local function postinit(inst)

    inst:RemoveTag("beequeen")

    if not TheWorld.ismastersim then return end

	inst:RemoveComponent("stuckdetection")

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable('beequeen')
    end

    if inst.components.combat then
        inst.components.combat:SetRetargetFunction(3, RetargetFn)
    end

    inst.StartHoney = StartHoney

    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttackOther)
    inst:ListenForEvent("onmissother", OnMissOther)

end

AddPrefabPostInit("beequeen", postinit)
