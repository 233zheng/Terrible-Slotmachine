--别看了，这个我选择摆烂:P
require "brains/citypigbrain"
require "brains/pigguardbrain"
require "brains/werepigbrain"
require "stategraphs/SGwerepig"
require "stategraphs/SGpig_city"

local total_day_time = 480
local seg_time = 30
local PIG_DAMAGE = 33
local PIG_HEALTH = 400
local PIG_ATTACK_PERIOD = 3
local PIG_TARGET_DIST = 16
local PIG_LOYALTY_MAXTIME = 2.5*total_day_time
local PIG_LOYALTY_PER_HUNGER = total_day_time/25
local PIG_MIN_POOP_PERIOD = seg_time * .5
local PIG_RUN_SPEED = 5
local PIG_WALK_SPEED = 3
local CITY_PIG_GUARD_TARGET_DIST = 20
local SPRING_COMBAT_MOD = 1.33

local assets =
{
	Asset("SOUND", "sound/pig.fsb"),


    Asset("ANIM", "anim/townspig_attacks.zip"),
    Asset("ANIM", "anim/townspig_actions.zip"),
    Asset("ANIM", "anim/townspig_basic.zip"),


    Asset("ANIM", "anim/pig_royalguard.zip"),
    Asset("ANIM", "anim/pig_royalguard_2.zip"),
    Asset("ANIM", "anim/pig_royalguard_3.zip"),
    Asset("ANIM", "anim/pig_royalguard_rich.zip"),
    Asset("ANIM", "anim/pig_royalguard_rich_2.zip"),
}

local prefabs =
{
    "meat",
    "poop",
    "tophat",
    "pigskin",
    "halberd",
    "strawhat",
    "monstermeat",
--    "pigcrownhat",
--    "pig_scepter",
    -- "pigman_shopkeeper_desk",
}

local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30

local function sayline(inst, line, mood)
    inst.components.talker:Say(line, 1.5, nil, true, mood)
end

local function ontalk(inst, script, mood)
    if mood and mood == "alarmed" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/city_pig/guard_alert")
    else
        inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/city_pig/scream")
    end
end

local function ontalkfinish(inst)
    inst.SoundEmitter:KillSound("talk")
end

local function CalcSanityAura(inst, observer)
	if inst.components.werebeast
       and inst.components.werebeast:IsInWereState() then
		return -TUNING.SANITYAURA_LARGE
	end

	if inst.components.follower and inst.components.follower.leader == observer then
		return TUNING.SANITYAURA_SMALL
	end

	return 0
end

local function ShouldAcceptItem(inst, item)
	return item:HasTag("securitycontract")
end

local function OnGetItemFromPlayer(inst, giver, item)
	if giver.components.leader ~= nil then
		giver:PushEvent("makefriend")
		giver.components.leader:AddFollower(inst)
		inst.components.follower:AddLoyaltyTime(150 * TUNING.PIG_LOYALTY_PER_HUNGER)
		inst.components.follower.maxfollowtime =
			giver:HasTag("polite") and TUNING.PIG_LOYALTY_MAXTIME + TUNING.PIG_LOYALTY_POLITENESS_MAXTIME_BONUS or
			TUNING.PIG_LOYALTY_MAXTIME
	end
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper and inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function OnAttacked(inst, data)
    local attacker = data.attacker
    inst:ClearBufferedAction()
    if not attacker then
        return
    end

    if inst:HasTag("guard") then
        if attacker:HasTag("player") then
            inst:AddTag("angry_at_player")
        end
        inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude)
            return dude:HasTag("pig") and (dude:HasTag("guard") or not attacker:HasTag("pig"))
        end, MAX_TARGET_SHARES)
    else
        if not (attacker:HasTag("pig") and attacker:HasTag("guard") ) then
            inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude)
                return dude:HasTag("pig")
            end, MAX_TARGET_SHARES)
        end
    end
end

local function NormalRetargetFn(inst)
	local exclude_tags = {"playerghost", "INLIMBO"}
	if inst.components.follower.leader ~= nil then
		table.insert(exclude_tags, "abigail")
	end
	if inst.components.minigame_spectator ~= nil then
		table.insert(exclude_tags, "player") -- prevent spectators from auto-targeting webber
	end

	return not inst:IsInLimbo() and
		FindEntity(
			inst,
			TUNING.PIG_TARGET_DIST,
			function(guy)
				return (guy.LightWatcher == nil or guy.LightWatcher:IsInLight()) and inst.components.combat:CanTarget(guy)
			end,
			{"monster", "_combat", "epic"}, -- see entityreplica.lua
			exclude_tags
		) or
		nil
end

local function NormalKeepTargetFn(inst, target)
    --give up on dead guys, or guys in the dark, or werepigs
    return inst.components.combat:CanTarget(target)
           and (not target.LightWatcher or target.LightWatcher:IsInLight())
           and not (target.sg and target.sg:HasStateTag("transform") )
end

local function NormalShouldSleep(inst)
    if inst.components.follower and inst.components.follower.leader then
        local fire = FindEntity(inst, 6, function(ent)
            return ent.components.burnable
                   and ent.components.burnable:IsBurning()
        end, {"campfire"})
        return DefaultSleepTest(inst) and fire and (not inst.LightWatcher or inst.LightWatcher:IsInLight())
    else
        return DefaultSleepTest(inst)
    end
end

local function SetNormalPig(inst, brain_id)
    inst:RemoveTag("werepig")
    inst:RemoveTag("guard")
--	inst.AnimState:SetBuild(inst.build)

	--inst.components.werebeast:SetOnNormalFn(SetNormalPig)
    inst.components.sleeper:SetResistance(2)

    inst.components.combat:SetDefaultDamage(PIG_DAMAGE)
    inst.components.combat:SetAttackPeriod(PIG_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(NormalKeepTargetFn)
    inst.components.locomotor.runspeed = PIG_RUN_SPEED
    inst.components.locomotor.walkspeed = PIG_WALK_SPEED

    inst.components.sleeper:SetSleepTest(NormalShouldSleep)
    inst.components.sleeper:SetWakeTest(DefaultWakeTest)

    inst.components.lootdropper:AddRandomLoot("meat",3)
    inst.components.lootdropper:AddRandomLoot("pigskin",1)
    inst.components.lootdropper.numrandomloot = 1

	inst.components.health:SetMaxHealth(TUNING.PIG_HEALTH)
	inst.components.combat:SetRetargetFunction(3, NormalRetargetFn)
	inst.components.combat:SetTarget(nil)
	inst:ListenForEvent(
		"suggest_tree_target",
		function(inst, data)
			if data and data.tree and inst:GetBufferedAction() ~= ACTIONS.CHOP then
				inst.tree_target = data.tree
			end
		end)

	inst.components.trader:Enable()
	inst.components.talker:StopIgnoringAll()

    local brain = require "brains/citypigbrain"
    inst:SetBrain(brain)

    inst:SetStateGraph("SGpig_city")

end

local function throwcrackers(inst)
    local cracker = SpawnPrefab("firecrackers")
    inst.components.inventory:GiveItem( cracker )
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local start_angle = inst.Transform:GetRotation()
    local radius = 5
    local attempts = 12

    local test_fn = function(offset)
        local ents = TheSim:FindEntities(pos.x+offset.x,pos.y+offset.y,pos.z+offset.z, 2, nil,{"INLIMBO"})

        if #ents == 0 then
            return true
        end
    end
    local pt, new_angle = FindValidPositionByFan(start_angle, radius, attempts, test_fn)

    if new_angle then
        inst.Transform:SetRotation(new_angle / DEGREES)
    end

    local rot = inst.Transform:GetRotation() * DEGREES

    local tossdir = Vector3(0,0,0)
    tossdir.x = math.cos(rot)
    tossdir.z = -math.sin(rot)

    inst.components.inventory:DropItem(cracker, nil,nil,nil,nil,tossdir)
    cracker.components.fuse:StartFuse()
	cracker.components.burnable:Ignite()
end


local function GetStatus(inst)
    if inst:HasTag("guard") then
        return "GUARD"
    end
end

local function special_action(inst)
    if inst.daily_gifting then
        inst.sg:GoToState("daily_gift")
    elseif inst.poop_tip then
        inst.sg:GoToState("poop_tip")
    elseif inst:HasTag("paytax") then
        inst.sg:GoToState("pay_tax")
    end
end

local function OnSave(inst, data)
    data.build = inst.build

    if inst.daily_gift then
        data.daily_gift = inst.daily_gift
    end

    if inst.torch then
        table.insert(data.children, inst.torch.GUID)
        data.torch = inst.torch.GUID
    end
    if inst.axe then
        table.insert(data.children, inst.axe.GUID)
        data.axe = inst.axe.GUID
    end

    if inst:HasTag("guards_called") then
        data.guards_called = true
    end
    if inst.task_guard1 or inst.task_guard2 then
        data.doSpawnGuardTask = true
    end


    if inst.equipped then
        data.equipped = true
    end
end

local function OnLoad(inst, data)
    if data ~= nil then

        if data.guards_called then
            inst:AddTag("guards_called")
        end

        if data.equipped then
            inst.equipped = true
            inst.equiptask:Cancel()
            inst.equiptask = nil
        end

        if data.daily_gift then
        inst.daily_gift = data.daily_gift
        end
    end
end

local function OnLoadPostPass(inst, ents, data)
    if data ~= nil then
        if data.children then
            for k,v in pairs(data.children) do
                local item = ents[v]
                if item then
                    if data.desk and data.desk == v then
                        inst.desk = item.entity
                        inst:AddComponent("homeseeker")
                        inst.components.homeseeker:SetHome(inst.desk)
                    end
                end
            end
        end
    end
end

local function startday(inst)
    local axe = inst.components.inventory:FindItem(function(item)
        if item.prefab == "halberd" then
            return true
        end
    end)

    if not axe then
        axe = SpawnPrefab("halberd")
    end

    if axe then
        inst.components.inventory:Equip(axe)
    end
end

local function isnight(inst)
    local function getspeech()
        return STRINGS.CITY_PIG_GUARD_LIGHT_TORCH.DEFAULT[math.random(#STRINGS.CITY_PIG_GUARD_LIGHT_TORCH.DEFAULT)]
    end
    inst.sayline(inst, getspeech())
end

local function equipped(inst)
    local axe = SpawnPrefab("halberd")
    if axe then
        inst.components.inventory:GiveItem(axe)
        inst.components.inventory:Equip(axe)
    end

    local armour = SpawnPrefab("armorwood")
    if armour then
        inst.components.inventory:GiveItem(armour)
        inst.components.inventory:Equip(armour)
    end
end

local function makefn(name, build, tags)
    local function make_common()

    	local inst = CreateEntity()
    	inst.entity:AddTransform()
    	inst.entity:AddAnimState()
    	inst.entity:AddSoundEmitter()
    	inst.entity:AddDynamicShadow()
		inst.entity:AddNetwork()
        inst.entity:AddLightWatcher()

    	inst.DynamicShadow:SetSize( 1.5, .75 )

        inst.Transform:SetFourFaced()

        MakeCharacterPhysics(inst, 50, .5)

        inst:AddTag("character")
        inst:AddTag("pig")
        inst:AddTag("civilized")
        inst:AddTag("scarytoprey")
        inst:AddTag("city_pig")

        if tags then
            for i,tag in ipairs(tags)do
                inst:AddTag(tag)
            end
        end

        inst.AnimState:SetBank("townspig")
        inst.AnimState:SetBuild(build)

        inst.AnimState:PlayAnimation("idle_loop",true)
        inst.AnimState:Hide("hat")
        inst.AnimState:Hide("desk")
        inst.AnimState:Hide("ARM_carry")
		inst.daily_gift = 0

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

        inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
        inst.components.locomotor.runspeed = PIG_RUN_SPEED --5
        inst.components.locomotor.walkspeed = PIG_WALK_SPEED --3

        inst:AddComponent("talker")
        inst.components.talker.ontalk = ontalk
		inst.components.talker.donetalkingfn = ontalkfinish
        inst.components.talker.fontsize = 35
        inst.components.talker.font = TALKINGFONT
        inst.components.talker.offset = Vector3(0,-600,0)
        inst.talkertype = name

        inst:AddComponent("combat")
        inst.components.combat.hiteffectsymbol = "pig_torso"

        inst:AddComponent("named")
        local names = {}
        for i, name in ipairs(STRINGS.CITYPIGNAMES["UNISEX"]) do
            table.insert(names, name)
        end
        inst.components.named.possiblenames = names
        inst.components.named:PickNewName()

        inst:AddComponent("follower")
        inst.components.follower.maxfollowtime = PIG_LOYALTY_MAXTIME

        inst:AddComponent("health")
        inst:AddComponent("sleeper")

        inst:AddComponent("inventory")

        inst:AddComponent("lootdropper")
        inst:AddComponent("knownlocations")

        inst:AddComponent("trader")
        inst.components.trader:SetAcceptTest(ShouldAcceptItem)
        inst.components.trader.onaccept = OnGetItemFromPlayer
        inst.components.trader.onrefuse = OnRefuseItem

        inst:AddComponent("sanityaura")
        inst.components.sanityaura.aurafn = CalcSanityAura

        inst:AddComponent("inspectable")
        inst.components.inspectable.getstatus = GetStatus

        MakeMediumBurnableCharacter(inst, "pig_torso")
        MakeMediumFreezableCharacter(inst, "pig_torso")

        inst.special_action = special_action
        inst.sayline = sayline
        inst.OnSave = OnSave
        inst.OnLoad = OnLoad
        inst.OnLoadPostPass = OnLoadPostPass
        inst.throwcrackers = throwcrackers

        inst:ListenForEvent("attacked", OnAttacked)

		SetNormalPig(inst)

        return inst
    end

local function make_pig_guard()
    local inst = make_common()

    inst:AddTag("emote_nocurtsy")
    inst:AddTag("guard")
    inst:AddTag("extinguisher")
    inst:AddTag("pocketwatchcaster")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.lootdropper:AddRandomLoot("meat",3)
    inst.components.lootdropper:AddRandomLoot("pigskin",1)
    inst.components.lootdropper.numrandomloot = 1

    inst:RemoveComponent("sleeper")
    inst.components.burnable:SetBurnTime(2)

    inst.equiptask = inst:DoTaskInTime(0,equipped)

    inst:WatchWorldState("startday", startday)
    inst:WatchWorldState("isnight", isnight)

    return inst
end

    return make_pig_guard
end

local function makepigman(name, build, tags)
    return Prefab(name, makefn(name, build, tags), assets, prefabs )
end

return  makepigman("pigman_royalguard", "pig_royalguard"),
        makepigman("pigman_royalguard_2", "pig_royalguard_2"),

        makepigman("pig_royalguard_rich", "pig_royalguard_rich"),
        makepigman("pig_royalguard_rich_2", "pig_royalguard_rich_2"),
        makepigman("pigman_royalguard_3", "pig_royalguard_3")
