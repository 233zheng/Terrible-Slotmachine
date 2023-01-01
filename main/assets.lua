local STRINGS = GLOBAL.STRINGS
STRINGS.RECIPE_DESC.BLUEPRINT = "Random Blueprint"

GLOBAL.setfenv(1, GLOBAL)

PrefabFiles =
{
    "adult_flytrap",
    "ancient_hulk",
    "dungball",
    "dungbeetle",
    "iron",
    "laser",
    "laser_ring",
    "mean_flytrap",
    "pigman_city",
    "pog",
    "spider_monkey",
    "thunderbird",
    "vampirebat",
    --fx
    "hamlet_fx"
}

local AddInventoryItemAtlas = gemrun("tools/misc").Local.AddInventoryItemAtlas
AddInventoryItemAtlas(resolvefilepath("images/mean_flytrap.xml"))

Assets = {
    --Loading minimap
    Asset("ATLAS", "images/mean_flytrap.xml"),
    Asset("IMAGE", "images/mean_flytrap.tex"),
}

if not TheNet:IsDedicated() then
    table.insert(Assets, Asset("SOUND", "sound/DLC003_sfx.fsb"))
    table.insert(Assets, Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"))
end
