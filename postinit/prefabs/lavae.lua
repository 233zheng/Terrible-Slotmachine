local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

local _RetargetFn
local RETARGET_MUST_TAGS = { "_combat" }
local RETARGET_CANT_TAGS = { "prey", "smallcreature", "INLIMBO","lavae","dragonfly" }
local function RetargetFn(inst, ...)
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
        )--, _RetargetFn(inst, ...)
end

local function OnAttacked(inst, data)
    if data.attacker ~= nil then
        local target = inst.components.combat.target
            inst.components.combat:SetTarget(data.attacker)
    end
end

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    if inst.components.combat then
        inst.components.combat:SetRetargetFunction(0.03, RetargetFn)
    end

    inst:ListenForEvent("attacked", OnAttacked)

end

AddPrefabPostInit("lavae", postinit)
