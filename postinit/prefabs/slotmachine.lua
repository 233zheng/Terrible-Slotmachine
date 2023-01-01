local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

local hauntprizevalues =
{
	bad = 5,
	ok = 4,
	good = 1,
}

local prizevalues =
{
	bad = 4,
	ok = 5,
	good = 1,
}

local goldprizevalues =
{
	bad = 1,
	ok = 2,
	good = 3,
}

local function SpawnCritter(inst, player, critter, lootdropper, pt, delay)
	delay = delay or GetRandomWithVariance(1,0.8)
	inst:DoTaskInTime(delay, function()
        local fx = SpawnPrefab("collapse_small")
		fx.Transform:SetPosition(pt:Get())
		local spawn = lootdropper:SpawnLootPrefab(critter, pt)
		if spawn then
			if inst and spawn.components.visualvariant then
				spawn.components.visualvariant:CopyOf(inst, true)
			end
			if spawn.components.combat then
				spawn.components.combat:SetTarget(player)
			end
		end
	end)
end

local _SpawnReward
local function SpawnReward(inst, player, reward, lootdropper, pt, delay, ...)
	delay = delay or GetRandomWithVariance(1,0.8)

	local loots = GetTreasureLootList(reward)
	for k, v in pairs(loots) do
		for i = 1, v, 1 do

			inst:DoTaskInTime(delay, function(inst)
				local down = TheCamera:GetDownVec()
				local spawnangle = math.atan2(down.z, down.x)
				local angle = math.atan2(down.z, down.x) + (math.random()*90-45)*DEGREES
				local sp = math.random()*3+2
				--ripped right from our Octopus implementation
				local angle
				local spawnangle
				local sp = math.random()*3+2
				local x, y, z = inst.Transform:GetWorldPosition()

				if player ~= nil and player:IsValid() then
					angle = (225 - math.random()*90 - player:GetAngleToPoint(x, 0, z))*DEGREES
					spawnangle = player:GetAngleToPoint(x, 0, z)*DEGREES
				else
					local down = TheCamera:GetDownVec()
					angle = math.atan2(down.z, down.x) + (math.random()*90-45)*DEGREES
					spawnangle = math.atan2(down.z, down.x)
					player = nil
				end

				local item = SpawnPrefab(k)

				if  item and item:IsValid() then
					if inst and item.components.visualvariant then
						item.components.visualvariant:CopyOf(inst, true)
					end
					if item.components.inventoryitem and not item.components.health then
						local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(1*math.cos(angle), 3, 1*math.sin(angle))
						inst.SoundEmitter:PlaySound("ia/common/slotmachine/reward")
						item.Transform:SetPosition(pt:Get())
						item.Physics:SetVel(sp*math.cos(angle), math.random()*2+9, sp*math.sin(angle))
						item.components.inventoryitem:SetLanded(false, true)
					else
						local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(2*math.cos(angle), 0, 2*math.sin(angle))
						pt = pt + Vector3(sp*math.cos(angle), 0, sp*math.sin(angle))
						item.Transform:SetPosition(pt:Get())
                        local fx = SpawnPrefab("collapse_small")
						fx.Transform:SetPosition(pt:Get())
					end
				end

			end)
			delay = delay + 0.25
		end
	end
    if _SpawnReward ~= nil then
        _SpawnReward(inst, player, reward, lootdropper, pt, delay, ...)
    end
end

local function PickPrize(inst)

	local prizevalue = weighted_random_choice(prizevalues)
	print("slotmachine prizevalue", prizevalue)
	if prizevalue == "ok" then
		inst.prize = weighted_random_choice(SLOTMACHINE_LOOT.TSokspawns)
	elseif prizevalue == "good" then
		inst.prize = weighted_random_choice(SLOTMACHINE_LOOT.TSgoodspawns)
	elseif prizevalue == "bad" then
		inst.prize = weighted_random_choice(SLOTMACHINE_LOOT.TSbadspawns)
	else
		-- impossible!
		print("impossible slot machine prizevalue!", prizevalue)
	end

	inst.prizevalue = prizevalue
end

local function PickHauntPrize(inst)

	local prizevalue = weighted_random_choice(hauntprizevalues)
	print("slotmachine prizevalue", prizevalue)
	if prizevalue == "ok" then
		inst.prize = weighted_random_choice(SLOTMACHINE_LOOT.TSokspawns)
	elseif prizevalue == "good" then
		inst.prize = weighted_random_choice(SLOTMACHINE_LOOT.TSgoodspawns)
	elseif prizevalue == "bad" then
		inst.prize = weighted_random_choice(SLOTMACHINE_LOOT.TSbadspawns)
	else
		-- impossible!
		print("impossible slot machine prizevalue!", prizevalue)
	end

	inst.prizevalue = prizevalue
end

local function PickGoldPrize(inst)

	local prizevalue = weighted_random_choice(goldprizevalues)
	print("slotmachine prizevalue", prizevalue)
	if prizevalue == "ok" then
		inst.prize = weighted_random_choice(SLOTMACHINE_LOOT.TSokspawns)
	elseif prizevalue == "good" then
		inst.prize = weighted_random_choice(SLOTMACHINE_LOOT.TSgoodspawns)
	elseif prizevalue == "bad" then
		inst.prize = weighted_random_choice(SLOTMACHINE_LOOT.TSbadspawns)
	else
		-- impossible!
		print("impossible slot machine prizevalue!", prizevalue)
	end

	inst.prizevalue = prizevalue
end

local function StartSpinning(inst)
	inst.sg:GoToState("spinning") --"busy" statetag blocks trader component
end

local _DoneSpinning
local function DoneSpinning(inst, ...)

	local pos = inst:GetPosition()
	local item = inst.prize
	local doaction = SLOTMACHINE_LOOT.actions[item]
	local player = FindClosestPlayerToInst(inst, 20, true)

	local cnt = (doaction and doaction.cnt) or 1
	local func = (doaction and doaction.callback) or nil
	local radius = (doaction and doaction.radius) or 4
	local treasure = (doaction and doaction.treasure) or nil

	if doaction and doaction.var then
		cnt = GetRandomWithVariance(cnt,doaction.var)
		if cnt < 0 then cnt = 0 end
	end

	if cnt == 0 and func then
		func(inst,item,doaction)
	end
    local chance = 1
    if inst.chance then
        chance = inst.chance
    end
    for i=1,chance do
        for i=1,cnt do
            local offset, check_angle, deflected = FindWalkableOffset(pos, math.random()*2*PI, radius , 8, true, false) -- try to avoid walls
            if offset then
                if treasure then
                    SpawnReward(inst, player, treasure)
                elseif func then
                    func(inst,item,doaction)
                elseif item == "trinket" then
				if math.random() < .5 then
					SpawnCritter(inst, player, "trinket_ia_"..tostring(math.random(13,23)), inst.components.lootdropper, pos+offset)
				else
					SpawnCritter(inst, player, "trinket_"..tostring(math.random(NUM_TRINKETS)), inst.components.lootdropper, pos+offset)
				end
                elseif item == "nothing" then
                else
				SpawnCritter(inst, player, item, inst.components.lootdropper, pos+offset)
			end
		end
	end
end

	inst.coins = inst.coins + 1
	inst.prize = nil
	inst.prizevalue = nil
    if _DoneSpinning ~= nil then
        _DoneSpinning(inst, ...)
    end
end

local _ShouldAcceptItem
local function ShouldAcceptItem(inst, item, ...)

	if not inst.sg.HasStateTag("busy") and (item.prefab == "dubloon" or item.prefab == "goldnugget") then
		return true
	else
		return false
	end
    if _ShouldAcceptItem ~= nil then
        _ShouldAcceptItem(inst, item, ...)
    end
end

local _OnGetItemFromPlayer
local function OnGetItemFromPlayer(inst, giver, item, ...)
	giver.components.hunger:DoDelta(-3)
	giver.components.sanity:DoDelta(TUNING.SANITY_TINY)

    if item.prefab == "dubloon" then
	    PickPrize(inst)
        StartSpinning(inst)
        inst.chance = 1
    elseif item.prefab == "goldnugget" then
        PickGoldPrize(inst)
        StartSpinning(inst)
        inst.chance = 3
    end
    if _OnGetItemFromPlayer ~= nil then
        _OnGetItemFromPlayer(inst, giver, item, ...)
    end
end

local function onhauntmachine(inst, haunter)
    if not inst.sg.HasStateTag("busy") then
        PickHauntPrize(inst)
        StartSpinning(inst)
		inst.chance = 1
        return true
    end
    return false
end

local function OnRefuseItem(inst, item)
	print("Slot machine refuses "..tostring(item.prefab))
end

local _OnLoad
local function OnLoad(inst,data, ...)
	if not data then
		return
	end

	inst.coins = data.coins or 0
	inst.prize = data.prize
	inst.prizevalue = data.prizevalue
    inst.level = data.level
	if inst.prize ~= nil then
		StartSpinning(inst)
	end
    if _OnLoad ~= nil then
        _OnLoad(inst,data, ...)
    end
end

local _OnSave
local function OnSave(inst,data, ...)
	data.coins = inst.coins
	data.prize = inst.prize
	data.prizevalue = inst.prizevalue
    data.level = inst.level
    if _OnSave ~= nil then
        _OnSave(inst,data, ...)
    end
end

local function postinit(inst)

    inst:AddTag("slotmachine")

    if not TheWorld.ismastersim then return end

    inst.level = 0
	inst.DoneSpinning = DoneSpinning

    if inst.components.hauntable then
        inst.components.hauntable:SetOnHauntFn(onhauntmachine)
    end

    if inst.components.trader then
        inst.components.trader:SetAcceptTest(ShouldAcceptItem)
        inst.components.trader.onaccept = OnGetItemFromPlayer
        inst.components.trader.onrefuse = OnRefuseItem
    end

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

end

AddPrefabPostInit("slotmachine", postinit)
