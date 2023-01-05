local modimport = modimport
local GetModConfigData = GetModConfigData

local mainfiles = {
    "treasurehunt",
    "actions",
    "tstuning",
    "assets",
    "util",
    "postinit",
    "strings",
    "cmd"
}

for k, v in ipairs(mainfiles) do
    modimport("main/".. v)
end

modimport("scripts/ham_fx")

-- 下面这个写法特别蠢,因为我懒 by:每年睡8760小时
local MOREDUBLOON = GetModConfigData("MOREDUBLOON")
if MOREDUBLOON == 1 then
    modimport("main/dubloon/dubloon1")
    elseif MOREDUBLOON == 2 then
    modimport("main/dubloon/dubloon2")
    elseif MOREDUBLOON == 3 then
    modimport("main/dubloon/dubloon3")
    elseif MOREDUBLOON == 4 then
    modimport("main/dubloon/dubloon4")
end
