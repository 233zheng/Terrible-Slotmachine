require "behaviours/wander"
require "behaviours/follow"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/doaction"
--require "behaviours/choptree"
require "behaviours/findlight"
require "behaviours/panic"
require "behaviours/chattynode"
require "behaviours/leash"


local MIN_FOLLOW_DIST = 2
local TARGET_FOLLOW_DIST = 5
local MAX_FOLLOW_DIST = 9
local MAX_WANDER_DIST = 20

local LEASH_RETURN_DIST = 10
local LEASH_MAX_DIST = 30

local GO_HOME_DIST = 10

local START_FACE_DIST = 4
local KEEP_FACE_DIST = 8

local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 30

local TRADE_DIST = 20
local SEE_TREE_DIST = 15
local SEE_FOOD_DIST = 10
local SEE_MONEY_DIST = 6

local KEEP_CHOPPING_DIST = 10

local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 8

local FAR_ENOUGH = 40

local function getSpeechType(inst,speech)
    local line = speech.DEFAULT

    if inst.talkertype and speech[inst.talkertype] then
        line = speech[inst.talkertype]
    end
    return line
end

local function GetTraderFn(inst)
    return FindEntity(inst, TRADE_DIST, function(target) return inst.components.trader:IsTryingToTradeWithMe(target) end, {"player"})
end

local function KeepTraderFn(inst, target)
    return inst.components.trader:IsTryingToTradeWithMe(target)
end


local function KeepChoppingAction(inst)
    local keep_chop = inst.components.follower.leader and inst.components.follower.leader:GetDistanceSqToInst(inst) <= KEEP_CHOPPING_DIST*KEEP_CHOPPING_DIST
    local target = FindEntity(inst, SEE_TREE_DIST/3, function(item)
        return item.prefab == "deciduoustree" and item.monster and item.components.workable and item.components.workable.action == ACTIONS.CHOP
    end)
    if inst.tree_target ~= nil then target = inst.tree_target end

    return (keep_chop or target ~= nil)
end

local function StartChoppingCondition(inst)
    local start_chop = inst.components.follower.leader and inst.components.follower.leader.sg and inst.components.follower.leader.sg:HasStateTag("chopping")
    local target = FindEntity(inst, SEE_TREE_DIST/3, function(item)
        return item.prefab == "deciduoustree" and item.monster and item.components.workable and item.components.workable.action == ACTIONS.CHOP
    end)
    if inst.tree_target ~= nil then target = inst.tree_target end

    return (start_chop or target ~= nil)
end


local function FindTreeToChopAction(inst)
    local target = FindEntity(inst, SEE_TREE_DIST, function(item) return item.components.workable and item.components.workable.action == ACTIONS.CHOP end)
    if target then
        local decid_monst_target = FindEntity(inst, SEE_TREE_DIST/3, function(item)
            return item.prefab == "deciduoustree" and item.monster and item.components.workable and item.components.workable.action == ACTIONS.CHOP
        end)
        if decid_monst_target ~= nil then
            target = decid_monst_target
        end
        if inst.tree_target then
            target = inst.tree_target
            inst.tree_target = nil
        end
        return BufferedAction(inst, target, ACTIONS.CHOP)
    end
end

local function HasValidHome(inst)
    return inst.components.homeseeker and
       inst.components.homeseeker.home and
       not inst.components.homeseeker.home:HasTag("fire") and
       not inst.components.homeseeker.home:HasTag("burnt") and
       inst.components.homeseeker.home:IsValid()
end


local function GuardGoHomeAction(inst)
    local homePos = inst.components.knownlocations:GetLocation("home")
    if homePos and
       not inst.components.combat.target then
        return BufferedAction(inst, nil, ACTIONS.WALKTO, nil, homePos)
    end
end

local function GetLeader(inst)
    return inst.components.follower.leader
end

local function GetHomePos(inst)
    return HasValidHome(inst) and inst.components.homeseeker:GetHomePos()
end

local function GetNoLeaderHomePos(inst)
    if GetLeader(inst) then
        return nil
    end
    return GetHomePos(inst)
end

function getfacespeech(inst)
    local speech = getSpeechType(inst, STRINGS.CITY_PIG_TALK_LOOKATWILSON)
    return speech
end


local RoyalPigGuardBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)


local function shouldPanic(inst)

    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, 20, {"hostile"},{"city_pig"})
    if #ents > 0 then
        return true
    end

    if inst.components.combat.target then
        local threat = inst.components.combat.target
        if threat then
            local myPos = Vector3(inst.Transform:GetWorldPosition() )
            local threatPos = Vector3(threat.Transform:GetWorldPosition() )
            local dist = distsq(threatPos, myPos)
            if dist < FAR_ENOUGH*FAR_ENOUGH then
                if dist > STOP_RUN_AWAY_DIST*STOP_RUN_AWAY_DIST then
                    return true
                end
            else
                inst.components.combat:GiveUp()
            end
        end
    end
    return false
end

local function ShouldGoHome(inst)
    local homePos = inst.components.knownlocations:GetLocation("home")
    local myPos = Vector3(inst.Transform:GetWorldPosition() )
    return (homePos and distsq(homePos, myPos) > GO_HOME_DIST*GO_HOME_DIST )
end

local function ExtinguishfireAction(inst)

    if not inst:HasTag("guard") then
        return false
    end

    -- find fire
    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, FAR_ENOUGH/2, {"campfire"})
    if #ents == 0 then
        return false
    end

    local target = nil
    for i, ent in ipairs(ents) do
        if ent.components.burnable and ent.components.burnable:IsBurning() then
            local pt = inst:GetPosition()

            local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))

            if tiletype == GROUND.SUBURB or tiletype == GROUND.FOUNDATION or tiletype == GROUND.COBBLEROAD or tiletype == GROUND.LAWN or tiletype == GROUND.FIELDS  or tiletype == GROUND.CHECKEREDLAWN then
                target = ent
                break
            end
        end
    end

    if target then
        return BufferedAction(inst, target, ACTIONS.MANUALEXTINGUISH)
    end
end

local function playersproblem(inst)
    if inst.components.combat.target and inst.components.combat.target:HasTag("scary_to_pig_guards") and
        (not inst.components.follower.leader or not inst.components.follower.leader:HasTag("player")) then
        return true
    end
    return false
end

local function GoHomeAction(inst)
    if not inst.components.follower.leader and
        HasValidHome(inst) and
        not inst.components.combat.target then
            return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

function RoyalPigGuardBrain:OnStart()
--   print("RoyalPigGuardBrain:OnStart")

    local day = WhileNode( function() return TheWorld.state.isday end, "IsDay",
        PriorityNode{


            IfNode(function() return StartChoppingCondition(self.inst) end, "chop",
                WhileNode(function() return KeepChoppingAction(self.inst) end, "keep chopping",
                    LoopNode{
                        ChattyNode(self.inst, getSpeechType(self.inst,STRINGS.CITY_PIG_TALK_HELP_CHOP_WOOD),
                            DoAction(self.inst, FindTreeToChopAction ))})),

            Leash(self.inst, GetNoLeaderHomePos, LEASH_MAX_DIST, LEASH_RETURN_DIST),

            IfNode(function() return not self.inst.alerted end, "greet"
                ),

            Wander(self.inst, GetNoLeaderHomePos, MAX_WANDER_DIST)
        },.5)


    local night = WhileNode( function() return not TheWorld.state.isday end, "IsNight",
        PriorityNode{
            IfNode(function() return self.inst:HasTag("guard") end, "panic",Wander(self.inst, GetNoLeaderHomePos, MAX_WANDER_DIST)),
        },1)

    local root =
        PriorityNode(
        {
            WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire",
				ChattyNode(self.inst, getSpeechType(self.inst,STRINGS.CITY_PIG_TALK_PANICFIRE),
					Panic(self.inst))),

            ChattyNode(self.inst, getSpeechType(self.inst,STRINGS.CITY_PIG_TALK_PROTECT),
                WhileNode( function() return (self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown()) and self.inst:HasTag("guard") and not playersproblem(self.inst) end, "AttackMomentarily", -- and inCityLimits(self.inst)
                    ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST) )),

            ChattyNode(self.inst, getSpeechType(self.inst,STRINGS.CITY_PIG_TALK_EXTINGUISH),
                    DoAction(self.inst, ExtinguishfireAction,"extinguish", true )),

            ChattyNode(self.inst, getSpeechType(self.inst,STRINGS.CITY_PIG_TALK_FIGHT),
                WhileNode( function() return self.inst.components.combat.target and self.inst.components.combat:InCooldown() and self.inst:HasTag("guard") end, "Dodge",
                    RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST) )),

            -- FOLLOWER CODE
            ChattyNode(self.inst, getSpeechType(self.inst,STRINGS.CITY_PIG_TALK_FOLLOWWILSON),
                Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST)),
            IfNode(function() return GetLeader(self.inst) end, "has leader",
                ChattyNode(self.inst, getSpeechType(self.inst,STRINGS.CITY_PIG_TALK_FOLLOWWILSON)
                )),

            WhileNode(function() return ShouldGoHome(self.inst) and self.inst:HasTag("guard") end, "ShouldGoHome",
                ChattyNode(self.inst, getSpeechType(self.inst,STRINGS.CITY_PIG_GUARD_TALK_GOHOME),
                    DoAction(self.inst, GuardGoHomeAction, "Go Home", true ) ) ),

            IfNode(function() return (TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.aporkalypse_active == true) end, "gohome",
                ChattyNode(self.inst, getSpeechType(self.inst, STRINGS.CITY_PIG_TALK_GO_HOME),
                    DoAction(self.inst, GoHomeAction, "go home", true ))),

             ChattyNode(self.inst, getSpeechType(self.inst,STRINGS.CITY_PIG_TALK_FLEE),
                WhileNode(function() return shouldPanic(self.inst)  end, "Threat Panic",
                    Panic(self.inst) )),

            RunAway(self.inst, function(guy) return guy:HasTag("pig") and guy.components.combat and guy.components.combat.target == self.inst end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST ),

            ChattyNode(self.inst, getSpeechType(self.inst,STRINGS.CITY_PIG_TALK_ATTEMPT_TRADE),
                FaceEntity(self.inst, GetTraderFn, KeepTraderFn)),
            day,
            night
        }, .5)

    self.bt = BT(self.inst, root)

end

return RoyalPigGuardBrain
