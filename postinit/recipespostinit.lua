local AddCharacterRecipe = AddCharacterRecipe
local AddRecipe2 = AddRecipe2
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH
GLOBAL.setfenv(1, GLOBAL)

AddRecipe2("amulet", {Ingredient("goldnugget", 1)}, TECH.NONE, nil, {"MAGIC"})
AddRecipe2("goldnugget", {Ingredient("dubloon", 5), Ingredient("nightmarefuel", 2)}, TECH.NONE, {nounlock=false}, {"REFINE"})
AddRecipe2("dubloon", {Ingredient("goldnugget", 1)}, TECH.NONE, {numtogive=10} ,{"REFINE"})

AddCharacterRecipe("pocketwatch_weapon", {Ingredient("goldnugget", 8)}, TECH.NONE, {builder_tag="clockmaker"}, {"MAGIC"})
AddCharacterRecipe("pocketwatch_heal", {Ingredient("goldnugget", 6)}, TECH.NONE, {builder_tag="clockmaker"}, {"MAGIC"})
AddCharacterRecipe("pocketwatch_warp", {Ingredient("goldnugget", 3)}, TECH.NONE, {builder_tag="clockmaker"}, {"MAGIC"})
AddCharacterRecipe("pocketwatch_revive", {Ingredient("goldnugget", 4)}, TECH.NONE, {builder_tag="clockmaker"}, {"MAGIC"})
AddCharacterRecipe("wathgrithrhat", {Ingredient("goldnugget", 1)}, TECH.NONE, {builder_tag="valkyrie"}, {"MAGIC"})
AddCharacterRecipe("battlesong_durability", {Ingredient("goldnugget", 1)}, TECH.NONE, {builder_tag="valkyrie"}, {"MAGIC"})
AddCharacterRecipe("battlesong_healthgain", {Ingredient("goldnugget", 1)}, TECH.NONE, {builder_tag="valkyrie"}, {"MAGIC"})
AddCharacterRecipe("battlesong_sanitygain", {Ingredient("goldnugget", 1)}, TECH.NONE, {builder_tag="valkyrie"}, {"MAGIC"})
AddCharacterRecipe("battlesong_sanityaura", {Ingredient("goldnugget", 1)}, TECH.NONE, {builder_tag="valkyrie"}, {"MAGIC"})
AddCharacterRecipe("battlesong_fireresistance", {Ingredient("goldnugget", 1)}, TECH.NONE, {builder_tag="valkyrie"}, {"MAGIC"})
AddCharacterRecipe("battlesong_instant_taunt", {Ingredient("goldnugget", 1)}, TECH.NONE, {builder_tag="valkyrie"}, {"MAGIC"})
AddCharacterRecipe("battlesong_instant_panic", {Ingredient("goldnugget", 1)}, TECH.NONE, {builder_tag="valkyrie"}, {"MAGIC"})
AddCharacterRecipe("dumbbell_gem", {Ingredient("goldnugget", 1)}, TECH.NONE, {builder_tag="strongman"}, {"MAGIC"})
