local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local function postinit(self)

    local NoEscape = WhileNode(function() return end, "Channel",
    PriorityNode{
        -- WhileNode(function() return ShouldTryReturningToHole(self) end, "ReturnToHole",
            -- Leash(self.inst, GetHomePos, 8, 6)),
        -- ActionNode(function()
            -- self.timetochanneling = 0
            -- self.inst:PushEvent("startchanneling")
        -- end),
    }, 1)
    table.remove(self.bt.root.children, 1)
    table.insert(self.bt.root.children, 1, NoEscape)

    local NoGetHomePos = Leash(self.inst, GetHomePos, 30, 25)

    table.remove(self.bt.root.children, 2)
    table.insert(self.bt.root.children, 2, NoGetHomePos)

    local NoFlee = ParallelNode{
        SequenceNode{
            -- WaitNode(FLEE_WARNING_DELAY),
            -- ActionNode(function() self.inst:PushEvent("fleewarning") end),
            -- WaitNode(FLEE_DELAY),
            -- ActionNode(function() self.inst:PushEvent("flee") end),
        },
        -- Wander(self.inst, GetHomePos, 5),
    }

    table.remove(self.bt.root.children, 4)
    table.insert(self.bt.root.children, 4, NoFlee)

end

AddBrainPostInit("toadstoolbrain", postinit)
