local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local function GoHome(inst)
    return nil
end

local function postinit()

    local NoEscape = WhileNode(function() return self.inst.shouldGoAway end, "Go Away"
    -- DoAction(self.inst, GoHome)
    )

	table.remove(self.bt.root.children, 1)
    table.insert(self.bt.root.children, 1, NoEscape)

end

AddBrainPostInit("moosebrain", postinit)
