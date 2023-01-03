local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

-- {"eyemaskhat",                      1.00},
-- {"milkywhites",                     1.00},
-- {"milkywhites",                     1.00},
-- {"milkywhites",                     1.00},
-- {"milkywhites",                     0.50},
-- {"milkywhites",                     0.50},
-- {"monstermeat",                     1.00},
-- {"monstermeat",                     1.00},
-- {"monstermeat",                     0.50},
-- {"monstermeat",                     0.50},

local eyeofterrorloot  = {
    "eyemaskhat",
    "milkywhites",
    "milkywhites",
    "milkywhites",
    "monstermeat",
    "monstermeat",
    "armor_bramble",
    "wathgrithrhat"
}

local twinofterror1loot = {
    "gears",
    "gears",
    "gears",
    "gears",
    "transistor",
    "transistor",
    "transistor",
    "nightmarefuel",
    "nightmarefuel",
    "nightmarefuel",
    "trinket_6",
    "trinket_6",
    "armor_bramble",
    "wathgrithrhat",
    "wathgrithrhat"
}

local twinofterror2loot = {
    "gears",
    "gears",
    "gears",
    "gears",
    "transistor",
    "transistor",
    "transistor",
    "nightmarefuel",
    "nightmarefuel",
    "nightmarefuel",
    "trinket_6",
    "trinket_6",
    "armor_bramble",
    "wathgrithrhat",
    "wathgrithrhat"
}

local RETARGET_MUST_TAGS = { "_combat" }
local RETARGET_CANT_TAGS = { "decor", "eyeofterror", "FX", "INLIMBO", "NOCLICK", "notarget", "playerghost", "wall" }
local RETARGET_ONEOF_TAGS = { "epic", "player" }    -- The eye tries to fight players and also other Epic monsters
-- local function update_targets(inst)
--     local to_remove = {}
--     local pos = inst.components.knownlocations:GetLocation("spawnpoint") or inst:GetPosition()

--     for k, _ in pairs(inst.components.grouptargeter:GetTargets()) do
--         to_remove[k] = true
--     end

--     local ents_near_spawnpoint = TheSim:FindEntities(
--         pos.x, 0, pos.z,
--         TUNING.EYEOFTERROR_DEAGGRO_DIST + 20,
--         RETARGET_MUST_TAGS, RETARGET_CANT_TAGS, RETARGET_ONEOF_TAGS
--     )
--     for _, v in ipairs(ents_near_spawnpoint) do
--         if to_remove[v] then
--             to_remove[v] = nil
--         else
--             inst.components.grouptargeter:AddTarget(v)
--         end
--     end

--     for non_target, _ in pairs(to_remove) do
--         inst.components.grouptargeter:RemoveTarget(non_target)
--     end
-- end

-- local TARGET_DIST = 36
-- local function get_target_test_range(use_short_dist, target)
--     return (use_short_dist and 8 + target:GetPhysicsRadius(0)) or TARGET_DIST
-- end

local function NewRetargetFn(inst)
    local range = inst:GetPhysicsRadius(0) + 64
    return FindEntity(
            inst,
            64,
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

local TARGET_DIST = 36
local function OnAttacked(inst, data, ...)
    -- Target our attackers, unless it's one of our soldiers somehow.
    if data.attacker and not inst.components.commander:IsSoldier(data.attacker) then
        local current_target = inst.components.combat.target
        if current_target == nil or not current_target:IsNear(inst, TARGET_DIST) then
            inst.components.combat:SetTarget(data.attacker)
            inst.components.commander:ShareTargetToAllSoldiers(data.attacker)
        end
    end
end

local function on_other_collided(inst, other)
    if not other.components.health or other.components.health:IsDead() then
        return
    end

    -- Lazy initialize the recently charged list if it doesn't exist yet.
    -- If it does, check if there's an existing timestamp for this "other".
    local current_time = GetTime()
    local prev_value = nil
    if inst._recentlycharged == nil then
        inst._recentlycharged = {}
    else
        prev_value = inst._recentlycharged[other]
    end

    -- If we had a timestamp for this "other" and hit it too recently, don't hit it again.
    if prev_value ~= nil and prev_value - current_time < 3 then
        return
    end
    inst._recentlycharged[other] = current_time

    inst.components.combat:DoAttack(other)
end

local _OnCollide
local function OnCollide(inst, other, ...)
    if other ~= nil and other:IsValid() then
        on_other_collided(inst, other)
    end
    if _OnCollide ~= nil then
        _OnCollide(inst, other, ...)
    end
end

local function OnEnterLimbo(inst)
    return false
end

local _FlybackHealthUpdate
local function FlybackHealthUpdate(inst, ...)
    if inst._leftday ~= nil then
        local day_difference = math.min(TheWorld.state.cycles - inst._leftday, 1/TUNING.EYEOFTERROR_HEALTHPCT_PERDAY)
        if day_difference > 0 then
            inst.components.health:DoDelta(day_difference * TUNING.EYEOFTERROR_HEALTHPCT_PERDAY * inst.components.health.maxhealth)
        end

        if inst._transformonhealthupdate then
            if inst.components.health:GetPercent() > TUNING.EYEOFTERROR_TRANSFORMPERCENT then
                inst.AnimState:Hide("mouth")
                inst.AnimState:Hide("ball_mouth")
                inst.AnimState:Show("eye")
                inst.AnimState:Show("ball_eye")
                inst.sg.mem.transformed = false
            end
        end

        inst._leftday = nil
    end
    if _FlybackHealthUpdate ~= nil then
        _FlybackHealthUpdate(inst, ...)
    end
end

local _OnSave
local function OnSave(inst, data, ...)
    if inst.sg.mem.transformed then
        data.is_transformed = inst.sg.mem.transformed
    end

    if inst._leftday ~= nil then
        data.leftday = inst._leftday
    end

    data.loot_dropped = inst._loot_dropped
    if _OnSave ~= nil then
        _OnSave(inst, data, ...)
    end
end

local _OnLoad
local function OnLoad(inst, data, ...)
    if data ~= nil then
        inst._loot_dropped = data._loot_dropped

        if data.leftday then
            inst._leftday = data.leftday
        end

        if data.is_transformed then
            inst.AnimState:Show("mouth")
            inst.AnimState:Show("ball_mouth")

            inst.AnimState:Hide("eye")
            inst.AnimState:Hide("ball_eye")

            inst.sg.mem.transformed = true
        end
    end
    if _OnLoad ~= nil then
        _OnLoad(inst, data, ...)
    end
end

local _hookup_twin_listeners
local EXTRA_LOOT = {}
local function hookup_twin_listeners(inst, twin, ...)
    inst:ListenForEvent("onremove", function(t)
        local et = inst.components.entitytracker
        if et:GetEntity("twin1") == nil and et:GetEntity("twin2") == nil then
            inst:Remove()
        end
    end, twin)

    inst:ListenForEvent("death", function(t)
        local et = inst.components.entitytracker
        local t1 = et:GetEntity("twin1")
        local t2 = et:GetEntity("twin2")
        if (t1 == nil or t1.components.health:IsDead()) and (t2 == nil or t2.components.health:IsDead()) then
            -- This only really works because SetLoot doesn't clear lootdropper.chanceloottable
            t.components.lootdropper:SetLoot(EXTRA_LOOT)
            inst:PushEvent("death")
            local x, y, z = inst.Transform:GetWorldPosition()
            for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"eyeofterror"}, nil)) do
                if not v.components.health:IsDead() then
                    v.components.health:Kill()
                end
            end
            inst:Remove()
        end
    end, twin)

    inst:ListenForEvent("turnoff_terrarium", function(t)
        local et = inst.components.entitytracker
        local t1 = et:GetEntity("twin1")
        local t2 = et:GetEntity("twin2")
        if (t1 == nil or t1.components.health:IsDead())
                and (t2 == nil or t2.components.health:IsDead()) then
            inst:PushEvent("turnoff_terrarium")
            inst:Remove()
        end
    end, twin)

    inst:ListenForEvent("finished_leaving", function(t)
        if t ~= nil and not t:IsInLimbo() then
            t:RemoveFromScene()
        end

        local et = inst.components.entitytracker
        local t1 = et:GetEntity("twin1")
        local t2 = et:GetEntity("twin2")
        if (t1 == nil or t1:IsInLimbo()) and (t2 == nil or t2:IsInLimbo()) then
            inst:PushEvent("finished_leaving")
        end
    end, twin)

    inst:ListenForEvent("healthdelta", function(t, data)
        local et = inst.components.entitytracker
        local t1 = et:GetEntity("twin1")
        local t2 = et:GetEntity("twin2")

        local t1_health = (t1 == nil and 0) or t1.components.health.currenthealth
        local t2_health = (t2 == nil and 0) or t2.components.health.currenthealth
        if (t1_health + t2_health) < ((TUNING.TWIN1_HEALTH + TUNING.TWIN2_HEALTH) * TUNING.EYEOFTERROR_TRANSFORMPERCENT) then
            if t1 ~= nil then
                t1:PushEvent("health_transform")
            end

            if t2 ~= nil then
                t2:PushEvent("health_transform")
            end
        end
    end, twin)
    if _hookup_twin_listeners ~= nil then
        _hookup_twin_listeners(inst, twin, ...)
    end
end

local UP_VEC3 = Vector3(0, 1, 0)
local TWINS_SPAWN_OFFSET = 5
local function get_spawn_positions(inst, targeted_player)
    local manager_position = inst:GetPosition()
    local player_position = targeted_player:GetPosition()
    local manager_to_player = (player_position - manager_position):Normalize()

    local offset_unit = manager_to_player:Cross(UP_VEC3):Normalize()

    local offset1_angle = math.atan2(offset_unit.z, offset_unit.x)
    local twin1_offset = FindWalkableOffset(manager_position, offset1_angle, TWINS_SPAWN_OFFSET, nil, false, true, nil, true, true)
        or (offset_unit * TWINS_SPAWN_OFFSET)

    local offset2_angle = offset1_angle + PI
    local twin2_offset = FindWalkableOffset(manager_position, offset2_angle, TWINS_SPAWN_OFFSET, nil, false, true, nil, true, true)
        or (offset_unit * -1 * TWINS_SPAWN_OFFSET)

    return manager_position + twin1_offset, manager_position + twin2_offset
end

local function spawn_arriving_twins(inst, targeted_player)
    local twin1spawnpos, twin2spawnpos = get_spawn_positions(inst, targeted_player)

    local twin1 = SpawnPrefab("twinofterror1")
    inst.components.entitytracker:TrackEntity("twin1", twin1)
    twin1.Transform:SetPosition(twin1spawnpos:Get())
    twin1.sg:GoToState("arrive")
    hookup_twin_listeners(inst, twin1)

    local twin2 = SpawnPrefab("twinofterror2")
    inst.components.entitytracker:TrackEntity("twin2", twin2)
    twin2.Transform:SetPosition(twin2spawnpos:Get())
    twin2.sg:GoToState("arrive_delay")
    hookup_twin_listeners(inst, twin2)

    -- Reset the hardmode reset counter whenever the boss is spawned back in to fight.
    inst._hardmode_days_reset_counter = TUNING.TWINS_RESET_DAY_COUNT
end

local _twinsmanager_isdying
local function twinsmanager_isdying(inst, ...)
    local et = inst.components.entitytracker
    local t1 = et:GetEntity("twin1")
    local t2 = et:GetEntity("twin2")

    if t1 == nil and t2 == nil then
        return false
    elseif t1 == nil then
        return t2.components.health:IsDead()
    elseif t2 == nil then
        return t1.components.health:IsDead()
    else
        return false
    end
    if _twinsmanager_isdying ~= nil then
        _twinsmanager_isdying(inst, ...)
    end
end

local _OnTwinManagerLoadPostPass
local function OnTwinManagerLoadPostPass(inst, newents, data, ...)
    local manager_in_limbo = inst:IsInLimbo()

    local t1 = inst.components.entitytracker:GetEntity("twin1")
    if t1 then
        hookup_twin_listeners(inst, t1)
        if manager_in_limbo then
            t1:RemoveFromScene()
        end
    end

    local t2 = inst.components.entitytracker:GetEntity("twin2")
    if t2 then
        hookup_twin_listeners(inst, t2)
        if manager_in_limbo then
            t2:RemoveFromScene()
        end
    end
    if _OnTwinManagerLoadPostPass ~= nil then
        _OnTwinManagerLoadPostPass(inst, newents, data, ...)
    end
end

local function postinit(inst)

    if TheWorld.ismastersim then

    -- if inst.components.stuckdetection then
    --     inst:RemoveComponent("stuckdetection")
    -- end

    if inst.components.combat then
        inst.components.combat:SetRetargetFunction(1, NewRetargetFn)
    end

    if inst.components.lootdropper then
        if inst.prefab == "eyeofterror" then
            inst.components.lootdropper:SetLoot(eyeofterrorloot)
            elseif inst.prefab == "twinofterror1" then
            inst.components.lootdropper:SetLoot(twinofterror1loot)
            else
            inst.components.lootdropper:SetLoot(twinofterror2loot)
        end
    end

    if inst.components.health then
        inst.components.health.destroytime = 5
    end

    inst.OnCollide = OnCollide
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("enterlimbo", OnEnterLimbo)

    end
end

local function twinmanagerpostinit(inst)
    if TheWorld.ismastersim then

    inst.IsDying = twinsmanager_isdying

    inst:DoTaskInTime(0.1,function()
        local ply
        for i, v in ipairs(AllPlayers) do
            ply = v
        end
        inst:PushEvent("arrive",ply)
    end)

    inst:ListenForEvent("arrive", spawn_arriving_twins)

    inst.OnLoadPostPass = OnTwinManagerLoadPostPass
    end
end

AddPrefabPostInit("eyeofterror", postinit)
AddPrefabPostInit("twinofterror1", postinit)
AddPrefabPostInit("twinofterror2", postinit)
-- AddPrefabPostInit("twinmanager", twinmanagerpostinit)
