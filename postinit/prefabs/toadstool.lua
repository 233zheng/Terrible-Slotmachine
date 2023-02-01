local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable('toadstool2', {
    {"froglegs",      1.00},
    {"meat",          1.00},
    {"meat",          1.00},
    {"meat",          1.00},
    {"meat",          0.50},
    {"meat",          0.25},

    {"ruinshat", 1.00},
    {"ruinshat",       1.00},
    {"ruinshat",       0.33},
    {"ruinshat",       0.33},

    {"blue_cap",      1.00},
    {"blue_cap",      0.33},
    {"blue_cap",      0.33},

    {"goldnugget",    1.00},
    {"goldnugget",    1.00},
    {"goldnugget",    1.00},
    {"goldnugget",    1.00},

    {"armorruins",     1.00},
    {"armorruins",     0.33},
    {"armorruins",     0.33},
    {"armorruins",   1.00},
})

local PHASE2_HEALTH = .7
local PHASE3_HEALTH = .4

local function SetPhaseLevel(inst, phase)
    inst.phase = phase
    inst.pound_rnd = phase > 3 and inst.dark
    phase = math.min(3, phase)
    inst.sporebomb_targets = TUNING.TOADSTOOL_SPOREBOMB_TARGETS_PHASE[phase]
    inst.sporebomb_cd = TUNING.TOADSTOOL_SPOREBOMB_CD_PHASE[phase]
    inst.mushroombomb_count = TUNING.TOADSTOOL_MUSHROOMBOMB_COUNT_PHASE[phase]
    if phase > 2 then
        inst.components.timer:ResumeTimer("pound_cd")
    else
        inst.components.timer:StopTimer("pound_cd")
        inst.components.timer:StartTimer("pound_cd", TUNING.TOADSTOOL_ABILITY_INTRO_CD, true)
    end
end

local _DropShroomSkin
local function DropShroomSkin(inst, ...)
    local player--[[, rangesq]] = inst:GetNearestPlayer()
    LaunchAt(SpawnPrefab("armorruins"), inst, player, 1, 4, 2)
    if _DropShroomSkin ~= nil then
        _DropShroomSkin(inst, ...)
    end
end

local function EnterPhase2Trigger(inst)
    if inst.phase < 2 then
        SetPhaseLevel(inst, 2)
        if inst.components.health:GetPercent() > PHASE3_HEALTH then
            DropShroomSkin(inst)
        end
        inst:PushEvent("roar")
    end
end

local function EnterPhase3Trigger(inst)
    if inst.phase < 3 then
        SetPhaseLevel(inst, 3)
        if not inst.components.health:IsDead() then
            DropShroomSkin(inst)
        end
        inst:PushEvent("roar")
    end
end

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    -- if inst.components.health then
    --     inst.components.health:SetMaxHealth(TUNING.TOADSTOOL_HEALTH/2)
    -- end

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable("toadstool2")
    end

    if inst.components.healthtrigger ~= nil then
        inst.components.healthtrigger:AddTrigger(PHASE2_HEALTH, EnterPhase2Trigger)
        inst.components.healthtrigger:AddTrigger(PHASE3_HEALTH, EnterPhase3Trigger)
    end
end

AddPrefabPostInit("toadstool", postinit)
