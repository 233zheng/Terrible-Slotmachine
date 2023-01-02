local IAENV = env
GLOBAL.setfenv(1, GLOBAL)

--Not directly treasure, but relevant:
SLOTMACHINE_LOOT =
{
	-- A weighted average list of prizes, the bigger the number, the more likely it is.
	-- It's based off altar_prototyper.lua
	TSgoodspawns = -- Best Slot Loot List
	{
	--	log = 50,
	--	twigs =50,
	--	cutgrass = 50,
	--	berries = 50,
	--	limpets = 50,
	--	meat = 50,
	--	monstermeat = 50,
	--	fish = 50,
	--	meat_dried = 30,
	--	seaweed = 50,
	--	jellyfish = 20,
	--	dubloon = 50,
	--	redgem = 10,
	--	bluegem = 10,
	--	purplegem = 10,
	--	goldnugget = 50,
	--	snakeskin = 20,
	--	spidergland = 20,
	--	torch = 50,
	--	coconut = 50,

		slot_goldy = 1,
		slot_10dubloons = 1,
		slot_honeypot = 1,
		slot_warrior1 = 1,
		--slot_warrior2 = 0.3,
		slot_warrior2 = 1,
		slot_warrior3 = 1,
		slot_warrior4 = 1,
		slot_scientist = 1,
		slot_walker = 1,
		slot_gemmy = 1,
		slot_bestgem = 1,
		slot_lifegiver = 1,
		slot_chilledamulet = 1,
		slot_icestaff = 1,
		slot_firestaff = 1,
		slot_coolasice = 1,
		slot_gunpowder = 1,
		slot_firedart = 0.3,
		slot_sleepdart = 0.3,
		slot_blowdart = 1,
		slot_speargun = 1,
		slot_coconades = 1,
		slot_obsidian = 0.3,
		slot_thuleciteclub = 1,
		slot_ultimatewarrior = 0.3,
		slot_goldenaxe = 1,
		staydry = 1,
		cooloff = 0.3,
		birders = 0.3,
		--gears = 1,
		--trinket = 2,
		slot_seafoodsurprise = 1,
		slot_fisherman = 1,
		slot_camper = 1,
		slot_spiderboon = 1,
		slot_dapper = 0.3,
		slot_speed = 1,
		slot_tailor = 1,
        slot_cookpot = 2,
        slot_warrior5 = 1,
		slot_glasscutter = 1,
		slot_3dubloons = 1,
		slot_cutlass = 1
	},
	TSokspawns = -- Food and Resources
	{
		slot_anotherspin = 5,
		firestarter = 5,
		geologist = 5,
		cutgrassbunch = 5,
		logbunch = 5,
		twigsbunch = 5,
		--torch = 5,
		slot_torched = 5,
		slot_jelly = 5,
		slot_handyman = 5,
		slot_poop = 5,
		slot_berry = 5,
		slot_limpets = 5,
		slot_bushy = 5,
		slot_bamboozled = 5,
		slot_grassy = 5,
		slot_prettyflowers = 5,
		slot_witchcraft = 5,
		slot_bugexpert = 5,
		slot_flinty = 5,
		slot_fibre = 5,
		slot_drumstick = 5,
		slot_ropey = 5,
		slot_jerky = 5,
		slot_coconutty = 5,
		campfire = 5,
        slot_koalefant_summer = 5,
        slot_doydoy = 5,
        slot_nightstick = 5,
        slot_armor_bramble = 5,
        slot_health = 5,
        slot_armorwood  = 5,
        slot_footballhat = 5,
		--wathgrithrhat = 4,
		--whip = 2.5,
		--cookiecutterhat = 4,
        slot_thunderbird = 5,
		slot_dungbeetle = 5,
	},
	TSbadspawns =
	{
 		--snake = 1,
		--spider_hider = 1,
		slot_spiderattack = 8,
		slot_mosquitoattack = 4,
		slot_snakeattack = 6,
		slot_monkeysurprise = 2,
		slot_poisonsnakes = 3,
		slot_hounds = 6,
        slot_spiderqueen = 2,
        spiderden_2 = 2,
        moose = 1,
        bearger = 1,
        --beequeen = 0.3,
        --dragonfly = 0.3,
        slot_bishop = 2,
        slot_knight = 2,
        slot_rook = 2,
        slot_chesses = 1,
        tigershark = 1,
        twister = 1,
        shadow_rook = 1,
        shadow_knight = 1,
        slot_tentacle = 4,
        slot_bat = 4,
		slot_vbat = 4,
        slot_slurper = 4,
        slot_tallbird = 5,
        --treeguard = 2,
        leif = 2,
        slot_merm = 4,
        minotaur = 1,
        ancient_hulk = 1,
        warg = 2,
        slot_ghost = 4,
        warglet = 2,
        slot_frog = 3,
        slot_leif_palm = 1.5,
		slot_leif_jungle = 1.5,
        slot_dragoon = 4,
        --toadstool = 0.3,
        --klaus = 0.3,
        slot_mean_flytrap = 12,
        slot_spider_monkey = 4,
		stalker = 1,
		eyeofterror = 1,
		slot_flup = 1,
		slot_pig_royalguard_rich = 1,
		slot_pigman_royalguard =1,
        slot_pog = 1,
		--nothing = 100,
	},
	lavaespawns =
	{
        lavae = 1,
	},
	actions = -- actions to perform for the spawns
	{
		-- if there's a cnt, then it'll spawn that many
		-- if there's a var, then that'll be used as variance for cnt
		-- if there's a "callback" function, then that'll run cnt times (min once)
		-- if there's a treasure, it'll spawn that instead of an item

		--trinket = { cnt = 2, },
		--spider_hider = { cnt = 3, },
		--snake = { cnt = 3, },

		firestarter = { treasure = "firestarter", },
		geologist = { treasure = "geologist", },
		cutgrassbunch = { treasure = "3cutgrass", },
		logbunch = { treasure = "3logs", },
		twigsbunch = { treasure = "3twigs", },
		slot_torched = { treasure = "slot_torched", },
		slot_jelly = { treasure = "slot_jelly", },
		slot_handyman = { treasure = "slot_handyman", },
		slot_poop = { treasure = "slot_poop", },
		slot_berry = { treasure = "slot_berry", },
		slot_limpets = { treasure = "slot_limpets", },
		slot_seafoodsurprise = { treasure = "slot_seafoodsurprise", },
		slot_bushy = { treasure = "slot_bushy", },
		slot_bamboozled = { treasure = "slot_bamboozled", },
		slot_grassy = { treasure = "slot_grassy", },
		slot_prettyflowers = { treasure = "slot_prettyflowers", },
		slot_witchcraft = { treasure = "slot_witchcraft", },
		slot_bugexpert = { treasure = "slot_bugexpert", },
		slot_flinty = { treasure = "slot_flinty", },
		slot_fibre = { treasure = "slot_fibre", },
		slot_drumstick = { treasure = "slot_drumstick", },
		slot_fisherman = { treasure = "slot_fisherman", },
		slot_dapper = { treasure = "slot_dapper", },
		slot_speed = { treasure = "slot_speed", },
        slot_cookpot = { treasure = "slot_cookpot", },
		slot_cutlass = { treasure = "slot_cutlass", },

		slot_anotherspin = { treasure = "slot_anotherspin", },
		slot_goldy = { treasure = "slot_goldy", },
		slot_honeypot = { treasure = "slot_honeypot", },
		slot_warrior1 = { treasure = "slot_warrior1", },
		slot_warrior2 = { treasure = "slot_warrior2", },
		slot_warrior3 = { treasure = "slot_warrior3", },
		slot_warrior4 = { treasure = "slot_warrior4", },
		slot_scientist = { treasure = "slot_scientist", },
		slot_walker = { treasure = "slot_walker", },
		slot_gemmy = { treasure = "slot_gemmy", },
		slot_bestgem = { treasure = "slot_bestgem", },
		slot_lifegiver = { treasure = "slot_lifegiver", },
		slot_chilledamulet = { treasure = "slot_chilledamulet", },
		slot_icestaff = { treasure = "slot_icestaff", },
		slot_firestaff = { treasure = "slot_firestaff", },
		slot_coolasice = { treasure = "slot_coolasice", },
		slot_gunpowder = { treasure = "slot_gunpowder", },
		slot_firedart = { treasure = "slot_firedart", },
		slot_sleepdart = { treasure = "slot_sleepdart", },
		slot_blowdart = { treasure = "slot_blowdart", },
		slot_speargun = { treasure = "slot_speargun", },
		slot_coconades = { treasure = "slot_coconades", },
		slot_obsidian = { treasure = "slot_obsidian", },
		slot_thuleciteclub = { treasure = "slot_thuleciteclub", },
		slot_ultimatewarrior = { treasure = "slot_ultimatewarrior", },
		slot_goldenaxe = { treasure = "slot_goldenaxe", },
		staydry = { treasure = "staydry", },
		cooloff = { treasure = "cooloff", },
		birders = { treasure = "birders", },
		slot_monkeyball = { treasure = "slot_monkeyball", },
        slot_health = { treasure = "slot_health", },
        slot_warrior5 = { treasure = "slot_warrior5", },
        slot_warrior6 = { treasure = "slot_warrior6", },
        slot_thunderbird = { treasure = "slot_thunderbird", },
		slot_dungbeetle = { treasure = "slot_dungbeetle", },
		slot_koalefant_summer = { treasure = "slot_koalefant_summer", },
		slot_doydoy = { treasure = "slot_doydoy", },
		slot_nightstick = { treasure = "slot_nightstick", },
		slot_armor_bramble = { treasure = "slot_armor_bramble", },
		slot_armorwood = { treasure = "slot_armorwood", },
		slot_footballhat = { treasure = "slot_footballhat", },

		slot_bonesharded = { treasure = "slot_bonesharded", },
		slot_jerky = { treasure = "slot_jerky", },
		slot_coconutty = { treasure = "slot_coconutty", },
		slot_camper = { treasure = "slot_camper", },
		slot_ropey = { treasure = "slot_ropey", },
		slot_tailor = { treasure = "slot_tailor", },
		slot_spiderboon = { treasure = "slot_spiderboon", },
		slot_3dubloons = { treasure = "3dubloons", },
		slot_10dubloons = { treasure = "10dubloons", },

		slot_spiderattack = { treasure = "slot_spiderattack", },
		slot_mosquitoattack = { treasure = "slot_mosquitoattack", },
		slot_monkeysurprise = { treasure = "slot_monkeysurprise", },
		slot_poisonsnakes = { treasure = "slot_poisonsnakes", },
		slot_hounds = { treasure = "slot_hounds", },
		slot_snakeattack = { treasure = "slot_snakeattack", },
        slot_spiderqueen = { treasure = "slot_spiderqueen", },
        slot_bishop = { treasure = "slot_bishop", },
        --slot_spiderden_2 = { treasure = "slot_spiderden_2", },
        slot_knight = { treasure = "slot_knight", },
        slot_rook = { treasure = "slot_rook", },
        slot_chesses = { treasure = "slot_chesses", },
        slot_tentacle = { treasure = "slot_tentacle", },
        slot_bat = { treasure = "slot_bat", },
		slot_vbat = { treasure = "slot_vbat", },
        slot_slurper = { treasure = "slot_slurper", },
        slot_tallbird = { treasure = "slot_tallbird", },
        slot_merm = { treasure = "slot_merm", },
        slot_ghost = { treasure = "slot_ghost", },
        slot_frog = { treasure = "slot_frog", },
        slot_leif_palm = { treasure = "slot_leif_palm", },
		slot_leif_jungle = { treasure = "slot_leif_jungle", },
        slot_dragoon = { treasure = "slot_dragoon", },
        slot_mean_flytrap = { treasure = "slot_mean_flytrap", },
        slot_spider_monkey = { treasure = "slot_spider_monkey", },
		slot_pig_royalguard_rich = { treasure  = "slot_pig_royalguard_rich", },
		slot_pigman_royalguard = { treasure = "slot_pigman_royalguard", },

	}
}
OCTOPUSKING_LOOT = {
	randomchestloot = -- These are "dubloon" substitutes for when there's not specific chestloot.
	{
		"seaweed",
		"seaweed",
		"seaweed",
		"seaweed",
		"seaweed",
		"seashell",
		"seashell",
		"seashell",
		"coral",
		"coral",
		"coral",
		"shark_fin",
		"blubber",
	},
	chestloot = -- These are specific boni for specific gifts. Not to be confused with item.components.trabable.tradefor !
	{
		californiaroll = "sail_palmleaf",
		seafoodgumbo = "sail_cloth",
		bisque = "trawlnet",
		jellyopop = "seatrap",
		ceviche = "telescope",
		surfnturf = "boat_lantern",
		lobsterbisque = "piratehat",
		lobsterdinner = "boatcannon",
		caviar = "boatrepairkit",
		tropicalbouillabaisse = "sail_feather",
		sharkfinsoup = "sail_snakeskin",
		musselbouillabaise = "captainhat",
	},
}

if not IA_CONFIG.octopustrade then
	OCTOPUSKING_LOOT.chestloot["caviar"] = nil
	OCTOPUSKING_LOOT.chestloot["tropicalbouillabaisse"] = nil
	OCTOPUSKING_LOOT.chestloot["sharkfinsoup"] = nil
	OCTOPUSKING_LOOT.chestloot["musselbouillabaise"] = nil
end
---------------------------------------------------------------------


local internaltreasure =
{
	["TestTreasure"] =
	{
		{
			--Set piece with the treasure prefab
			treasure_set_piece = "BuriedTreasureLayout",

			--The treasure prefab itself. If treasure_set_piece is set this is the prefab
			--inside the set piece. If treasure_set_piece is not set this prefab will be spawned
			--during worldgen
			treasure_prefab = "buriedtreasure",

			--Set piece with the map prefab, only for the first stage in multi stage treasures
			map_set_piece = "TreasureHunterBoon",

			--currently unused
			map_prefab = "ia_messagebottle",

			--Reference to the loot table for the treasure when it is dug up
			loot = "snaketrap"
		}
	},
	["PirateBank"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "10dubloons",
		}
	},

	["SuperTelescope"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "SuperTelescope",
		}
	},

	["WoodlegsKey1"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "WoodlegsKey1",
		}
	},

	["WoodlegsKey2"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "WoodlegsKey2",
		}
	},

	["WoodlegsKey3"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "WoodlegsKey3",
		}
	},

	["PiratePeanuts"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "1dubloon",
		}
	},

	["minerhat"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "minerhat",
		}

	},

	["RandomGem"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "gems",
		}
	},


	["DubloonsGem"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "dubloonsandgem",
		}
	},


	["SeamansCarePackage"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "seamanscarepackage",
		}
	},

	["ChickenOfTheSea"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "ChickenOfTheSea",
		}
	},

		["BootyInDaBooty"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "BootyInDaBooty",
		}
	},

		["OneTrueEarring"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "OneTrueEarring",
		}
	},

		["PegLeg"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "PegLeg",
		}
	},

		["VolcanoStaff"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "VolcanoStaff",
		}
	},

		["Gladiator"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "Gladiator",
		}
	},

		["FancyHandyMan"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "FancyHandyMan",
		}
	},

		["LobsterMan"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "LobsterMan",
		}
	},

		["Compass"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "Compass",
		}
	},

		["Scientist"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "Scientist",
		}
	},

		["Alchemist"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "Alchemist",
		}
	},

		["Shaman"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "Shaman",
		}
	},

		["FireBrand"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "FireBrand",
		}
	},

		["SailorsDelight"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "SailorsDelight",
		}
	},

		["WarShip"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "WarShip",
		}
	},

--[[ 		["Desperado"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "Desperado",
		}
	},	 ]]

		["JewelThief"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "JewelThief",
		}
	},

		["AntiqueWarrior"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "AntiqueWarrior",
		}
	},

		["Yaar"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "Yaar",
		}
	},

		["GdayMate"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "GdayMate",
		}
	},

		["ToxicAvenger"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "ToxicAvenger",
		}
	},

		["MadBomber"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "MadBomber",
		}
	},

		["FancyAdventurer"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "FancyAdventurer",
		}
	},

		["ThunderBall"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "ThunderBall",
		}
	},

		["TombRaider"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "TombRaider",
		}
	},

		["SteamPunk"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "SteamPunk",
		}
	},

		["CapNCrunch"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "CapNCrunch",
		}
	},

		["AyeAyeCapn"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "AyeAyeCapn",
		}
	},

		["BreakWind"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "BreakWind",
		}
	},

		["Diviner"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "Diviner",
		}
	},

		["GoesComesAround"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "GoesComesAround",
		}
	},

		["GoldGoldGold"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "GoldGoldGold",
		}
	},

		["FirePoker"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "FirePoker",
		}
	},

		["DeadmansTreasure"] =
	{
		{
			treasure_set_piece = "RockSkull",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "DeadmansTreasure",
		}
	},

	["TestMultiStage"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "gems",
		},
	},

	["SeaPackageQuest"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "dubloonsandgem",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "seamanscarepackage",
		},
	},

	["TierQuest"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "seamanscarepackage",
		},
		{
			tier = 1,
		},
		{
			tier = 2,
		},
		{
			tier = 2,
		},
		{
			tier = 3,
		},
	}
}

-- everytime a tier chest is picked, it's removed from this list
local Tiers =
{
	[1] = {
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_blowdart",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_speargun",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_obsidian",
		},
	},
	----------------------------------------------------------------------
	[2] = {
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_blowdart",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_speargun",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_obsidian",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_dapper",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_speed",
		},

	},
	----------------------------------------------------------------------
	[3] = {
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_blowdart",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_speargun",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "ia_messagebottle",
			loot = "slot_obsidian",
		},
	},
}

local internalloot =
{
	--[[
	["sample"] =
	{
		--[Optional] container that spawns with the loot in it see prefabs/treasurechest.lua
		--any prefab with a container component should work
		chest = "treasurechest",

		--All items in loot is given when a treasure is dug up
		loot =
		{
			dubloon = 2,
			redgem = 4
		},

		--'num_random_loot' items are given from random_loot (a weighted table)
		num_random_loot = 1,
		random_loot =
		{
			purplegem = 1,
			orangegem = 1,
			yellowgem = 1,
			greengem = 1,
			redgem = 5,
			bluegem = 5,
		},

		--Every item in chance_loot has a custom chance of being given
		--Possible for nothing or everything to be given
		chance_loot =
		{
			dubloon = 0.25,
			goldnugget = 0.25,
			bluegem = 0.1
		},

		--A custom function used to give items
		custom_lootfn = function(lootlist) end
	},
	--]]
	["snaketrap"] =
	{
		loot =
		{
			snake = 3,
			dubloon = 3,
		},
		chance_loot =
		{
			redgem = .8,
			bluegem = .8,
			purplegem = .6,
			orangegem = .4,
			yellowgem = .4,
			greengem = .4,
		},
	},

	["1dubloon"] =
    {
        loot =
        {
            dubloon = 1,
            thulecite_pieces = 8,
            moonrocknugget = 4,
        }
    },

    ["3dubloons"] =
    {
        loot =
        {
            dubloon = 3,
            piratepack = 1,
        }
    },

    ["10dubloons"] =
    {
        loot =
        {
            dubloon = 10,
        }
    },

	["SuperTelescope"] =
	{
		loot =
		{
			supertelescope = 1,
			dubloon = 5,
			spear_poison = 1,
			boat_lantern = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},
	},

	["minerhat"] =
	{
		loot =
		{
			minerhat = 1,
			dubloon = 5,
			obsidianaxe = 1,
			marble = 4, -- not in vanilla
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},
	},

	["seamanscarepackage"] =
	{
		chest = "pandoraschest",
		loot =
		{
			dubloon = 5,
			telescope = 1,
			armor_lifejacket = 1,
			captainhat = 1
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},
	},

	["gems"] =
	{
		chest = "treasurechest",
		loot =
		{
			dubloon = math.random(6,12),
			goldnugget = math.random(3,6),
			redgem = 1,
			bluegem = 1,
			purplegem = 1,
			orangegem = 1,
			yellowgem = 1,
			greengem = 1,
		},
	},

	["dubloonsandgem"] =
	{
		loot =
		{
			dubloon = 5,
		},
		chance_loot =
		{
			redgem = .8,
			bluegem = .8,
			purplegem = .6,
			orangegem = .4,
			yellowgem = .4,
			greengem = .4,
		},
	},

	["ChickenOfTheSea"] =
	{
		loot =
		{
			dubloon = 5,
			tunacan = 5,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
    },
-------------------------------------------------------DAN ADDED FROM HERE
	["BootyInDaBooty"] =
	{
		loot =
		{
			dubloon = 5,
			piratepack = 1,
			marble = 4, -- not in vanilla
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["OneTrueEarring"] =
	{
		loot =
		{
			thulecite = 4, -- not in vanilla
			nightmarefuel = 4, -- not in vanilla
			earring = 1,
			orangegem = 1, -- not in vanilla
		},
		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["PegLeg"] =
	{
		loot =
		{
			dubloon = 2,
			peg_leg = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["VolcanoStaff"] =
	{
		loot =
		{
			dubloon = 6,
			volcanostaff = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["Gladiator"] =
	{
		loot =
		{
			dubloon = 2,
			footballhat = 1,
			spear = 1,
			armorseashell= 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["FancyHandyMan"] =
	{
		loot =
		{
			dubloon = 1,
			goldenaxe = 1,
			goldenshovel = 1,
			goldenpickaxe= 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

	["LobsterMan"] =
	{
		loot =
		{
			dubloon = 4,
			boat_lantern = 1,
			seatrap = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["Compass"] =
	{
		loot =
		{
			dubloon = 3,
			compass = 1,
			boneshard = 2,
			ia_messagebottleempty = 1,
			sand = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		}
	},

	["Scientist"] =
	{
		loot =
		{
			dubloon = 3,
			transistor = 1,
			gunpowder = 3,
			heatrock = 1,
			marble = 4, -- not in vanilla
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["Alchemist"] =
	{
		loot =
		{
			dubloon = 2,
			antivenom = 1,
			healingsalve = 3,
			blowdart_sleep = 2,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["Shaman"] =
	{
		loot =
		{
			dubloon = 1,
			nightsword = 1,
			amulet = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

	["FireBrand"] =
	{
		loot =
		{
			dubloon = 2,
			obsidianaxe = 1,
			gunpowder = 2,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["SailorsDelight"] =
	{
		loot =
		{
			dubloon = 4,
			sail_cloth = 1,
			boatrepairkit = 1,
			boat_lantern = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

	["WarShip"] =
	{
		loot =
		{
			dubloon = 3,
			coconade = 3,
			boatcannon = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

["Desperado"] =
	{
		loot =
		{
			dubloon = 1,
			snakeskinhat = 1,
			armor_snakeskin = 1,
			spear_launcher = 2,
			spear = 1,
		},

	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["JewelThief"] =
	{
		loot =
		{
			dubloon = math.random(6,12), -- 5 in vanilla
			goldnugget = math.random(3,6), -- 6 in vanilla
			thulecite_pieces = math.random(6,12), -- not in vanilla
			purplegem = 2,
			redgem = 4,
			bluegem = 3,
			orangegem = 1, -- not in vanilla
			yellowgem = 1, -- not in vanilla
			greengem = 1, -- not in vanilla
		},	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope =1,
		}

    },

	["AntiqueWarrior"] =
	{
		loot =
		{
			dubloon = 5,
			ruins_bat = 1,
			ruinshat = 1,
			armorruins = 1,
			bluegem = 2,
			thulecite_pieces = math.random(6,12), -- not in vanilla
			moonrocknugget = 8, -- not in vanilla
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		}
	},

	["Yaar"] =
	{
		loot =
		{
			dubloon = 1,
			telescope = 1,
			piratehat = 1,
			boatcannon = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["GdayMate"] =
	{
		loot =
		{
			dubloon = 3,
			boomerang = 1,
			snakeskin = 3,
			strawhat = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},
	["ToxicAvenger"] =
	{
		loot =
		{
			dubloon = 1,
			gashat = 1,
			venomgland = 3,
			spear_poison = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["MadBomber"] =
	{
		loot =
		{
			dubloon = 2,
			coconade = 2,
			obsidiancoconade = 1,
			gunpowder = 2,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["FancyAdventurer"] =
	{
		loot =
		{
			dubloon = 4,
			goldenmachete = 1,
			tophat = 1,
			rope = 3,
			telescope = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		}
	},

	["ThunderBall"] =
	{
		loot =
		{
			dubloon = 6,
			spear_launcher = 2,
			spear = 1,
			blubbersuit = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["TombRaider"] =
	{
		loot =
		{
			dubloon = 4,
			boneshard = 3,
			nightmarefuel = 4,
			purplegem = 2,
			goldnugget = 3,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		}
	},

	["SteamPunk"] =
	{
		loot =
		{
			dubloon = 1,
			gears = 4,
			transistor = 2,
			telescope = 1,
			goldnugget = 2,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		}
	},

	["CapNCrunch"] =
	{
		loot =
		{
			dubloon = 4,
			piratehat = 1,
			boatcannon = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["AyeAyeCapn"] =
	{
		loot =
		{
			dubloon = 1,
			captainhat = 1,
			armor_lifejacket = 1,
			tunacan = 1,
			trawlnet = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		}
	},

	["BreakWind"] =
	{
		loot =
		{
			dubloon = 4,
			armor_windbreaker = 1,
			obsidianmachete = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["Diviner"] =
	{
		loot =
		{
			dubloon = 5,
			nightmarefuel = 5, -- 4 in vanilla
			gears = 2, -- 1 in vanilla
			-- 1 twig in vanilla
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["GoesComesAround"] =
	{
		loot =
		{
			dubloon = 3,
			boomerang = 1,
			trap_teeth = 2,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["GoldGoldGold"] =
	{
		loot =
		{
			dubloon = 6,
			goldnugget = 5,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["FirePoker"] =
	{
		loot =
		{
			dubloon = 2,
			spear_obsidian = 1,
			armorobsidian = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}
	},

	["DeadmansTreasure"] =
	{
		loot =
		{
			dubloon = 4,
			boatrepairkit = 1,
			goldenmachete = 1,
			obsidiancoconade = 3,
		},

		random_loot =
		{
			fabric = 1,
			papyrus = 1,
			tunacan = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem = 1,
			bluegem = 1,
			rope = 1,
		},

		chance_loot =
		{
			harpoon = .1,
			boatcannon = .01,
			rope = .25,
		}
	},
-------------------------------GOOD LIST

	["staydry"] =
	{
		loot =
		{
			--palmleaf_umbrella = 1,
			armordragonfly = 1,
			dubloon = 3,
		},
	},

	["gears"] =
	{
		loot =
		{
			gears = 5,

		},
	},

	["slot_cutlass"] =
	{
		loot =
		{
			cutlass = 1,
			armorlimestone = 1,
			dubloon = 3,
		},
	},

	["cooloff"] =
	{
		loot =
		{
			greenstaff = 1,
			greenamulet = 1,
			--umbrella = 1,
		},
	},

	["birders"] =
	{
		loot =
		{
			brainjellyhat = 1,
			--featherhat = 1,
			nightmarefuel = 4,
		},
	},

	["slot_anotherspin"] =
	{
		loot =
		{
			dubloon = 1,
		},
	},

	["slot_goldy"] =
	{
		loot =
		{
			goldnugget = 5,
		},
	},

	["slot_honeypot"] =
	{
		loot =
		{
			beehat = 1,
			bandage = 3,
			honey = 3,
		},
	},

	["slot_warrior1"] =
	{
		loot =
		{
			wathgrithrhat = 1,
			armorwood = 1,
			spear_wathgrithr = 1,
		},
	},

	["slot_warrior2"] =
	{
		loot =
		{
			armormarble = 1,
			hambat = 1,
			blowdart_pipe = 3,
            blueprint_hambat = 1,
		},
	},

	["slot_warrior3"] =
	{
		loot =
		{
			armorwood = 3,
			tenaclespike = 1,
			--boomerang = 1,
		},
	},

	["slot_warrior4"] =
	{
		loot =
		{
			spear_launcher = 1,
			spear_wathgrithr = 1,
			armorseashell = 1,
			coconade= 1,
		},
	},
	["slot_warrior5"] =
	{
		loot =
		{
			nightsword = 1,
			armor_sanity = 2,
			--armorseashell = 1,
			--coconade= 1,
		},
	},
	["slot_glasscutter"] =
	{
		loot =
		{
			glasscutter = 1,
			goldnugget = 2,
			--coconade= 1,
		},
	},
	["slot_warrior6"] =
	{
		loot =
		{
			slurtlehat = 1,
			armorsnurtleshell = 1,
			--armorseashell = 1,
			--coconade= 1,
		},
	},

	["slot_scientist"] =
	{
		loot =
		{
			goldnugget = 3,
			--heatrock = 1,
			gunpowder= 3,
		},
	},

	["slot_walker"] =
	{
		loot =
		{
			cane = 1,
			dubloon= 3,
		},
	},

	["slot_gemmy"] =
	{
		loot =
		{
			icestaff = 3,
			firestaff = 3,
		},
	},

	["slot_bestgem"] =
	{
		loot =
		{
			goldnugget = 3,
		},
	},

	["slot_lifegiver"] =
	{
		loot =
		{
			amulet = 1,
			goldnugget = 2,
		},
	},

	["slot_chilledamulet"] =
	{
		loot =
		{
			blueamulet = 1,
			goldnugget = 2,
		},
	},

	["slot_icestaff"] =
	{
		loot =
		{
			icestaff = 1,
			goldnugget = 2,
		},
	},

	["slot_firestaff"] =
	{
		loot =
		{
			firestaff = 1,
			goldnugget = 2,
		},
	},

	["slot_coolasice"] =
	{
		loot =
		{
			reskin_tool = 1,
			nightmarefuel = 5,
			--palmleaf_umbrella = 1,
		},
	},

	["slot_gunpowder"] =
	{
		loot =
		{
			gunpowder = 5,
		},
	},

	["slot_darty"] =
	{
		loot =
		{
			blowdart_pipe = 1,
			blowdart_sleep = 1,
			blowdart_fire = 1,
		},
	},

	["slot_firedart"] =
	{
		loot =
		{
			blowdart_fire = 3,
			goldnugget = 1,
		},
	},

	["slot_sleepdart"] =
	{
		loot =
		{
			blowdart_sleep = 3,
			goldnugget = 1,
		},
	},

	["slot_blowdart"] =
	{
		loot =
		{
			blowdart_pipe = 6,
			--goldnugget = 3,
		},
	},

	["slot_speargun"] =
	{
		loot =
		{
			spear_launcher = 1,
			spear = 1,
			goldnugget = 1,
		},
	},


	["slot_dapper"] =
	{
		loot =
		{
			cane = 1,
			dubloon = 3,
			walrushat = 1,
		},
	},

	["slot_speed"] =
	{
		loot =
		{
			yellowamulet = 1,
			nightmarefuel = 3,
			dubloon = 3,
		},
	},

	["slot_coconades"] =
	{
		loot =
		{
			coconade= 5,
			torch = 1,
		},
	},

	["slot_obsidian"] =
	{
		loot =
		{
			armorobsidian= 1,
            spear_obsidian = 1,
		},
	},

	["slot_thuleciteclub"] =
	{
		loot =
		{
			ruins_bat= 1,
			goldnugget = 3,
		},
	},

	["slot_thulecitesuit"] =
	{
		loot =
		{
			armorruins= 1,
			goldnugget = 3,
		},
	},

	["slot_ultimatewarrior"] =
	{
		loot =
		{
			armorruins= 1,
			ruins_bat= 1,
			ruinshat= 1,
		},
	},

	["slot_goldenaxe"] =
	{
		loot =
		{
			goldenaxe = 1,
			goldnugget = 3,
		},
	},

	["slot_monkeyball"] =
	{
		loot =
		{
			monkeyball = 1,
			cave_banana = 2,
		},
	},


---------------------------------------OK LIST

	["firestarter"] =
	{
		loot =
		{
			Wildbore = 2,
			-- twigs = 1,
			--cutgrass = 3,
		},
	},

	["slot_pigman_royalguard"] =
	{
		loot = {
			pigman_royalguard = 2,
			pigman_royalguard_2 = 1,
			pigman_royalguard_3 =1,
		},
	},

	["slot_pig_royalguard_rich"] =
	{
		loot = {
			pig_royalguard_rich = 2,
			pig_royalguard_rich_2 = 1,
		},
	},

	["geologist"] =
	{
		loot =
		{
			beefalo = 1,
			babybeefalo = 1,
			--obsidian = 1,
		},
	},

	["3cutgrass"] =
	{
		loot =
		{
			crab = 3,
		},
	},

	["3logs"] =
	{
		loot =
		{
			rabbit = 3,
		},
	},

	["3twigs"] =
	{
		loot =
		{
			lightninggoat = 2,
		},
	},

	["slot_torched"] =
	{
		loot =
		{
			torch = 1,
			charcoal = 2,
			ash = 2,
		},
	},

	["slot_jelly"] =
	{
		loot =
		{
			jellyfish_dead = 3,
		},
	},

	["slot_handyman"] =
	{
		loot =
		{
			spear = 1,
			armorgrass = 1,
			torch = 1,
		},
	},

	["slot_poop"] =
	{
		loot =
		{
			poop = 5,
		},
	},

	["slot_berry"] =
	{
		loot =
		{
			berries = 5,
		},
	},

	["slot_limpets"] =
	{
		loot =
		{
			limpets = 5,
		},
	},

	["slot_seafoodsurprise"] =
	{
		loot =
		{
			honey = 2,
			jellybean = 1,
			--fishmeat = 1,
		},
	},

	["slot_bushy"] =
	{
		loot =
		{
			berries = 3,
			jammypreserves = 1, --cut down from 3
		},
	},


	["slot_bamboozled"] =
	{
		loot =
		{
			--dug_bambootree = 1,
			batwing_cooked = 3,
		},
	},

	["slot_grassy"] =
	{
		loot =
		{
			trap = 1,
			armorwood = 1,
			--strawhat = 1,
		},
	},

	["slot_prettyflowers"] =
	{
		loot =
		{
			armor_seashell = 1,
			--flowerhat = 1,
		},
	},

	["slot_witchcraft"] =
	{
		loot =
		{
			--doydoy = 5,
			red_cap= 1,
			green_cap = 1,
			blue_cap = 1,
		},
	},

	["slot_bugexpert"] =
	{
		loot =
		{
			lantern = 1,
			--fireflies = 3,
			lightbulb = 5,
		},
	},

	["slot_flinty"] =
	{
		loot =
		{
			smallbird = 2,
		},
	},

	["slot_fibre"] =
	{
		loot =
		{
			catcoon = 2,
			--dragonfruit = 1,
			--watermelon = 1,
		},
	},

	["slot_drumstick"] =
	{
		loot =
		{
			drumstick = 3,
		},
	},

	["slot_fisherman"] =
	{
		loot =
		{
			mermfisher = 1,
			fishmeat = 3,
			fish_tropical = 3,
		},
	},

    ["slot_bonesharded"] =
	{
		loot =
		{
			hammer = 1,
			skeleton = 3,
		},
	},

    ["slot_jerky"] =
	{
		loot =
		{
			meat_dried = 3,
		},
	},

    ["slot_coconutty"] =
	{
		loot =
		{
            machete = 1,
			coconut = 5,
		},
	},

	["slot_camper"] =
	{
		loot =
		{
			--heatrock = 1,
			bedroll_straw = 1,
			meat_dried = 3,
		},
	},

    ["slot_ropey"] =
	{
		loot =
		{
			fruitdragon = 2,
		},
	},

  	["slot_tailor"] =
	{
		loot =
		{
			--sewing_kit = 1,
			goldnugget= 3,
			brainjellyhat = 1,
		},
	},

	["slot_spiderboon"] =
	{
		loot =
		{
			sleepbomb = 2,
			--silk = 5,
			blue_cap = 3,
		},
	},


	["slot_cookpot"] =
	{
		loot =
		{
			cookpot = 1,
			cookpot_blueprint = 5,
			hammer = 1,
		},
	},
	["slot_health"] =
	{
		loot =
		{
			healingsalve = 3,
			--silk = 5,
			--hammer = 1,
		},
	},
	["slot_thunderbird"] =
	{
		loot =
		{
			thunderbird = 2,
			--silk = 5,
			--hammer = 1,
		},
	},
	["slot_dungbeetle"] =
	{
		loot =
		{
			dungbeetle = 2,
			--silk = 5,
			--hammer = 1,
		},
	},
	["slot_koalefant_summer"] =
	{
		loot =
		{
			koalefant_summer = 1,
			--silk = 5,
			--hammer = 1,
		},
	},
	["slot_doydoy"] =
	{
		loot =
		{
			doydoy = 2,
		},
	},
	["slot_nightstick"] =
	{
		loot =
		{
			nightstick = 1,
		},
	},
	["slot_armor_bramble"] =
	{
		loot =
		{
			armor_bramble = 1,
			cookiecutterhat = 1,
		},
	},
	["slot_armorwood"] =
	{
		loot =
		{
			armorwood = 1,
			footballhat = 1,
		},
	},
	["slot_footballhat"] =
	{
		loot =
		{
			wathgrithrhat = 1,
			whip = 1,
		},
	},




--------------------------------------BAD LIST

	["slot_spiderattack"] =
	{
		loot =
		{
			spider = math.random(3,4),
		},
	},

	["slot_mosquitoattack"] =
	{
		loot =
		{
			spider_warrior= 2,
		},
	},

	["slot_ox"] =
	{
		loot =
		{
			ox= 2,
		},
	},

    ["slot_pog"] =
	{
		loot =
		{
			pog = math.random(3,4),
		},
	},

  	["slot_snakeattack"] =
	{
		loot =
		{
			snake = math.random(3,4),
		},
	},

	  	["slot_monkeysurprise"] =
	{
		loot =
		{
			wasphive = 2,
		},
	},

		["slot_poisonsnakes"] =
	{
		loot =
		{
			snake_poison = 2,
		},
	},

		["slot_hounds"] =
	{
		loot =
		{
			crocodog = 3,
		},
	},

	["slot_flup"] =
	{
		loot =
		{
			flup = 4,
		},
	},

	["slot_spiderqueen"] =
	{
		loot =
		{
			spiderqueen = 1,
            spider = 2,
		},
	},
        ["slot_bishop"] =
	{
		loot =
		{
			bishop = 1,
            --spider = 2,
		},
	},
            ["slot_knight"] =
	{
		loot =
		{
			knight = 1,
            --spider = 2,
		},
	},
            ["slot_rook"] =
	{
		loot =
		{
			rook = 1,
            --spider = 2,
		},
	},
    ["slot_tentacle"] =
	{
		loot =
		{
			tentacle = 3,
            --rook = 1,
            --knight = 1,
		},
	},
    ["slot_bat"] =
	{
		loot =
		{
			bat = math.random(4,5),
            --rook = 1,
            --knight = 1,
		},
	},
	["slot_vbat"] =
	{
		loot =
		{
			vampirebat = math.random(2,3),
            --rook = 1,
            --knight = 1,
		},
	},
    ["slot_slurper"] =
	{
		loot =
		{
			slurper = 2,
            --rook = 1,
            --knight = 1,
		},
	},
    ["slot_tallbird"] =
	{
		loot =
		{
			tallbird = 2,
            --rook = 1,
            --knight = 1,
		},
	},
    ["slot_merm"] =
	{
		loot =
		{
			merm = 2,
            --rook = 1,
            --knight = 1,
		},
	},
    ["slot_ghost"] =
	{
		loot =
		{
			ghost = 2,
            --rook = 1,
            --knight = 1,
		},
	},
    ["slot_frog"] =
	{
		loot =
		{
			frog = 3,
            --rook = 1,
            --knight = 1,
		},
	},
    ["slot_leif_palm"] =
	{
		loot =
		{
			leif_palm = 2,
            --rook = 1,
            --knight = 1,
		},
	},
	["slot_leif_jungle"] =
	{
		loot =
		{
			leif_jungle = 2,
            --rook = 1,
            --knight = 1,
		},
	},

    ["slot_dragoon"] =
	{
		loot =
		{
			dragoon = 3,
            --rook = 1,
            --knight = 1,
		},
	},
    ["slot_mean_flytrap"] =
	{
		loot =
		{
			mean_flytrap = 4,
            --rook = 1,
            --knight = 1,
		},
	},
            ["slot_spider_monkey"] =
	{
		loot =
		{
			spider_monkey = 2,
            --rook = 1,
            --knight = 1,
		},
	},


}

local newtreasures=
{
	["moonworker"] =
	{
		loot =
		{
			glasscutter = 1,
			moonglassaxe = 1,
			moonrocknugget = math.random(6,12),
			moonglass= math.random(6,12),
			greengem = 1,
		},
	},

	["moongardener"] =
	{
		loot =
		{
			dug_rock_avocado_bush = math.random(3,6),
			dug_sapling_moon = math.random(3,6),
			premiumwateringcan = 1,
			moonbutterfly = math.random(3,6),
			compostwrap = math.random(2,4),
			greengem = 1,
		},
	},

	["moonrockseed"] =
	{
		loot =
		{
			houndcorpse = 2,
			moonrockseed = 1,
			moonrocknugget = 12,
			greengem = 1,
			dug_rock_avocado_bush = math.random(4,8),
		},
	},

	["terrarium"] =
	{
		chest = "terrariumchest",
		loot =
		{
			terrarium = 1,
			eyeofterror_mini = 2,
			goldnugget = math.random(4,6),
			moonrocknugget = 12,
			healingsalve = math.random(4,6),
			marble = math.random(5,8),
			rope = math.random(5,9),
			log = math.random(15,20),
		},
	},

}

local TreasureList = {}
local TreasureLootList = {}

function AddTreasure(name, data)
	TreasureList[name] = data
end

function AddTreasureLoot(name, data)
	TreasureLootList[name] = data
end

for name, data in pairs(internaltreasure) do
	AddTreasure(name, data)
end

for name, data in pairs(internalloot) do
	AddTreasureLoot(name, data)
end

if IA_CONFIG.newloot == "part" then
	newtreasures["terrarium"] = nil
	newtreasures["moonrockseed"] = nil
elseif IA_CONFIG.newloot == "vanilla" then
	newtreasures = {}
	internalloot["BootyInDaBooty"].loot = {
		dubloon = 5,
		piratepack = 1,
	}
	internalloot["OneTrueEarring"].loot = {
		earring = 1,
	}
	internalloot["JewelThief"].loot = {
		dubloon = 5,
		goldnugget = 6,
		purplegem = 2,
		redgem = 4,
		bluegem = 3,
	}
	internalloot["AntiqueWarrior"].loot = {
		dubloon = 5,
		ruins_bat = 1,
		ruinshat = 1,
		armorruins = 1,
		bluegem = 2,
	}
	internalloot["Diviner"].loot = {
		dubloon = 5,
		nightmarefuel = 4,
		gears = 1,
		twigs = 1,
	}
	internalloot["minerhat"].loot = {
		minerhat = 1,
		dubloon = 5,
		obsidianaxe = 1,
	}
	internalloot["Scientist"].loot = {
		dubloon = 3,
		transistor = 1,
		gunpowder = 3,
		heatrock = 1,
	}
end

for _, v in pairs(internaltreasure) do
	for name, data in pairs(internalloot) do
		if v[1].loot == name then
			newtreasures[name] = data
		end
	end
end

local function GetTierLootTable(tier)
	-- TODO: yank it out!
	print("GetTierLootTable", tier, #Tiers[tier])
	return table.remove(Tiers[tier], math.random(1, #Tiers[tier]))
end

function GetTreasureDefinitionTable()
	return TreasureList
end

function GetTreasureDefinition(name)
	return TreasureList[name]
end

function GetTreasureLootDefinitionTable()
	return TreasureLootList
end

function GetTreasureLootDefinition(name)
	return TreasureLootList[name]
end

function GetNewTreasures()
	return newtreasures
end

function GetNewTreasuresDefinition(name)
	return newtreasures[name]
end

function ApplyModsToTreasure()
	for name, data in pairs(TreasureList) do
		local modfns = ModManager:GetPostInitFns("TreasurePreInit", name)
		for i,modfn in ipairs(modfns) do
			print("Applying mod to treasure ", name)
			modfn(data)
		end
	end
end

function ApplyModsToTreasureLoot()
	for name, data in pairs(TreasureLootList) do
		local modfns = ModManager:GetPostInitFns("TreasureLootPreInit", name)
		for i,modfn in ipairs(modfns) do
			print("Applying mod to treasure loot ", name)
			modfn(data)
		end
	end
end

local function GetTreasureLoot(loots)
	local lootlist = {}
	if loots then
		if loots.loot then
			for prefab, n in pairs(loots.loot) do
				if lootlist[prefab] == nil then
					lootlist[prefab] = 0
				end
				lootlist[prefab] = lootlist[prefab] + n
			end
		end
		if loots.random_loot then
			for i = 1, (loots.num_random_loot or 1), 1 do
				local prefab = weighted_random_choice(loots.random_loot)
				if prefab then
					if lootlist[prefab] == nil then
						lootlist[prefab] = 0
					end
					lootlist[prefab] = lootlist[prefab] + 1
				end
			end
		end
		if loots.chance_loot then
			for prefab, chance in pairs(loots.chance_loot) do
				if math.random() < chance then
					if lootlist[prefab] == nil then
						lootlist[prefab] = 0
					end
					lootlist[prefab] = lootlist[prefab] + 1
				end
			end
		end
		if loots.custom_lootfn then
			loots.custom_lootfn(lootlist)
		end
	end
	return lootlist
end

function GetTreasureLootList(name)
	return GetTreasureLoot(GetTreasureLootDefinition(name))
end

function SpawnTreasureLoot(name, lootdropper, pt, nexttreasure)
	if name and lootdropper ~= nil then
		if not pt then
			pt = Point(lootdropper.inst.Transform:GetWorldPosition())
		end

		if nexttreasure and nexttreasure ~= nil then
			--Spawn a bottle to the next treasure
			local bottle = inst.components.lootdropper:SpawnLootPrefab("ia_messagebottle")
			bottle.treasure = nexttreasure
			--bottle:OnDrop() Handled by lootdropper/inventoryitem  now
		end

		local player = TheLocalPlayer --TODO, for when we implement treasure hunting
		local loots = GetTreasureLootDefinition(name)
		local lootprefabs = GetTreasureLoot(loots)
		for p, n in pairs(lootprefabs) do
			for i = 1, n, 1 do
				local loot = lootdropper:SpawnLootPrefab(p, pt)
				assert(loot, "can't spawn "..tostring(p))
				if not loot.components.inventoryitem then
					-- attacker?
					if loot.components.combat then
						loot.components.combat:SuggestTarget(player)
					end
				end
			end
		end
	end
end

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("closed", false)
        if inst.components.container ~= nil then
            inst.components.container:DropEverything()
            inst.components.container:Close()
        end
    end
end

function SpawnTreasureChest(name, lootdropper, pt, nexttreasure)
	local loots = GetNewTreasuresDefinition(name) or GetTreasureLootDefinition(name)
	if loots then
		local chest = SpawnPrefab(loots.chest or "treasurechest")
		if chest then
			if not pt then
				pt = Point(lootdropper.inst.Transform:GetWorldPosition())
			end

			chest.Transform:SetPosition(pt.x, pt.y, pt.z)
			SpawnPrefab("collapse_small").Transform:SetPosition(pt.x, pt.y, pt.z)

			if chest.components.container then
				if nexttreasure and nexttreasure ~= nil then
					--Spawn a bottle to the next treasure
					local bottle = SpawnPrefab("ia_messagebottle")
					bottle.treasure = nexttreasure
					chest.components.container:GiveItem(bottle, nil, nil, true, false)
				end

				local player = TheLocalPlayer
				local lootprefabs = GetTreasureLoot(loots)
				for p, n in pairs(lootprefabs) do
					for i = 1, n, 1 do
						local loot = SpawnPrefab(p)
						if loot then
							if loot.components.inventoryitem and not loot.components.container then
								if chest and loot.components.visualvariant then
									loot.components.visualvariant:CopyOf(chest, true)
								end
								chest.components.container:GiveItem(loot, nil, nil, true, false)
							else
								local pos = Vector3(pt.x, pt.y, pt.z)
								local start_angle = math.random()*PI*2
								local rad = 1
								if chest.Physics then
									rad = rad + chest.Physics:GetRadius()
								end
								local offset = FindWalkableOffset(pos, start_angle, rad, 8, false)
								if offset == nil then
									return
								end

								pos = pos + offset

								loot.Transform:SetPosition(pos.x, pos.y, pos.z)
								-- attacker?
								if loot.components.combat then
									loot.components.combat:SuggestTarget(player)
								end
							end
						end
					end
				end
			end
			if not chest.components.workable then
				chest:AddComponent("workable")
				chest.components.workable:SetWorkAction(ACTIONS.HAMMER)
				chest.components.workable:SetWorkLeft(2)
				chest.components.workable:SetOnFinishCallback(onhammered)
				chest.components.workable:SetOnWorkCallback(onhit)
				if not chest.components.lootdropper then
					chest:AddComponent("lootdropper")
				end
			end
		end
	end
end

-- IAENV.modimport("main/spawnutil")

function WorldGenPlaceTreasures(tasks, entitiesOut, width, height, min_id, level)
	print("WorldGenPlaceTreasures called!", tasks, entitiesOut, width, height, min_id)

	local obj_layout = require("map/object_layout")

	local function AllStagesPlaced(treasure, stageCount)
		local ret = true
		for i = 1, stageCount, 1 do
			if treasure.stages[i] == nil then
				print("Not all stages placed, missing ", i)
				ret = false
			end
		end
		return ret
	end

	local function GetRandomNode(task, layout, restrict_to)
		local is_entrance = function(room)
			-- return true if the room is an entrance
			--print("is_entrance", tostring(room.data.entrance))
			return room.data.entrance ~= nil and room.data.entrance == true
		end
		local is_background_ok = function(room, restrict_to)
			-- return true if the piece is not backround restricted, or if it is but we are on a background
			--print("is_background_ok", tostring(restrict_to), tostring(room.data.type))
			return restrict_to ~= "background" or room.data.type == "background"
		end
		local is_water_ok = function(room, layout)
			local water_room = room.data.type == "water" or IsWater(room.data.value)
			local water_layout = layout and layout.water == true
			--print("is_water_ok", tostring(water_room), tostring(water_layout))
			return (water_room and water_layout) or (not water_room and not water_layout)
		end
		local isnt_blank = function(room)
			--print("isnt_blank", tostring(room.data.type))
			return room.data.type ~= "blank"
		end

		local choicekeys = shuffledKeys(task.nodes)
		for i, choicekey in ipairs(choicekeys) do
			local node = task.nodes[choicekey]
			if node.data.value ~= GROUND.IMPASSABLE and not is_entrance(node) and is_background_ok(node, restrict_to) and isnt_blank(node) and is_water_ok(node, layout) then
				return node
			end
		end
	end

	local function GetRandomTaskNode(tasks, layout, restrict_to)
		local taskkeys = shuffledKeys(tasks)
		local node = nil
		local j = 1
		while j < #taskkeys and node == nil do
			node = GetRandomNode(tasks[taskkeys[j]], layout, restrict_to)
			j = j + 1
		end

		return node
	end

	local function GetRandomTaskNodeFromList(tasks, layout, choicetasks)
		if choicetasks then
			local choices = shuffleArray(choicetasks)
			for i, task in ipairs(choices) do
				if tasks[task] then
					local node = GetRandomNode(tasks[task], layout)
					if node then
						return node
					end
				end
			end
		end
		return GetRandomTaskNode(tasks, layout)
	end

	local function GetSetpiecePosition(nodeid, layout, prefabs)
		print("GetPointsForSite", nodeid)
		local layoutsize = math.max(GetLayoutRadius(layout, prefabs), 1)
		local points_x, points_y, points_type = WorldSim:GetPointsForSite(nodeid)
		if layout.water and layout.water == true then
			for i = 1, #points_x, 1 do
				if IsSurroundedByWater(points_x[i], points_y[i], layoutsize) then
					return points_x[i], points_y[i]
				end
			end
		else
			for i = 1, #points_x, 1 do
				if not IsCloseToWater(points_x[i], points_y[i], layoutsize) then
					return points_x[i], points_y[i]
				end
			end
		end
		return nil, nil
	end

	local function GetPrefabPosition(nodeid, radius)
		print("GetPointsForSite", nodeid)
		local points_x, points_y, points_type = WorldSim:GetPointsForSite(nodeid)
		for i = 1, #points_x, 1 do
			if not IsCloseToWater(points_x[i], points_y[i], radius) then
				return points_x[i], points_y[i]
			end
		end
	end

	local function VerifyTreasure(level)
		for name, _ in pairs(self.treasures) do
			local def = GetTreasureDefinition(name)
			assert(def ~= nil, "Treasure: '"..name.."' does not exist!, Check treasures in shipwrecked.lua")
		end
		for i = 1, #self.optional_treasures, 1 do
			local def = GetTreasureDefinition(self.optional_treasures[i])
			assert(def ~= nil, "Treasure: '"..self.optional_treasures[i].."' does not exist!, Check optional_treasures in shipwrecked.lua")
		end
		for i = 1, #self.random_treasures, 1 do
			local def = GetTreasureDefinition(self.random_treasures[i])
			assert(def ~= nil, "Treasure: '"..self.random_treasures[i].."' does not exist!, Check random_treasures in shipwrecked.lua")
		end
		for i = 1, #self.required_treasures, 1 do
			local def = GetTreasureDefinition(self.required_treasures[i])
			assert(def ~= nil, "Treasure: '"..self.required_treasures[i].."' does not exist!, Check required_treasures in shipwrecked.lua")
		end
	end

	local treasureid = 2400
	local function AddTreasureToList(treasure_list, name, treasuretasks, maptasks, nodeid)
		--print("Add treasure", name, treasureid, nodeid)
		treasure_list[treasureid] = {}
		treasure_list[treasureid].name = name
		treasure_list[treasureid].treasuretasks = treasuretasks
		treasure_list[treasureid].maptasks = maptasks
		treasure_list[treasureid].stages = {}

		local treasuredef = GetTreasureDefinition(name)
		for i, stagedef in ipairs(treasuredef) do
			treasure_list[treasureid].stages[i] = {}
		end

		if nodeid then
			treasure_list[treasureid].stages[1].nodeid = nodeid
		end

		treasureid = treasureid + 1
	end

	local function BuildTreasureListFromTasks(treasure_list, tasks)
		for taskid, task in pairs(tasks) do
			local nodes = task:GetNodes(true)
			for nodeid, node in pairs(nodes) do
				if node.data.terrain_contents then
					if node.data.terrain_contents.treasure_data ~= nil then
						for id, treasure_data in pairs(node.data.terrain_contents.treasure_data) do
							if treasure_list[id] == nil then
								--print("Add treasure", treasure_data.name, id)
								treasure_list[id] = {}
								treasure_list[id].name = treasure_data.name
								treasure_list[id].stages = {}
							end
							assert(treasure_list[id].name == treasure_data.name)
							treasure_list[id].stages[treasure_data.stage] = {nodeid = node.id}
						end
					end
					if node.data.terrain_contents.treasures ~= nil then
						for i, treasure_data in ipairs(node.data.terrain_contents.treasures) do
							AddTreasureToList(treasure_list, treasure_data.name, nil, nil, node.id)
						end
					end
				end
			end
		end
	end

	local function BuildTreasureListFromLevel(treasure_list, tasks, level)
		if level.treasures then
			for name, data in pairs(level.treasures) do
				for i = 1, data.count or 1, 1 do
					AddTreasureToList(treasure_list, name, data.treasuretasks, data.maptasks)
				end
			end
		end

		if level.optional_treasures and level.numoptional_treasures and level.numoptional_treasures > 0 then
			local choicekeys = shuffledKeys(level.optional_treasures)
			for i = 1, level.numoptional_treasures, 1 do
				AddTreasureToList(treasure_list, level.optional_treasures[choicekeys[i]])
			end
		end

		if level.random_treasures and level.numrandom_treasures and level.numrandom_treasures > 0 then
			for i = 1, level.numrandom_treasures, 1 do
				AddTreasureToList(treasure_list, level.random_treasures[math.random(1, #level.random_treasures)])
			end
		end
	end

	print("Building treasure defs...")
	local treasure_list = {}
	local treasure_prefabs = {}
	local map_prefabs = {}
	local prefab_list = {}
	local add_fn = {
		fn=function(prefab, points_x, points_y, idx, entitiesOut, width, height, prefab_list, prefab_data, rand_offset)
			AddEntity(prefab, points_x[idx], points_y[idx], entitiesOut, width, height, prefab_list, prefab_data, rand_offset)
		end,
		args={entitiesOut=entitiesOut, width=width, height=height, rand_offset = true, debug_prefab_list=prefab_list}
	}

	BuildTreasureListFromTasks(treasure_list, tasks)
	BuildTreasureListFromLevel(treasure_list, tasks, level)

	ApplyModsToTreasure()

	local function PlaceTreasure(treasureid, treasure)
		--print("Placing ", treasureid, treasure.name)
		local treasuredef = GetTreasureDefinition(treasure.name)
		if treasuredef and AllStagesPlaced(treasure, #treasuredef) then
			local first_stage = math.huge
			for stageid, stage in pairs(treasure.stages) do
				local stagedef = treasuredef[stageid]

				if stageid < first_stage then
					first_stage = stageid
				end

				-- random tier stuff
				if stagedef.tier then
					stagedef = GetTierLootTable(stagedef.tier)
				end

				if stagedef.treasure_set_piece then
					--print("Treasure set piece ", stagedef.treasure_set_piece)
					local layout = obj_layout.LayoutForDefinition(stagedef.treasure_set_piece)
					local prefabs = obj_layout.ConvertLayoutToEntitylist(layout)

					for i,p in ipairs(prefabs) do
						if p.prefab == stagedef.treasure_prefab then
							--print("Treasure prefab", p.prefab, stagedef.treasure_prefab)
							if p.properties == nil then
								p.properties = {}
							end
							p.properties.id=min_id
							p.properties.data={treasureid=treasureid, stage=stageid, loot=stagedef.loot}
							min_id = min_id + 1

							stage.prefab = p
							break
						end
					end

					if stage.nodeid == nil then
						stage.nodeid = GetRandomTaskNodeFromList(tasks, layout, treasure.treasuretasks).id
					end

					--local lx, ly = GetSetpiecePosition(stage.nodeid, layout, prefabs)
					--obj_layout.ReserveAndPlaceLayout("POSITIONED", layout, prefabs, add_fn, {lx, ly})
					obj_layout.ReserveAndPlaceLayout(stage.nodeid, layout, prefabs, add_fn)
				else
					local treasure_prefab = stagedef.treasure_prefab or "buriedtreasure"
					--print("Treasure prefab ", treasure_prefab)
					local properties = {}
					properties.id = min_id
					properties.data={treasureid=treasureid, stage=stageid, loot=stagedef.loot}
					min_id = min_id + 1

					stage.prefab = {}
					stage.prefab.properties = properties

					if stage.nodeid == nil then
						stage.nodeid = GetRandomTaskNodeFromList(tasks, nil, treasure.treasuretasks).id
					end

					local px, py = GetPrefabPosition(stage.nodeid, 1)
					add_fn.fn(treasure_prefab, {px}, {py}, 1, add_fn.args.entitiesOut, add_fn.args.width, add_fn.args.height, add_fn.args.debug_prefab_list, properties, false)
				end
			end

			--add a map
			local first_stagedef = treasuredef[first_stage]
			if first_stagedef.map_set_piece then
				--print("Map set piece ", first_stagedef.map_set_piece)
				local layout = obj_layout.LayoutForDefinition(first_stagedef.map_set_piece)
				local prefabs = obj_layout.ConvertLayoutToEntitylist(layout)

				for i,p in ipairs(prefabs) do
					if p.prefab == first_stagedef.map_prefab then
						--print("Map prefab ", p.prefab, treasure.stages[first_stage].prefab.properties.id)
						if p.properties == nil then
							p.properties = {}
						end

						p.properties.data={treasure = treasure.stages[first_stage].prefab.properties.id, name=treasure.name}
						break
					end
				end

				if layout and layout.water then
					local checkFn = function(ground) return IsWater(ground) end
					PlaceWaterLayout(layout, prefabs, add_fn, checkFn)
				else
					local node = GetRandomTaskNodeFromList(tasks, layout, treasure.maptasks)
					if node and node.id then
						--local lx, ly = GetSetpiecePosition(node.id, layout, prefabs)
						--obj_layout.ReserveAndPlaceLayout("POSITIONED", layout, prefabs, add_fn, {lx, ly})
						obj_layout.ReserveAndPlaceLayout(node.id, layout, prefabs, add_fn)
					else
						print("Error couldn't find a node for ", first_stagedef.map_set_piece)
					end
				end
			else
				local map_prefab = first_stagedef.map_prefab or "ia_messagebottle"
				--print("Map prefab ", map_prefab, treasure.stages[first_stage].prefab.properties.id)
				map_prefabs[treasureid] = {}
				map_prefabs[treasureid].prefab = map_prefab
				map_prefabs[treasureid].properties = {data={treasure = treasure.stages[first_stage].prefab.properties.id, name=treasure.name}}
			end

			--print("Linking treasure ", treasureid)
			for stageid, stage in pairs(treasure.stages) do
				local p = stage.prefab
				assert(p, "Can't link treasures treasureid: "..tostring(treasureid)..", stageid: "..tostring(stageid))
				assert(p.properties.data.treasureid == treasureid, "Treasure ids don't match! "..tostring(p.properties.data.treasureid)..", "..tostring(treasureid))
				--print(string.format("treasureid %d, stage %d, loot %s", p.properties.data.treasureid, p.properties.data.stage, p.properties.data.loot))

				if treasure.stages[stageid - 1] then
					local prevp = treasure.stages[stageid - 1].prefab
					--print(string.format("Connect prev %d -> %d", prevp.properties.id, p.properties.id))
					p.properties.data.treasureprev = prevp.properties.id
				end
				if treasure.stages[stageid + 1] then
					local nextp = treasure.stages[stageid + 1].prefab
					--print(string.format("Connect next %d -> %d", p.properties.id, nextp.properties.id))
					p.properties.data.treasurenext = nextp.properties.id
				end
			end
		else
			print("Treasure can't be placed ", treasureid, treasure.name)
		end
	end

	print("Placing treasures...")
	for treasureid, treasure in pairs(treasure_list) do
		PlaceTreasure(treasureid, treasure)
	end

	print("Placing maps...")
	local edge_dist = 24
	local map_count = GetTableSize(map_prefabs)
	local points_x, points_y = GetRandomWaterPoints(function(ground) return IsWater(ground) end, width, height, edge_dist, 2 * map_count + 10)
	local cur_pos = 1
	for treasureid, map in pairs(map_prefabs) do
		add_fn.fn(map.prefab, points_x, points_y, cur_pos, add_fn.args.entitiesOut, add_fn.args.width, add_fn.args.height, add_fn.args.debug_prefab_list, map.properties, false)
		cur_pos = cur_pos + 1
	end

	return true
end
