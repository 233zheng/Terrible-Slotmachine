require "stategraphs/SGdungbeetle"

local DUNG_BEETLE_RUN_SPEED = 6
local DUNG_BEETLE_WALK_SPEED = 3.5
local DUNG_BEETLE_HEALTH = 60

local assets=
{
	Asset("ANIM", "anim/dung_beetle_basic.zip"),
	Asset("ANIM", "anim/dung_beetle_build.zip"),
}

local prefabs =
{
    "dungball",
    "monstermeat",
    "chitin",
}

SetSharedLootTable( 'dungbeetle',
{
    {'monstermeat',  1},
    {'chitin',    0.5},
})

local beetlesounds =
{
    scream = "dontstarve_DLC003/creatures/dungbeetle/scream",
    hurt = "dontstarve_DLC003/creatures/dungbeetle/hit",
}

local function OnWake(inst)

end

local function OnSleep(inst)

end

local function falloffdung(inst)
    inst:PushEvent("bumped")
end

local function OnAttacked(inst, data)
    local freezetask = inst:DoTaskInTime(1, function()
        if inst:HasTag("hasdung") and not inst.components.freezable:IsFrozen() then
            falloffdung(inst)
        end
    end)
end

local function HitShake()
    TheCamera:Shake("VERTICAL", 0.1, 0.01, 1)
end

local function oncollide(inst, other)

    if inst.sg:HasStateTag("running") and inst:HasTag("hasdung")  then

        if other then
            HitShake()
            falloffdung(inst)
        end
    end

end

local function GetStatus(inst)
    if not inst:HasTag("hasdung") then
        return "UNDUNGED"
    end
end

local function OnSave()

end

local function OnLoad()

end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddPhysics()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

	inst.DynamicShadow:SetSize( 2, 1.5)
    inst.Physics:SetCollisionCallback(oncollide)
    inst.Transform:SetSixFaced()

    MakeCharacterPhysics(inst, 1, 0.5)

    inst.AnimState:SetBank("dung_beetle")
    inst.AnimState:SetBuild("dung_beetle_build")
    if inst:HasTag("hasdung") then
        inst.AnimState:PlayAnimation("ball_idle")
    else
        inst.AnimState:PlayAnimation("idle")
    end

    inst:AddTag("hasdung")
    inst:AddTag("animal")
    inst:AddTag("dungbeetle")

 	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("sleeper")
    inst:AddComponent("knownlocations")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('dungbeetle')

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(DUNG_BEETLE_HEALTH)
    inst.components.health.murdersound = "dontstarve/rabbit/scream_short"

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = DUNG_BEETLE_RUN_SPEED
    inst.components.locomotor.walkspeed = DUNG_BEETLE_WALK_SPEED

    MakeSmallBurnableCharacter(inst, "body")
    MakeTinyFreezableCharacter(inst, "body")

    local brain = require "brains/dungbeetlebrain"
    inst:SetBrain(brain)
    inst:SetStateGraph("SGdungbeetle")

    inst.sg:GoToState("idle")

    inst.data = {}

	inst.OnEntityWake = OnWake
	inst.OnEntitySleep = OnSleep

    inst.sounds = beetlesounds

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst:ListenForEvent("attacked", OnAttacked)

    return inst
end

return Prefab( "forest/animals/dungbeetle", fn, assets, prefabs)
