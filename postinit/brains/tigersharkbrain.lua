local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local function FindWaterAction(inst)
    -- if inst:HasTag("aquatic") then
        --Don't do anything.
        return nil
    -- end
    -- local wateroffset = FindWaterOffset(inst:GetPosition(), math.random() * 2 * math.pi, 30, 36)
    -- if wateroffset then
    --     return BufferedAction(inst, nil, ACTIONS.WALKTO, nil, inst:GetPosition() + wateroffset)
    -- end
end

local function postinit(self)
--Run home
local NoEscape = WhileNode(function() return self.inst.sharkHome and false end, "Low Health",
            PriorityNode({
                -- DoAction(self.inst, FindWaterAction, "Go To Water"), --Get into water
                Leash(self.inst, function() return end, 81, 80, true),
                --self.inst:FindSharkHome() and self.inst:FindSharkHome():GetPosition()
            }, 0.25))

    table.remove(self.bt.root.children, 3)
    table.insert(self.bt.root.children, 3, NoEscape)

end

AddBrainPostInit("tigersharkbrain", postinit)
