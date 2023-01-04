local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local RESET_COMBAT_DELAY = 10

local function postinit(self)

    table.remove(self.bt.root.children, 1)

    table.remove(self.bt.root.children, 2)

    table.remove(self.bt.root.children, 4)

end

AddBrainPostInit("klausbrain", postinit)
