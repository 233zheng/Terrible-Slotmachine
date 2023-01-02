local modimport = modimport
GLOBAL.setfenv(1, GLOBAL)

local components_post = {
}

local prefabs_post = {
    "beequeen",
    "dragonfly",
    "eyeofterror",
    "klaus",
    "lavae",
    "minotaur",
    "moose",
    "mushroomsprout",
    "piratepack",
    "rocks",
    "slotmachine",
    "spiderqueen",
    "stalker",
    "tigershark",
    "toadstool",
    "treasurechest",
    "twister",
    "warg",
    "shadowchesspieces",
}

local stategraphs_post = {
    "slotmachine"
}

local brains_post = {
    "beequeenbrain",
    "dragonflybrain",
    "klausbrain",
    "moosebrain",
    "tigersharkbrain",
    "toadstoolbrain",
}

local scriptspostint = {
    "recipespostinit"
}

for _, file_name in pairs(components_post) do
    modimport("postinit/components/" .. file_name)
end

for _, file_name in pairs(prefabs_post) do
    modimport("postinit/prefabs/" .. file_name)
end

for _, file_name in pairs(stategraphs_post) do
    modimport("postinit/stategraphs/SG" .. file_name)
end

for _, file_name in pairs(brains_post) do
    modimport("postinit/brains/" .. file_name)
end

for k, v in ipairs(scriptspostint) do
    modimport("postinit/".. v)
end