local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local function postinit(self)
                                                            --  self.inst.shouldGoAway
    local NoEscape = WhileNode(function() return end, "Go Away"
    -- DoAction(self.inst, GoHome)
    )

	table.remove(self.bt.root.children, 1)
    table.insert(self.bt.root.children, 1, NoEscape)

end

AddBrainPostInit("moosebrain", postinit)
