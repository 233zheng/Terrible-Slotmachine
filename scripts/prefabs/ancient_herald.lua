local brain = require "brains/ancientheraldbrain"
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

local function CalcSanityAura(inst, observer)
    if inst.components.combat.target then
        return -TUNING.SANITYAURA_HUGE
    else
        return -TUNING.SANITYAURA_LARGE
    end

    return 0
end

local function RetargetFn(inst)
    return FindEntity(inst, TARGET_DIST, function(guy)
        return inst.components.combat:CanTarget(guy)
               and not guy:HasTag("prey")
               and not guy:HasTag("smallcreature")
               and (inst.components.knownlocations:GetLocation("targetbase") == nil or guy.components.combat.target == inst)
    end)
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

local loot = {}

SetSharedLootTable( 'ancientherald',
{
    {'goldnugget',            1.00},
    {'goldnugget',            1.00},
    {'goldnugget',            1.00},
    {'goldnugget',            1.00},
    {'goldnugget',            1.00},
    {'nightmarefuel',              1.00},
    {'nightmarefuel',              1.00},
    {'nightmarefuel',              0.33},
})

local function onsave(inst, data)
    if inst:HasTag("aporkalypse_cleanup")then
        data.aporkalypse_cleanup = true
    end
end

local function onload(inst, data)
    if data then
        if data.aporkalypse_cleanup then
            inst:AddTag("aporkalypse_cleanup")
        end
    end
end

local function fn(Sim)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
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
    inst:AddTag("notarget")
    inst:AddTag("ancient_herald")

    inst.AnimState:SetBank("ancient_spirit")
    inst.AnimState:SetBuild("ancient_spirit")
    inst.AnimState:PlayAnimation("idle", true)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("inspectable")

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.GHOST_SPEED
    inst.components.locomotor.runspeed = TUNING.GHOST_SPEED
    --inst.components.locomotor.directdrive = true

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.DEERCLOPS_HEALTH)
    inst.components.health.destroytime = 3

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.ANCIENT_HERALD_DAMAGE)

    inst:AddComponent("lootdropper")
    -- inst.components.lootdropper:AddExternalLoot("ancient_remnant")
    -- inst.components.lootdropper:AddExternalLoot("nightmarefuel")
    inst.components.lootdropper:SetChanceLootTable('ancientherald')

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
