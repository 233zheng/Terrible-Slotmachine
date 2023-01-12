local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local function postinit(self)

    table.remove(self.bt.root.children, 1)

    table.remove(self.bt.root.children, 2)

    local Attack = ChaseAndAttack(self.inst)
    table.remove(self.bt.root.children, 3)
    table.insert(self.bt.root.children, 3, Attack)

    table.remove(self.bt.root.children, 4)

end

AddBrainPostInit("klausbrain", postinit)
