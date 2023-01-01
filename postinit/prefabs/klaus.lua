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

local function SetPhysicalScale(inst, scale)
    local xformscale = 1.2 * scale
    inst.Transform:SetScale(xformscale, xformscale, xformscale)
    inst.DynamicShadow:SetSize(3.5 * scale, 1.5 * scale)
    if scale > 1 then
        inst.Physics:SetMass(1000 * scale)
        inst.Physics:SetCapsule(1.2 * scale, 1)
    end
end

local function AnnounceWarning(inst, player, strid)
    if player:IsValid() and player.entity:IsVisible() and
        not (player.components.health ~= nil and player.components.health:IsDead()) and
        not player:HasTag("playerghost") and
        player:IsNear(inst, 15) and
        not inst.components.health:IsDead() and
        player.components.talker ~= nil then
        player.components.talker:Say(GetString(player, strid))
    end
end

local function PushWarning(inst, strid)
    for k, v in pairs(inst.recentattackers) do
        if k:IsValid() then
            inst:DoTaskInTime(math.random(), AnnounceWarning, k, strid)
        end
    end
end

local function Enrage(inst, warning)
    if not inst.enraged then
        inst.enraged = true
        inst.nohelpers = nil --redundant when enraged
        inst.Physics:Stop()
        inst.Physics:Teleport(inst.Transform:GetWorldPosition())
        SetPhysicalScale(inst, TUNING.KLAUS_ENRAGE_SCALE)
        SetStatScale(inst, TUNING.KLAUS_ENRAGE_SCALE)
        inst.components.sanityaura.aura = inst:IsUnchained() and -TUNING.SANITYAURA_HUGE or -TUNING.SANITYAURA_LARGE
        if warning then
            PushWarning(inst, "ANNOUNCE_KLAUS_ENRAGE")
        end
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

    if not TheWorld.ismastersim then return end

    SetStatScale(inst, 1)

    inst.SpawnDeer = SpawnDeer

    if inst.components.lootdropper then
        inst.components.lootdropper:SetLoot(loot)
    end

    inst.Enrage = Enrage

end

AddPrefabPostInit("klaus", postinit)
