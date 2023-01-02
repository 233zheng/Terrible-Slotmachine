local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local function postinit(self)
                                                                        --ShouldResetFight(self)
    local NoEscape = WhileNode(function() return end, "Reset Fight",
        PriorityNode({                          --ShouldRetryReset(self)
            WhileNode(function() return end, "Retry Reset", ActionNode(function() end)),
            -- DoAction(self.inst, GoHome),
        }, .25))

        table.remove(self.bt.root.children, 1)
        table.insert(self.bt.root.children, 1, NoEscape)
end

AddBrainPostInit("dragonflybrain", postinit)
