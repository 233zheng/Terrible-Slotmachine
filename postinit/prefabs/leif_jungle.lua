local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    if not IA_CONFIG.leif_jungle then
        -- inst:DoTaskInTime(0, function(_inst) _inst.components.health:Kill() end)
    end

end

AddPrefabPostInit("leif_jungle", postinit)
