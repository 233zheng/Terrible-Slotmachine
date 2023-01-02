local AddStategraphPostInit = AddStategraphPostInit
GLOBAL.setfenv(1, GLOBAL)

local function postinit(inst)
    local _done_onenter = inst.states["done"].onenter
    inst.states["done"].onenter = function(inst, ...)
        local spawnboss = nil
        local spawnboss2 = nil
        if inst.level ~= nil then
            inst.level = inst.level + math.random()*0.4 + 0.6
            if inst.level >= 1 and inst.level < 2 then
                spawnboss = SpawnPrefab("dragonfly")
            elseif inst.level >= 2 and inst.level < 3 then
                spawnboss = SpawnPrefab("beequeen")
            elseif inst.level >= 3 and inst.level < 4 then
                spawnboss = SpawnPrefab("klaus")
            elseif inst.level >= 3 and inst.level < 5 then
                spawnboss = SpawnPrefab("toadstool")
            elseif inst.level >= 4 and inst.level < 6 then
                spawnboss = SpawnPrefab("shadowchesses")
            elseif inst.level >= 4 and inst.level < 7 then
                spawnboss = SpawnPrefab("twinofterror1")
                spawnboss2 = SpawnPrefab("twinofterror2")
            elseif inst.level >= 5 and inst.level < 8 then
                spawnboss = SpawnPrefab("alterguardian_phase1")
            end
            if spawnboss ~= nil then
                spawnboss.Transform:SetPosition(inst.Transform:GetWorldPosition())
                if spawnboss2 ~= nil then
                    spawnboss2.Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
                print("bossspawned")
            end
            print("level is not nil"..tostring(inst.level))
        else
            inst.level = 0
            print("startlevel")
            print(level)
        end
        if inst.DoneSpinning and not spawnboss ~= nil then
            inst:DoneSpinning()
        end
        _done_onenter(inst, ...)
    end
end

AddStategraphPostInit("slotmachine", postinit)
