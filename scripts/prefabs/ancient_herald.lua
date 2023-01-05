require "brains/ancientheraldbrain"
require "stategraphs/SGancientherald"

local assets =
{
    Asset("ANIM", "anim/ancient_spirit.zip"),
}

local prefabs =
{
    "goldnuggets",
}

local TARGET_DIST = 30

local loot = {
    'goldnugget',
    'goldnugget',
    'goldnugget',
    'goldnugget',
    'goldnugget',
    'nightmarefuel',
    'nightmarefuel',
    'armor_sanity',
    'nightsword',
}

local function CalcSanityAura(inst, observer)
    if inst.components.combat.target then
        return -TUNING.SANITYAURA_HUGE
    else
        return -TUNING.SANITYAURA_LARGE
    end
    return 0
end

local RETARGET_MUST_TAGS = { "_combat", "player"}
local RETARGET_CANT_TAGS = { "prey", "smallcreature", "INLIMBO", "ancient_herald"}
local function RetargetFn(inst)
    local range = inst:GetPhysicsRadius(0) + 16
    return FindEntity(
            inst,
            16,
            function(guy)
                return inst.components.combat:CanTarget(guy)
                    and not guy:HasTag("prey")
                    and not guy:HasTag("smallcreature")
                    and (guy.components.combat:TargetIs(inst) or
                            guy:IsNear(inst, range)
                        )
            end,
            RETARGET_MUST_TAGS,
            RETARGET_CANT_TAGS
        )
end

local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
end

local function oncollide(inst, other)
    if not other:HasTag("tree") then return end

    local v1 = Vector3(inst.Physics:GetVelocity())
    if v1:LengthSq() < 1 then return end

    inst:DoTaskInTime(2*FRAMES, function()
        if other and other.components.workable and other.components.workable.workleft > 0 then
            SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
            other.components.workable:Destroy(inst)
        end
    end)
end

local function fn()

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    local s  = 1.25
    inst.Transform:SetScale(s,s,s)
    inst.Transform:SetSixFaced()

    MakeCharacterPhysics(inst, 1000, .5)

    inst:AddTag("epic")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("ancient")
    inst:AddTag("shadow")
    inst:AddTag("scarytoprey")
    inst:AddTag("largecreature")
    inst:AddTag("laser_immune")
    -- inst:AddTag("notarget")
    inst:AddTag("ancient_herald")

    inst.AnimState:SetBank("ancient_spirit")
    inst.AnimState:SetBuild("ancient_spirit")
    inst.AnimState:PlayAnimation("idle", true)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("inspectable")
    inst:AddComponent("magicattack")

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.GHOST_SPEED
    inst.components.locomotor.runspeed = TUNING.GHOST_SPEED
    --inst.components.locomotor.directdrive = true

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.ANCIENT_HERALD_HEALTH)
    inst.components.health.destroytime = 3

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.ANCIENT_HERALD_DAMAGE)
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst.components.combat:SetRetargetFunction(3, RetargetFn)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)

    local brain = require "brains/ancientheraldbrain"
    inst:SetStateGraph("SGancientherald")
    inst:SetBrain(brain)

    inst:ListenForEvent("attacked", OnAttacked)

    inst.sg:GoToState("appear")

    inst:DoTaskInTime(0, function()
        inst.home_pos = Point(inst.Transform:GetWorldPosition())
    end )

    inst.summon_time = GetTime()
    inst.taunt_time = GetTime()

    return inst
end

return Prefab("ancient_herald", fn, assets, prefabs)
