local AddBrainPostInit = AddBrainPostInit
GLOBAL.setfenv(1, GLOBAL)

local MAX_CHANNEL_LEASH_TIME = 15

local function GetHomePos(inst)
    return false
    -- return inst.components.knownlocations:GetLocation("spawnpoint")
end

local function ShouldChannel(self)
    -- if self.inst.components.timer:TimerExists("channel")
    --     or (self.inst.engaged and
    --         self.inst.level < 3 and
    --         not self.inst.components.timer:TimerExists("mushroomsprout_cd")) then
    --     return true
    -- end
    -- self.timetochanneling = nil
    return false
end

local function ShouldTryReturningToHole(self)
    -- if self.timetochanneling == nil then
    --     self.timetochanneling = GetTime() + MAX_CHANNEL_LEASH_TIME
    --     return true
    -- end
    -- return self.timetochanneling > 0 and GetTime() < self.timetochanneling
    return nil
end

local function postinit(self)

    local NoEscape = WhileNode(function() return end, "Channel",
    PriorityNode{
        -- WhileNode(function() return ShouldTryReturningToHole(self) end, "ReturnToHole",
            -- Leash(self.inst, GetHomePos, 8, 6)),
        -- ActionNode(function()
            -- self.timetochanneling = 0
            -- self.inst:PushEvent("startchanneling")
        -- end),
    }, 1)
    table.remove(self.bt.root.children, 1)
    table.insert(self.bt.root.children, 1, NoEscape)

    local NoGetHomePos = Leash(self.inst, GetHomePos, 30, 25)

    table.remove(self.bt.root.children, 2)
    table.insert(self.bt.root.children, 2, NoGetHomePos)

    local NoFlee = ParallelNode{
        SequenceNode{
            -- WaitNode(FLEE_WARNING_DELAY),
            -- ActionNode(function() self.inst:PushEvent("fleewarning") end),
            -- WaitNode(FLEE_DELAY),
            -- ActionNode(function() self.inst:PushEvent("flee") end),
        },
        -- Wander(self.inst, GetHomePos, 5),
    }

    table.remove(self.bt.root.children, 4)
    table.insert(self.bt.root.children, 4, NoFlee)

end

AddBrainPostInit("toadstoolbrain", postinit)
