local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

local loot =
{
    "goldnugget",
    "charcoal",
	"goldnugget",
    "klaus_sack",
}

----------------------------------postinit function----------------------------------------------

local _SetStatScale
local function SetStatScale(inst, scale, ...)
    inst.deer_dist = 3.5 * scale
    inst.hit_recovery = TUNING.KLAUS_HIT_RECOVERY * scale
    inst.attack_range = TUNING.KLAUS_ATTACK_RANGE * scale
    inst.hit_range = TUNING.KLAUS_HIT_RANGE * scale
    inst.chomp_cd = TUNING.KLAUS_CHOMP_CD / scale
    inst.chomp_range = math.min(TUNING.KLAUS_CHOMP_MAX_RANGE, TUNING.KLAUS_CHOMP_RANGE * scale)
    inst.chomp_min_range = TUNING.KLAUS_CHOMP_MIN_RANGE * scale
    inst.chomp_hit_range = TUNING.KLAUS_CHOMP_HIT_RANGE * scale

    inst.components.combat:SetRange(inst.attack_range, inst.hit_range)
    inst.components.combat:SetAttackPeriod(TUNING.KLAUS_ATTACK_PERIOD / scale)

    --scale by volume yo XD
    scale = scale * scale * scale
    local health_percent = inst.components.health:GetPercent()
    inst.components.health:SetMaxHealth(TUNING.KLAUS_HEALTH * scale)
    -- inst.components.health:SetPercent(health_percent)
    -- inst.components.health:SetAbsorptionAmount(scale > 1 and 1 - 1 / scale or 0) --don't want any floating point errors!
    inst.components.combat:SetDefaultDamage(TUNING.KLAUS_DAMAGE * scale)
    if _SetStatScale ~= nil then
        _SetStatScale(inst, scale, ...)
    end
end

local _SpawnDeer
local function SpawnDeer(inst, ...)
    if _SpawnDeer ~= nil then
        _SpawnDeer(inst, ...)
    end
end

-------------------------------------------------------------------------------------------------

local function postinit(inst)

    if inst.hasspawned then
        inst.hasspawned:Cancel()
        inst.hasspawned = nil
    end

    if TheWorld.ismastersim then

    SetStatScale(inst, 1)

    inst.SpawnDeer = SpawnDeer

    if inst.components.lootdropper then
        inst.components.lootdropper:SetLoot(loot)
    end

    end
end

AddPrefabPostInit("klaus", postinit)
