local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local FLEE_WARNING_DELAY = 3.5 --enuf time for combat retarget
local FLEE_DELAY = 10

local function postinit(self)

    -- local leash = Leash(self.inst, nil, 30, 25)

    -- table.remove(self.bt.root.children, 2)
    -- table.insert(self.bt.root.children, 2, leash)

    local fn = ParallelNode{
        SequenceNode{
            WaitNode(FLEE_WARNING_DELAY),
            -- ActionNode(function() self.inst:PushEvent("fleewarning") end),
            WaitNode(FLEE_DELAY),
            -- ActionNode(function() self.inst:PushEvent("flee") end),
        },
        -- Wander(self.inst, GetHomePos, 5),
    }

    table.remove(self.bt.root.children, 4)
    table.insert(self.bt.root.children, 4, fn)

end

AddBrainPostInit("toadstoolbrain", postinit)
