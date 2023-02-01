local AddStategraphPostInit = AddStategraphPostInit
GLOBAL.setfenv(1, GLOBAL)

local function postinit(inst)
    local _done_onenter = inst.states["done"].onenter
    inst.states["done"].onenter = function(inst, ...)
        local spawnboss = nil
        local spawnboss2 = nil
        if inst.level ~= nil then
            inst.level = inst.level + math.random() * 0.4 + 0.6
            if inst.level >= 100 and inst.level < 101 then
                spawnboss = SpawnPrefab("dragonfly")
            elseif inst.level >= 200 and inst.level < 201 then
                spawnboss = SpawnPrefab("beequeen")
            elseif inst.level >= 300 and inst.level < 301 then
                spawnboss = SpawnPrefab("klaus")
            elseif inst.level >= 400 and inst.level < 401 then
                spawnboss = SpawnPrefab("toadstool")
            elseif inst.level >= 500 and inst.level < 501 then
                spawnboss = SpawnPrefab("shadowchesses")
            elseif inst.level >= 600 and inst.level < 601 then
                spawnboss = SpawnPrefab("twinofterror1")
                spawnboss2 = SpawnPrefab("twinofterror2")
            elseif inst.level >= 700 and inst.level < 701 then
                spawnboss = SpawnPrefab("alterguardian_phase1")
            end
            if spawnboss ~= nil then
                spawnboss.Transform:SetPosition(inst.Transform:GetWorldPosition())
                if spawnboss2 ~= nil then
                    spawnboss2.Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
                print("bossspawned")
            end
            print("level is not nil".. tostring(inst.level))
        else
            inst.level = 0
            print("startlevel")
            print(inst.level)
        end
        if inst.DoneSpinning and not spawnboss ~= nil then
            inst:DoneSpinning()
        end
        _done_onenter(inst, ...)
    end
end

AddStategraphPostInit("slotmachine", postinit)
