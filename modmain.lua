local STRINGS = GLOBAL.STRINGS
local modimport = modimport
--local IAENV = env

--GLOBAL.setfenv(1, GLOBAL)

--RemoveDefaultCharacter("wortox")

STRINGS.RECIPE_DESC.BLUEPRINT = "Random Blueprint"

PrefabFiles = 
{
    "mean_flytrap",
    "adult_flytrap",
    "spider_monkey",
    "pog",
    "thunderbird",
    "thunderbirdnest",
    "iron",
    --"infused_iron",
    "ancient_hulk",
    "laser_ring",
    "laser",
    "slotmachine",
    "bearger",
    "beequeen",
    "dragonfly",
    "hound",
    "iron",
    "klaus",
    "minotaur",
    "moose",
    "lavae",
    "leif_palm",
    "mean_flytrap",
    "mushroomsprout",
    "spider_monkey",
    "vampirebat",
    "rocks",
    "spider_monkey_herd",
    "dungball",
    "dungbeetle",
    --"spider_monkey_tree",
    "toadstool",
    "twister",
    "warg",
    --"wortox_soul_common",
    "tigershark",
    "stalker",
    "pigman_city",

    "godmaster",
}

Assets = 
{
    --Asset("SOUNDPACKAGE", "sound/dontstarve_DLC002.fev"),
    --Asset("SOUNDPACKAGE", "sound/sw_character.fev"),
    --Asset("SOUND", "sound/dontstarve_shipwreckedSFX.fsb"),
    --Asset("SOUND", "sound/sw_character.fsb"),
    Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"),
    Asset("SOUND", "sound/DLC003_sfx.fsb")
}

local mainfiles = {
    "recipeInit",
    "treasurehunt",
    "addaction",
    "ham_fx",
    "stringsCh",
    "tstuning",
    "tuning2"
}

for k, v in ipairs(mainfiles) do
    modimport("main/".. v)
end

--下面这个写法特别蠢,因为我懒 by:每年睡8760小时
local MOREDUBLOON = GetModConfigData("MOREDUBLOON")
if MOREDUBLOON == 1 then
    modimport("main/dubloon1")
    elseif MOREDUBLOON == 2 then
    modimport("main/dubloon2")
    elseif MOREDUBLOON == 3 then
    modimport("main/dubloon3")
    elseif MOREDUBLOON == 4 then
    modimport("main/dubloon4")
end

function GetAporkalypse()
    return false
end

GLOBAL.GetAporkalypse = GetAporkalypse