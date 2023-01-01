require "brains/perdbrain"
require "stategraphs/SGperd"

local THUNDERBIRD_RUN_SPEED = 5.5
local THUNDERBIRD_WALK_SPEED = 2

local assets=
{
	--Asset("ANIM", "anim/perd_basic.zip"),
	Asset("ANIM", "anim/thunderbird.zip"),
    Asset("ANIM", "anim/thunderbird_fx.zip"),
	Asset("SOUND", "sound/perd.fsb"),
}

local prefabs =
{
    "drumstick",
    "feather_thunder",
    "thunderbird_fx",
}

local loot =
{
    "drumstick",
    "drumstick",
    "feather_thunder"
}

local function DoLightning(inst, target)
    local LIGHTNING_COUNT = 3
    local COOLDOWN = 60

    for i=1, LIGHTNING_COUNT do
        inst:DoTaskInTime(0.4*i, function ()
            local rad = math.random(4, 8)
            local angle = i*((4*PI)/LIGHTNING_COUNT)
            local pos = Vector3(target.Transform:GetWorldPosition()) + Vector3(rad*math.cos(angle), 0, rad*math.sin(angle))
            TheWorld:PushEvent("ms_sendlightningstrike", pos)
        end)
    end

    inst.cooling_down = true
    inst:DoTaskInTime(COOLDOWN, function () inst.cooling_down = false end)
end

local function spawnfx(inst)
    if not inst.fx then
        inst.fx = SpawnPrefab("thunderbird_fx")
        local x,y,z = inst.Transform:GetWorldPosition()
        inst.fx.Transform:SetPosition(x, y, z)

        local follower = inst.fx.entity:AddFollower()
        follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
        inst.fx:FacePoint(inst.Transform:GetWorldPosition())
   end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
    inst.entity:AddLight()

	inst.DynamicShadow:SetSize( 1.5, .75 )
    inst.Transform:SetFourFaced()

    MakeCharacterPhysics(inst, 50, .5)

    inst.AnimState:SetBank("thunderbird")
    inst.AnimState:SetBuild("thunderbird")
    inst.AnimState:Hide("hat")

    inst:AddTag("character")
    inst:AddTag("berrythief")

    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.75)
    inst.Light:SetRadius(2.5)
    inst.Light:SetColour(120/255, 120/255, 120/255)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetWakeTest( function() return true end)    --always wake up if we're asleep

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "pig_torso"

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.PERD_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.PERD_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.PERD_ATTACK_PERIOD)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)

    inst:AddComponent("inventory")
    inst:AddComponent("inspectable")

    inst:AddComponent("locomotor")
    inst.components.locomotor.runspeed = THUNDERBIRD_RUN_SPEED
    inst.components.locomotor.walkspeed = THUNDERBIRD_WALK_SPEED

    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")

    inst:SetStateGraph("SGthunderbird")
    local brain = require "brains/thunderbirdbrain"
    inst:SetBrain(brain)

    inst.special_action = function (act)
        inst.sg:GoToState("thunder_attack")
    end

    inst:DoTaskInTime(0.1, function() spawnfx(inst) end)

    inst.DoLightning = DoLightning
    MakeMediumFreezableCharacter(inst, "pig_torso")
    MakeMediumBurnableCharacter(inst, "pig_torso")

    inst.components.burnable.lightningimmune = true

    return inst
end

local function fx_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("NOCLICK")
    inst.AnimState:SetBank("thunderbird_fx")
    inst.AnimState:SetBuild("thunderbird_fx")

    return inst
end

return Prefab("thunderbird", fn, assets, prefabs),
       Prefab("thunderbird_fx", fx_fn, assets, prefabs)
