local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

local RETARGET_MUST_TAGS = { "_combat" }
local RETARGET_CANT_TAGS = { "prey", "smallcreature", "INLIMBO", "tree", "snake"}
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

local function OnAttack(inst, data)
    local numshots = 30
    if data.target and data.target:IsValid() then
      for i = 0, numshots - 1 do
        local offset = Point(math.random(-3, 3), 0, math.random(-3, 3))
        -- local offset = Vector3(math.random(-3, 3), 0, math.random(-3, 3))
          inst.components.thrower:Throw(data.target:GetPosition() + offset)
        end
    end
end

local function leif_palmpostinit(inst)

    inst:AddTag("snakefriend")

    if not TheWorld.ismastersim then return end

    if inst.components.combat then
        inst.components.combat:SetRetargetFunction(3, RetargetFn)
    end

    inst:ListenForEvent("onattackother", OnAttack)

end

AddPrefabPostInit("leif_palm", leif_palmpostinit)
