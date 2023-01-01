local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

local loot =
{
    "monstermeat",
    "monstermeat",
    "monstermeat",
    "monstermeat",
    "goldnugget",
    "goldnugget",
    "goldnugget",
    "goldnugget",
    "spidereggsack",
    "spiderhat",
}

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    inst:RemoveComponent("drownable")

    if inst.components.lootdropper then
        inst.components.lootdropper:SetLoot(loot)
    end

end

AddPrefabPostInit("spiderqueen", postinit)
