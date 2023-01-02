local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local RESET_COMBAT_DELAY = 10

local function postinit(self)
                                                                            --ShouldEnrage(self.inst)
    local NoEnrage = WhileNode(function() return  end, "Enrage",
    ActionNode(function() end)) --self.inst:PushEvent("enrage")

    table.remove(self.bt.root.children, 1)
    table.insert(self.bt.root.children, 1, NoEnrage)
                                                                            --ShouldChomp(self.inst)
    local NoChomp = WhileNode(function() return end, "Chomp",
    ActionNode(function() self.inst:PushEvent("chomp") end))

    table.remove(self.bt.root.children, 2)
    table.insert(self.bt.root.children, 2, NoChomp)

    local NoEscape = ParallelNode{
        SequenceNode{
            WaitNode(RESET_COMBAT_DELAY),
            ActionNode(function() end),
        }, -- self.inst:SetEngaged(false)
        --Wander(self.inst, GetHomePos, 5),
    }

    table.remove(self.bt.root.children, 4)
    table.insert(self.bt.root.children, 4, NoEscape)

end

AddBrainPostInit("klausbrain", postinit)
