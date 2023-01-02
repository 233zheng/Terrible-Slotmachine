local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local FLEE_DELAY = 15

local function postinit(self)

    local NoEscape = ParallelNode{
            SequenceNode{
                WaitNode(FLEE_DELAY),
                ActionNode(function() end),
            },  --self.inst:PushEvent("flee")
            -- Wander(self.inst, GetHomePos, 5),
        }

	table.remove(self.bt.root.children, 5)
    table.insert(self.bt.root.children, 5, NoEscape)

end

AddBrainPostInit("beequeenbrain", postinit)
