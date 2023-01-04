local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local FLEE_DELAY = 15

local function postinit(self)

	table.remove(self.bt.root.children, 5)

end

AddBrainPostInit("beequeenbrain", postinit)
