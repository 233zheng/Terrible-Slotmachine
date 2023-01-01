local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local function ShouldResetFight(self)
    -- if not self.inst.reset then
    --     local dx, dy, dz = self.inst.Transform:GetWorldPosition()
    --     local spx, spy, spz = self.inst.components.knownlocations:GetLocation("spawnpoint"):Get()
    --     if distsq(spx, spz, dx, dz) >= (TUNING.DRAGONFLY_RESET_DIST * TUNING.DRAGONFLY_RESET_DIST) or
    --             TheWorld.Map:IsSurroundedByWater(dx, dy, dz, 4) then
    --         self.inst.reset = true
    --         self.inst:Reset()
    --     else
    --         self.resetting = nil
    --     end
    -- end
    -- self.inst.sg.mem.flyover = self.inst.reset
    -- return self.inst.reset
    return false
end

local function ShouldRetryReset(self)
    -- if self.resetting then
    --     local action = self.inst:GetBufferedAction()
    --     return action == nil or action.action ~= ACTIONS.GOHOME
    -- end
    -- self.resetting = true
    return false
end

local function GoHome(inst)
    -- return BufferedAction(inst, nil, ACTIONS.GOHOME)
    return nil
end

local function postinit(self)

    local NoEscape = WhileNode(function() return ShouldResetFight(self) end, "Reset Fight",
        PriorityNode({
            WhileNode(function() return ShouldRetryReset(self) end, "Retry Reset", ActionNode(function() end)),
            -- DoAction(self.inst, GoHome),
        }, .25))

        table.remove(self.bt.root.children, 1)
        table.insert(self.bt.root.children, 1, NoEscape)
end

AddBrainPostInit("dragonflybrain", postinit)
