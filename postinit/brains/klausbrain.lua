local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local RESET_COMBAT_DELAY = 10

local function postinit(self)

    local NoEscape = ParallelNode{
        SequenceNode{
            -- WaitNode(RESET_COMBAT_DELAY),
            ActionNode(function() end),
        }, -- self.inst:SetEngaged(false)
        --Wander(self.inst, GetHomePos, 5),
    }

    table.remove(self.bt.root.children, 4)
    table.insert(self.bt.root.children, 4, NoEscape)

end

AddBrainPostInit("klausbrain", postinit)
