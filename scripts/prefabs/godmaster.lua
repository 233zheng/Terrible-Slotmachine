local assets=
{
	Asset("ANIM", "anim/iron_ore.zip"),
}

local function onsave(inst, data)
	data.level = inst.level
    data.starttime = inst.starttime
    data.deathtime = inst.deathtime
end

local function onload(inst, data)
    if data and data.level then
        inst.level = data.level
	end
    if data and data.starttime then
        inst.starttime = data.starttime
	end
    if data and data.deathtime then
        inst.deathtime = data.deathtime
	end
end

local loots = {
    {"armorgrass","hambat","bandage","bandage",},
    {"cane","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage",},
    {"icestaff","hivehat","panflute","hotchili_spice_chili","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage",},
    {"glasscutter","yellowamulet","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage",},
    {"voltgoatjelly_spice_sugar","multitool_axe_pickaxe","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage",},
    {"sleepbomb","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage",},
    {"jellybean","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage",},
    {"treegrowthsolution","boards","trident","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage",},
    {"staff_tornado","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage",},
    {"orangestaff","purpleamulet","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage","bandage",},
    
}

BossList = {
    "minotaur",
    "klaus",
    "dragonfly",
    "shadowchesses",
    "toadstool",
    "beequeen",
    "twinmanager",
    "crabking",
    "alterguardians",
    "stalker_atrium",
}

local function SpawnLoot(inst,level)
    inst.components.lootdropper:SetLoot({})
    inst.components.lootdropper:SetLoot(loots[level])
    inst.components.lootdropper:DropLoot()
end

local function SpawnBoss(inst,level)
    local x,y,z = inst.Transform:GetWorldPosition()
    local boss = SpawnPrefab(BossList[level])
    boss.Transform:SetPosition(x,y,z)
    boss:Hide()
    boss:DoTaskInTime(FRAMES,boss.Show)
    if BossList[level] == "klaus" then
        inst.deathtime = -1
    else
        inst.deathtime = 0
    end
    local x, y, z = inst.Transform:GetWorldPosition()
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"bandage"}, nil)) do
        if v.components.inventoryitem ~= nil and v.components.inventoryitem.is_landed then
            v:Remove()
        end
    end
    inst:ListenForEvent("death",function(boss)
        if not inst.willremove then
        inst.deathtime = inst.deathtime + 1
        if inst.deathtime >= 1 then
            if ThePlayer then
                local str = string.format("%5.2f",(GetTime()-inst.starttime+15-18*inst.level))
                inst:DoTaskInTime(0,function() ThePlayer.components.talker:Say("完成第"..tostring(level).."关，总用时："..str) end)
            end
            inst:DoTaskInTime(0,inst.SpawnLevel,inst.level)
        end
        end
    end,boss)
end

local function SpawnBossNolevel(inst,bossname)
    local x,y,z = inst.Transform:GetWorldPosition()
    local boss = SpawnPrefab(bossname)
    boss.Transform:SetPosition(x,y,z)
    boss:Hide()
    boss:DoTaskInTime(FRAMES,boss.Show)
    if boss == "klaus" then
        inst.deathtime = -1
    else
        inst.deathtime = 0
    end
    local x, y, z = inst.Transform:GetWorldPosition()
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"bandage"}, nil)) do
        if v.components.inventoryitem ~= nil and v.components.inventoryitem.is_landed then
            v:Remove()
        end
    end
    inst:ListenForEvent("death",function(boss)
        if not inst.willremove then
        inst.deathtime = inst.deathtime + 1
        if inst.deathtime >= 1 then
            if ThePlayer then
                local str = string.format("%5.2f",(GetTime()-inst.starttime-10))
                inst:DoTaskInTime(0,function() ThePlayer.components.talker:Say("战斗胜利！总用时："..str) end)
                inst:DoTaskInTime(1.5,function() ThePlayer.components.talker:Say("战斗胜利！总用时："..str) end)
            end
            local x, y, z = inst.Transform:GetWorldPosition()
            for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"flowers_evil"}, nil)) do
                v:DoTaskInTime(8,v.PlaceGodhom2)
            end
            inst:DoTaskInTime(8,inst.Remove)
        end
        end
    end,boss)
end


local function SpawnLevel(inst)
    if inst.level < 11 then
        inst:DoTaskInTime(0,SpawnLoot,inst.level)
        inst:DoTaskInTime(18,SpawnBoss,inst.level)
        if inst.level == 10 then
            inst:DoTaskInTime(9,function() TheWorld:PushEvent("ms_setclocksegs", {day = 0, dusk = 0, night = 16}) end)
            inst:DoTaskInTime(8,function() 
                local x, y, z = inst.Transform:GetWorldPosition()
                for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"yellowlight"}, nil)) do
                    v.Light:SetColour(0,0,0)
                end
            end)
            inst:DoTaskInTime(18,function() 
                local x, y, z = inst.Transform:GetWorldPosition()
                for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"yellowlight"}, nil)) do
                    v.Light:SetColour(223 / 255, 208 / 255, 69 / 255)
                end
            end)

        end
        if ThePlayer then
            inst:DoTaskInTime(8,function() ThePlayer.components.talker:Say("10") end)
            inst:DoTaskInTime(9,function() ThePlayer.components.talker:Say("9") end)
            inst:DoTaskInTime(10,function() ThePlayer.components.talker:Say("8") end)
            inst:DoTaskInTime(11,function() ThePlayer.components.talker:Say("7") end)
            inst:DoTaskInTime(12,function() ThePlayer.components.talker:Say("6") end)
            inst:DoTaskInTime(13,function() ThePlayer.components.talker:Say("5") end)
            inst:DoTaskInTime(14,function() ThePlayer.components.talker:Say("4") end)
            inst:DoTaskInTime(15,function() ThePlayer.components.talker:Say("3") end)
            inst:DoTaskInTime(16,function() ThePlayer.components.talker:Say("2") end)
            inst:DoTaskInTime(17,function() ThePlayer.components.talker:Say("1") end)  
            inst:DoTaskInTime(18,function() ThePlayer.components.talker:Say("开始") end)      
        end
        inst.level = inst.level + 1
    else
        if ThePlayer then
            local str = string.format("%5.2f",(GetTime()-inst.starttime+15-18*inst.level))
            inst:DoTaskInTime(0,function() ThePlayer.components.talker:Say("完成远古万神殿挑战赛，用时："..str) end)
            inst:DoTaskInTime(1.5,function() ThePlayer.components.talker:Say("完成远古万神殿挑战赛，用时："..str) end)
            local x, y, z = inst.Transform:GetWorldPosition()
            for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"flowers_evil"}, nil)) do
                v:DoTaskInTime(12,v.PlaceGodhom2)
            end
            inst:DoTaskInTime(12,inst.Remove)
        end
    end
end

local function OnBossKilled(inst)
    
end

local function OnPlayerDeath(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, nil, {"flower_end"})) do
        if v.components.inventoryitem ~= nil and v.components.inventoryitem.is_landed then
            v:Remove()
        end
    end
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"epic"},nil )) do
        if v.components.health ~= nil and not v.components.health:IsDead() then
            v.components.health:Kill()
        end
    end
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"lava"}, nil)) do
        if true then
            v:DoTaskInTime(0, ErodeAway)
        end
    end
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"moon_fissure"}, nil)) do
        if true then
            v:DoTaskInTime(0, ErodeAway)
        end
    end
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"epic"}, nil)) do
        --if v.components.health ~= nil then
            v:DoTaskInTime(5, ErodeAway)
        --end
    end
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"moonglass"}, nil)) do
        if true then
            v:DoTaskInTime(2, ErodeAway)
        end
    end
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"skeleton"}, nil)) do
        --if v.components.inventoryitem ~= nil and v.components.inventoryitem.is_landed then
            v:Remove()
        --end
    end
    if ThePlayer~=nil then
        ThePlayer:PushEvent("respawnfromghost", { source = nil })
        ThePlayer:DoTaskInTime(4.5,function() ThePlayer.components.sanity:DoDelta(100)end)
        ThePlayer:DoTaskInTime(4.5,function() ThePlayer.components.hunger:DoDelta(100)end)
    end
    for i, v in ipairs(TheSim:FindEntities(x, y, z, 60, {"flowers_evil"}, nil)) do
        v.PlaceGodhom2(v)
    end
    local alters = TheSim:FindEntities(x,y,z, 64,{"player"}, nil, nil)
    for i,v in ipairs(alters) do
        v:PushEvent("guardianleave")
        v.components.sanity:SetPercent(1)
    end
    inst:Remove()
end

local function UpdatePlayer(inst)
    if ThePlayer ~= nil and ThePlayer.components.health:IsDead() and not inst.willremove then
        inst:DoTaskInTime(2,function() ThePlayer.components.talker:Say("5秒后重置万神殿挑战") end)
        inst:DoTaskInTime(3,function() ThePlayer.components.talker:Say("4") end)
        inst:DoTaskInTime(4,function() ThePlayer.components.talker:Say("3") end)
        inst:DoTaskInTime(5,function() ThePlayer.components.talker:Say("2") end)
        inst:DoTaskInTime(6,function() ThePlayer.components.talker:Say("1") end)
        inst:DoTaskInTime(7,function() ThePlayer.components.talker:Say("万神殿挑战已重置") end)
        inst:DoTaskInTime(7,OnPlayerDeath,inst)
        inst.willremove = true
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    --MakeInventoryPhysics(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.HEAVY, TUNING.WINDBLOWN_SCALE_MAX.HEAVY)
    inst.entity:AddNetwork()

    inst:AddTag("bossrush4")

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst.level = 1
    inst.starttime = GetTime()
    inst.deathtime = 0
    if ThePlayer then
        inst:DoTaskInTime(0.1,function() ThePlayer.components.talker:Say("远古万神殿挑战赛即将在3秒后开始") end) 
        inst:DoTaskInTime(3,function() ThePlayer.components.talker:Say("第一场战斗将在18秒后开始") end)      
    end

    inst.willremove = false

    inst:DoTaskInTime(3,SpawnLevel,inst)
    inst:DoPeriodicTask(FRAMES,UpdatePlayer,nil)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper.max_speed = 3
    inst.components.lootdropper.min_speed = 2
    inst.components.lootdropper.y_speed = 12
	--inst.components.lootdropper.healthrepairvalue = TUNING.REPAIR_ROCKS_HEALTH

    inst.persists = false

    inst.SpawnLevel = SpawnLevel
    --inst.OnSave = onsave 
    --inst.OnLoad = onload 
    return inst
end

local function fn_god(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    --MakeInventoryPhysics(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.HEAVY, TUNING.WINDBLOWN_SCALE_MAX.HEAVY)
    inst.entity:AddNetwork()

    inst:AddTag("bossfight")

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst.starttime = GetTime()
    inst.deathtime = 0
    if ThePlayer then
        inst:DoTaskInTime(5,function() ThePlayer.components.talker:Say("5") end)
        inst:DoTaskInTime(6,function() ThePlayer.components.talker:Say("4") end)
        inst:DoTaskInTime(7,function() ThePlayer.components.talker:Say("3") end)
        inst:DoTaskInTime(8,function() ThePlayer.components.talker:Say("2") end)
        inst:DoTaskInTime(9,function() ThePlayer.components.talker:Say("1") end)
        inst:DoTaskInTime(10,function() ThePlayer.components.talker:Say("战斗开始") end)
        inst:DoTaskInTime(0.1,function() ThePlayer.components.talker:Say("战斗即将在10秒后开始") end)      
    end

    inst.willremove = false

    --inst:DoTaskInTime(0,SpawnLevel,inst)
    inst:DoPeriodicTask(FRAMES,UpdatePlayer,nil)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper.max_speed = 3
    inst.components.lootdropper.min_speed = 2
    inst.components.lootdropper.y_speed = 12
	--inst.components.lootdropper.healthrepairvalue = TUNING.REPAIR_ROCKS_HEALTH

    inst.persists = false

    inst.SpawnBossNolevel = SpawnBossNolevel

    --inst.OnSave = onsave 
    --inst.OnLoad = onload 
    return inst
end



local function chessesfn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    --MakeInventoryPhysics(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.HEAVY, TUNING.WINDBLOWN_SCALE_MAX.HEAVY)
    inst.entity:AddNetwork()

	if not TheWorld.ismastersim then
		return inst
	end	

    inst.hasspawned = false
    inst.liveboss = 3

    inst:DoTaskInTime(0,function()
        local knight = SpawnPrefab("shadow_knight")
        local rook = SpawnPrefab("shadow_rook")
        local bishop = SpawnPrefab("shadow_bishop")
        --inst.knight.sg:GoToState("levelup")
        --inst.rook.sg:GoToState("levelup")
        --inst.bishop.sg:GoToState("levelup")
        knight.Transform:SetPosition((inst:GetPosition() + Vector3(5,0,0)):Get())
        rook.Transform:SetPosition((inst:GetPosition() + Vector3(-3,0,4)):Get())
        bishop.Transform:SetPosition((inst:GetPosition() + Vector3(-3,0,-4)):Get())
        inst:ListenForEvent("death",function(boss)
            inst.liveboss = inst.liveboss - 1
        end,knight)
        inst:ListenForEvent("death",function(boss)
            inst.liveboss = inst.liveboss - 1
        end,rook)
        inst:ListenForEvent("death",function(boss)
            inst.liveboss = inst.liveboss - 1
        end,bishop)
    
    end)

    inst:DoTaskInTime(0,function()inst.hasspawned = true end)

    inst:DoPeriodicTask(FRAMES,function()
        if inst.liveboss <= 0 then
            inst:PushEvent("death")
            inst:Remove()
            inst.liveboss = 33
        end
    end)

	--inst:AddComponent("lootdropper")
	--inst.components.lootdropper.repairmaterial = "orp"
	--inst.components.lootdropper.healthrepairvalue = TUNING.REPAIR_ROCKS_HEALTH

    --inst.SpawnLevel = SpawnLevel
    --inst.OnSave = onsave 
    --inst.OnLoad = onload 
    return inst
end
local function guardiansfn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    --MakeInventoryPhysics(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.HEAVY, TUNING.WINDBLOWN_SCALE_MAX.HEAVY)
    inst.entity:AddNetwork()

    inst:AddTag("alterguardians")

	if not TheWorld.ismastersim then
		return inst
	end	

    inst.hasspawned = false
    inst.liveboss = 3

    inst:DoTaskInTime(0,function() 
        local guardian = SpawnPrefab("alterguardian_phase1") 
        guardian.Transform:SetPosition((inst:GetPosition()):Get())
    end)

    inst:ListenForEvent("death",function()
        inst:Remove()
    end)

    return inst
end


return Prefab( "godgatemanager_4", fn, assets),
Prefab( "godmanager", fn_god, assets),
Prefab( "shadowchesses", chessesfn, assets),
Prefab( "alterguardians", guardiansfn, assets)
