local assets =
{
	Asset("ANIM", "anim/ia_meteor.zip"),
	Asset("ANIM", "anim/ia_meteor_shadow.zip")
}

local prefabs =
{
	"lavapool",
    "groundpound_fx",
    "groundpoundring_fx",
    "bombsplash",
    "lava_bombsplash",
    "clouds_bombsplash",
    "TS_firerainshadow",
    "meteor_impact"
}

local function DoStep(inst)
	local map = TheWorld.Map
	local x, y, z = inst.Transform:GetLocalPosition()
	local tile = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

	if tile == WORLD_TILES.VOLCANO_LAVA then
		local fx = SpawnPrefab("lava_bombsplash")
		fx.Transform:SetPosition(x, y, z)
	elseif tile == WORLD_TILES.IMPASSABLE then
		local fx = SpawnPrefab("clouds_bombsplash")
		fx.Transform:SetPosition(x, y, z)
	elseif IsWater(tile) or IsOceanTile(tile) then
		local fx = SpawnPrefab("bombsplash")
		fx.Transform:SetPosition(x, y, z)
		SpawnWaves(inst, 8, 360, 6)
		inst.SoundEmitter:PlaySound("ia/common/volcano/rock_splash")
		inst.components.groundpounder.burner = false
		inst.components.groundpounder.groundpoundfx = nil
		inst.components.groundpounder:GroundPound()
	else
		if inst:IsPosSurroundedByLand(x, y, z, 2) then
			-- if math.random() < TUNING.VOLCANO_FIRERAIN_LAVA_CHANCE then
			-- 	local lavapool = SpawnPrefab("lavapool")
			-- 	lavapool.Transform:SetPosition(x, y, z)
			-- else
				local impact = SpawnPrefab("meteor_impact")
				impact.components.timer:StartTimer("remove", TUNING.TOTAL_DAY_TIME * 2)
				impact.Transform:SetPosition(x, y, z)
			-- end
		end
		inst.SoundEmitter:PlaySound("ia/common/volcano/rock_smash")
		inst.components.groundpounder.numRings = 4
		inst.components.groundpounder.burner = true
		inst.components.groundpounder:GroundPound()
	end

	for num, player in pairs(AllPlayers) do
		local distToPlayer = inst:GetPosition():Dist(player:GetPosition())
		local power = Lerp(3, 1, distToPlayer/180)
		player:ShakeCamera(CAMERASHAKE.VERTICAL, 0.5, 0.03, power, 40)
	end
end

local function StartStep(inst)
	local shadow = SpawnPrefab("ts_firerainshadow")
	shadow.Transform:SetPosition( inst.Transform:GetWorldPosition() )
	shadow.Transform:SetRotation( math.random(0, 360) )--(GetRotation(inst))
	inst.SoundEmitter:PlaySound("ia/common/bomb_fall")
	inst:DoTaskInTime(TUNING.VOLCANO_FIRERAIN_WARNING - 5 * FRAMES, function(inst) inst:DoStep() end)
	inst:DoTaskInTime(TUNING.VOLCANO_FIRERAIN_WARNING - 14 * FRAMES, function(inst)
		inst:Show()
		inst.AnimState:PlayAnimation("idle")
		inst:ListenForEvent("animover", function(inst) inst:Remove() end)
	end)
end

local function GroundPound(self, pt)
	pt = pt or self.inst:GetPosition()
	local ground = TheWorld.Map:GetTileAtPoint(pt.x, 0, pt.z)

	if self.groundpoundringfx and not IsWater(ground) then
		local ring = SpawnPrefab(self.groundpoundringfx)
		ring.Transform:SetScale(self.ring_fx_scale, self.ring_fx_scale, self.ring_fx_scale)
		ring.Transform:SetPosition(pt:Get())
	end
	local points = self:GetPoints(pt)
	local delay = 0
	self.ignoreEnts = nil
	for i = 1, self.numRings do
		self.inst:DoTaskInTime(delay, function()
			self:DestroyPoints(points[i], i <= self.destructionRings, i <= self.damageRings)
			if i == self.numRings and self.groundpoundFn then
				self.groundpoundFn(self.inst)
			end
		end)

		delay = delay + self.ringDelay
	end
end

local function DestroyPoints(self, points, breakobjects, dodamage)
	local getEnts = breakobjects or dodamage

	for k,v in pairs(points) do
		local ents = nil
		if getEnts then
			ents = TheSim:FindEntities(v.x, v.y, v.z, 3, nil, self.noTags)
		end
		if ents and breakobjects then
		    -- first check to see if there's crops here, we want to work their farm
		    for k2,v2 in pairs(ents) do
		        -- if v2 and self.burner and v2.components.burnable and not v2:HasTag("fire") and not v2:HasTag("burnt") then
		        -- 	v2.components.burnable:Ignite()
		        -- end
		    	-- Don't net any insects when we do work
		        if v2 and self.destroyer and v2.components.workable and v2.components.workable.workleft > 0 and v2.components.workable.action ~= ACTIONS.NET then
	        	    v2.components.workable:Destroy(self.inst)
			end
		        if v2 and self.destroyer and v2.components.crop then
			    	print("Has Crop:",v2)
	        	    v2.components.crop:ForceHarvest()
				end
		    end
		end
		if ents and dodamage then
		    for k2,v2 in pairs(ents) do
		    	if not self.ignoreEnts then
		    		self.ignoreEnts = {}
		    	end
		    	if not self.ignoreEnts[v2.GUID] then --If this entity hasn't already been hurt by this groundpound

			        if v2 and v2.components.health and not v2.components.health:IsDead() and
			        self.inst.components.combat:CanTarget(v2) then
			            self.inst.components.combat:DoAttack(v2, nil, nil, nil, self.groundpounddamagemult)
			        end
			        self.ignoreEnts[v2.GUID] = true --Keep track of which entities have been hit
			    end
		    end
		end

		local map = TheWorld.Map
		if map then
			local ground = map:GetTileAtPoint(v.x, 0, v.z)

			if ground == WORLD_TILES.IMPASSABLE or IsWater(ground) then
				--Maybe do some water fx here?
			else
				if self.groundpoundfx then
					SpawnPrefab(self.groundpoundfx).Transform:SetPosition(v.x, 0, v.z)
				end
			end
		end
	end
end

local function firerainfn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	trans:SetFourFaced()
	anim:SetBank("meteor")
	anim:SetBuild("ia_meteor")

	inst:AddTag("FX")

	if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("groundpounder")
	inst.components.groundpounder.numRings = 4
	inst.components.groundpounder.ringDelay = 0.1
	inst.components.groundpounder.initialRadius = 1
	inst.components.groundpounder.radiusStepDistance = 2
	inst.components.groundpounder.pointDensity = .25
	inst.components.groundpounder.damageRings = 2
	inst.components.groundpounder.destructionRings = 3
	inst.components.groundpounder.destroyer = true
	inst.components.groundpounder.burner = true
	inst.components.groundpounder.ring_fx_scale = 0.75
	inst.components.groundpounder.GroundPound = GroundPound
	inst.components.groundpounder.DestroyPoints = DestroyPoints

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(TUNING.TS_VOLCANO_FIRERAIN_DAMAGE)

	inst.DoStep = DoStep
	inst.StartStep = StartStep

	inst:Hide()

	return inst
end

local easing = require("easing")
local function LerpIn(inst)
	local s = easing.inExpo(inst:GetTimeAlive(), 1, 1 - inst.StartingScale, inst.TimeToImpact)

	inst.Transform:SetScale(s,s,s)
	if s >= inst.StartingScale then
		inst.sizeTask:Cancel()
		inst.sizeTask = nil
	end
end

local function OnRemove(inst)
	if inst.sizeTask then
		inst.sizeTask:Cancel()
		inst.sizeTask = nil
	end
end

local function Impact(inst)
	inst:Remove()
end

local function shadowfn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

	anim:SetBank("meteor_shadow")
	anim:SetBuild("ia_meteor_shadow")
	anim:PlayAnimation("idle")
	anim:SetOrientation(ANIM_ORIENTATION.OnGround)
	anim:SetLayer(LAYER_BACKGROUND)
	anim:SetSortOrder(3)
	inst.entity:AddNetwork()

	inst:AddTag("FX")

	if not TheWorld.ismastersim then
        return inst
    end

	inst.persists = false

	local s = 2
	inst.StartingScale = s
	inst.Transform:SetScale(s,s,s)
	inst.TimeToImpact = TUNING.VOLCANO_FIRERAIN_WARNING

	inst:AddComponent("colourtweener")
	inst.AnimState:SetMultColour(0,0,0,0)
	inst.components.colourtweener:StartTween({0,0,0,1}, inst.TimeToImpact, Impact)

	inst.OnRemoveEntity = OnRemove

	inst.sizeTask = inst:DoPeriodicTask(FRAMES, LerpIn)

	return inst
end

return Prefab("ts_firerain", firerainfn, assets, prefabs),
		Prefab("ts_firerainshadow", shadowfn, assets, prefabs)
