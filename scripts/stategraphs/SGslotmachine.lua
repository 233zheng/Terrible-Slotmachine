require("stategraphs/commonstates")

local actionhandlers = {}

local events = 
{
	-- EventHandler("lightningstrike", function(inst) 
	--     if not inst.EggHatched then
	--         inst.sg:GoToState("crack")
	--     end
	-- end),
}


local states =
{   
	State{
		name = "idle",
		tags = {"idle"},

		onenter = function(inst)
			-- print('fn1')
			inst.AnimState:PlayAnimation("idle")
		end,
	},

	State{
		name = "spinning",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("use", false)
		end,

		timeline = 
		{
			TimeEvent( 0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("ia/common/slotmachine/coinslot") end),
			TimeEvent( 2*FRAMES, function(inst) inst.SoundEmitter:PlaySound("ia/common/slotmachine/leverpull") end),
			TimeEvent(11*FRAMES, function(inst) inst.SoundEmitter:PlaySound("ia/common/slotmachine/jumpup") end),
			TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("ia/common/slotmachine/spin", "slotspin") end),
		},

		events = 
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("prize_"..inst.prizevalue) end),
		}
	},

	State{
		name = "prize_ok",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation(inst.prizevalue, false)
		end,

		timeline = 
		{
			TimeEvent(29*FRAMES, function(inst) inst.SoundEmitter:KillSound("slotspin") end),
			TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds[inst.prizevalue]) end),
		},

		events = {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("done")
			end),
		}
	},

	State{
		name = "prize_good",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation(inst.prizevalue, false)
		end,

		timeline = 
		{
			TimeEvent(32*FRAMES, function(inst) inst.SoundEmitter:KillSound("slotspin") end),
			TimeEvent(33*FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds[inst.prizevalue]) end),
		},

		events = {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("done")
			end),
		}
	},

	State{
		name = "prize_bad",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation(inst.prizevalue, false)
		end,

		timeline = 
		{
			TimeEvent(31*FRAMES, function(inst) inst.SoundEmitter:KillSound("slotspin") end),
			TimeEvent(32*FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds[inst.prizevalue]) end),
		},

		events = {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("done")
			end),
		}
	},
	
	State{
		name = "done",
		tags = {"idle"},
		
		onenter = function(inst)
            --local pos = inst:GetPosition()
            local spawnboss = nil
            if inst.level ~= nil then
                inst.level = inst.level + math.random()*0.4 + 0.6
                if inst.level >= 100 and inst.level < 101 then 
                    spawnboss = SpawnPrefab("dragonfly")
                elseif inst.level >= 200 and inst.level < 201 then
                    spawnboss = SpawnPrefab("beequeen")
                elseif inst.level >= 300 and inst.level < 301 then
                    spawnboss = SpawnPrefab("klaus")
                elseif inst.level >= 400 and inst.level < 401 then
                    spawnboss = SpawnPrefab("toadstool")
				elseif inst.level >= 500 and inst.level < 501 then
					spawnboss = SpawnPrefab("shadowchesses")
				elseif inst.level >= 600 and inst.level < 601 then
                    spawnboss = SpawnPrefab("twinmanager")
				elseif inst.level >= 700 and inst.level < 701 then
                    spawnboss = SpawnPrefab("alterguardian_phase1")
                end
                if spawnboss ~= nil then
                    spawnboss.Transform:SetPosition(inst.Transform:GetWorldPosition())
                    print("bossspawned")
                end
                print("level is not nil"..tostring(inst.level))
            else
                inst.level = 0
                print("startlevel")
                --print(level)
            end
			if inst.DoneSpinning and not spawnboss ~= nil then
				inst:DoneSpinning()
			end
		end,
	},
}
	
return StateGraph("slotmachine", states, events, "idle", actionhandlers)
