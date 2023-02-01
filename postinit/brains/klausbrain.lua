local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local RESET_COMBAT_DELAY = 1

local function postinit(self)

    local fn = ParallelNode{
        SequenceNode{
            WaitNode(RESET_COMBAT_DELAY),
            ActionNode(function()
                self.inst:SetEngaged(false)
            end),
        },
        --Wander(self.inst, GetHomePos, 5),
    }

    table.remove(self.bt.root.children, 4)
    table.insert(self.bt.root.children, 4, fn)

end

AddBrainPostInit("klausbrain", postinit)
