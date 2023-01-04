local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local function postinit(self)

    table.remove(self.bt.root.children, 3)

end

AddBrainPostInit("tigersharkbrain", postinit)
