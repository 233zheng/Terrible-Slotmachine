local brain = require("brains/lavaebrain")

local assets =
{
    Asset("ANIM", "anim/lavae.zip"),
    Asset("SOUND", "sound/together.fsb"),
}

local prefabs =
{
    "lavae_move_fx",
}

SetSharedLootTable( 'lavae_lava',
{
    {'houndfire',   1.0},
    {'houndfire',   1.0},
    {'houndfire',   1.0},
    {'houndfire',   1.0},
    {'houndfire',   1.0},
})

SetSharedLootTable( 'lavae_frozen',
{
    {'houndfire',   1.0},
    {'houndfire',   1.0},
    {'rocks',       1.0},
    {'rocks',       1.0},
    {'rocks',       1.0},
})

local function OnCollide(inst, other)
    if other ~= nil and
        other:IsValid() and
        other.components.burnable ~= nil and
        other.components.fueled == nil then
        other.components.burnable:Ignite(true, inst)
    end
end

local RETARGET_MUST_TAGS = { "_combat" }
local RETARGET_CANT_TAGS = { "prey", "smallcreature", "INLIMBO","lavae","dragonfly" }
local function RetargetFn(inst)
    local range = inst:GetPhysicsRadius(0) + 16
    return FindEntity(
            inst,
            16,
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

local function OnAttacked(inst, data)
    if data.attacker ~= nil then
        local target = inst.components.combat.target
        --if not (target ~= nil --and
                --target:HasTag("player") and
                --target:IsNear(inst, TUNING.DRAGONFLY_ATTACK_RANGE + target:GetPhysicsRadius(0))) 
    --)then
            inst.components.combat:SetTarget(data.attacker)
        --end
    end
end

local function KeepTargetFn(inst, target)
    local mother = inst.components.entitytracker:GetEntity("mother")
    return mother ~= nil and mother:IsNear(target, 75) --and target:HasTag("broken")
end

local function LockTarget(inst, target)
    inst.components.combat:SetTarget(target)
end

local function OnNewTarget(inst, data)
    if data.oldtarget ~= nil then
        inst:RemoveEventCallback("death", inst._ontargetdeath, data.oldtarget)
    end
    if data.target ~= nil and data.target:HasTag("player") then
        inst:ListenForEvent("death", inst._ontargetdeath, data.target)
    end
end

local function OnEntitySleep(inst)
    if inst.reset then
        inst:Remove()
    end
end

local function OnTimerDone(inst, data)
    if data.name == "selfdestruct" then
        inst.components.health:Kill()
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(2, 1)
    inst.Transform:SetSixFaced()

    ----------------------------------------------------
    --MakeCharacterPhysics(inst, 50, 0.5)
    inst.entity:AddPhysics()
    inst.Physics:SetMass(50)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    --inst.Physics:CollidesWith(COLLISION.GIANTS)
    inst.Physics:SetCapsule(.5, 1)
    ----------------------------------------------------

    inst.AnimState:SetBank("lavae")
    inst.AnimState:SetBuild("lavae")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("lavae")
    inst:AddTag("monster")
    inst:AddTag("hostile")

    inst.Light:SetRadius(2)
    inst.Light:SetFalloff(0.5)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetColour(235/255, 121/255, 12/255)
    inst.Light:Enable(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.Physics:SetCollisionCallback(OnCollide)

    inst:AddComponent("health")
    inst:AddComponent("combat")
    inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")
    inst:AddComponent("locomotor")
    inst:AddComponent("homeseeker")
    inst:AddComponent("entitytracker")
    inst:SetStateGraph("SGlavae")
    inst:SetBrain(brain)

    inst._ontargetdeath = function()
        local mother = inst.components.entitytracker:GetEntity("mother")
        local new_target = mother ~= nil and mother.components.grouptargeter ~= nil and mother.components.grouptargeter:SelectTarget() or nil
        if new_target ~= nil then
            inst.components.combat:SetTarget(new_target)
        end
    end

    inst.components.health:SetMaxHealth(TUNING.LAVAE_HEALTH)
    inst.components.health.fire_damage_scale = 0

    inst.components.combat:SetDefaultDamage(TUNING.LAVAE_DAMAGE)
    inst.components.combat:SetRange(TUNING.LAVAE_ATTACK_RANGE, TUNING.LAVAE_HIT_RANGE)
    inst.components.combat:SetAttackPeriod(TUNING.LAVAE_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst.components.combat:SetRetargetFunction(0.03, RetargetFn)

    inst.components.locomotor.walkspeed = 5.5

    inst:AddComponent("timer")
    inst.components.timer:StartTimer("selfdestruct", TUNING.LAVAE_LIFESPAN)
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst:ListenForEvent("attacked", OnAttacked)

    inst.LockTargetFn = LockTarget

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    inst:ListenForEvent("entitysleep", OnEntitySleep)

    MakeHauntablePanic(inst)

    MakeLargeFreezableCharacter(inst)

    return inst
end

return Prefab("lavae", fn, assets, prefabs)
