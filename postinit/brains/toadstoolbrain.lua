local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local function postinit(self)

    table.remove(self.bt.root.children, 1)

    table.remove(self.bt.root.children, 2)

    table.remove(self.bt.root.children, 4)


end

AddBrainPostInit("toadstoolbrain", postinit)
