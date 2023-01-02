local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable("alterguardian_phase1_init",
{
    "poop"
})

local _onothercollide
local function onothercollide(inst, other, ...)
    if not other:IsValid() then
        return

    elseif other:HasTag("smashable") and other.components.health ~= nil then
        other.components.health:Kill()

    elseif other.components.workable ~= nil
            and other.components.workable:CanBeWorked()
            and other.components.workable.action ~= ACTIONS.NET then
            local fx  = SpawnPrefab("collapse_small")
        fx.Transform:SetPosition(other.Transform:GetWorldPosition())
        other.components.workable:Destroy(inst)

    elseif other.components.health ~= nil and not other.components.health:IsDead() then
        inst.SoundEmitter:PlaySound("moonstorm/creatures/boss/alterguardian1/onothercollide")
        inst.components.combat:DoAttack(other)
    end

    if  _onothercollide ~= nil then
        _onothercollide(inst, other, ...)
    end

end

local _oncollide
local COLLISION_DSQ = 42
local function oncollide(inst, other, ...)
    if inst._collisions[other] == nil and other ~= nil and other:IsValid()
            and Vector3(inst.Physics:GetVelocity()):LengthSq() > COLLISION_DSQ then
        ShakeAllCameras(CAMERASHAKE.SIDE, .5, .05, .1, inst, 40)
        inst:DoTaskInTime(2 * FRAMES, onothercollide, other)
        inst._collisions[other] = true

        if other:HasTag("player") and not other:HasTag("playerghost") then
            inst:PushEvent("rollcollidedwithplayer")
        end
    end
    if _oncollide ~= nil then
        _oncollide(inst, other, ...)
    end
end

local function EnableRollCollision(inst, enable)
    if enable then
        inst.Physics:SetCollisionCallback(oncollide)
        inst._collisions = {}
    else
        inst.Physics:SetCollisionCallback(nil)
        inst._collisions = nil
    end
end

local function posinit(inst)

    if inst._camerafocus then
        inst._camerafocus:Cancel()
        inst._camerafocus = nil
    end

    if TheWorld.ismastersim then

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable("alterguardian_phase1_init")
    end

    inst.EnableRollCollision = EnableRollCollision

    end
end

AddPrefabPostInit("alterguardian_phase1", posinit)
