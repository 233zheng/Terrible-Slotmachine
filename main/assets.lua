local STRINGS = GLOBAL.STRINGS
local resolvefilepath = GLOBAL.resolvefilepath
local TheNet = GLOBAL.TheNet
STRINGS.RECIPE_DESC.BLUEPRINT = "Random Blueprint"

-- GLOBAL.setfenv(1, GLOBAL)

PrefabFiles =
{
    "adult_flytrap",
    "ancient_hulk",
    "dungball",
    "dungbeetle",
    "laser",
    "laser_ring",
    "mean_flytrap",
    "pigman_city",
    "pog",
    "spider_monkey",
    "thunderbird",
    "vampirebat",
    "rock_basalt",
    "ancient_herald",

    --shadowchesses
    "shadowchesses",
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

AddMinimapAtlas("images/mean_flytrap.xml")

if not TheNet:IsDedicated() then
    table.insert(Assets, Asset("SOUND", "sound/DLC003_sfx.fsb"))
    table.insert(Assets, Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"))
end
