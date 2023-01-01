local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

local function posinit(inst)

    inst.Physics:CollidesWith(COLLISION.GIANTS)

    if not TheWorld.ismastersim then return end

end

AddPrefabPostInit("mushroomsprout", posinit)
