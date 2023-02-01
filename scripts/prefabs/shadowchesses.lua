local function chessesfn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
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

        knight.Transform:SetPosition((inst:GetPosition() + Vector3(5,0,0)):Get())
        rook.Transform:SetPosition((inst:GetPosition() + Vector3(-3,0,4)):Get())
        bishop.Transform:SetPosition((inst:GetPosition() + Vector3(-3,0,-4)):Get())

        inst:ListenForEvent("death",function(boss)
            inst.liveboss = inst.liveboss - 1
        end, knight)
        inst:ListenForEvent("death",function(boss)
            inst.liveboss = inst.liveboss - 1
        end, rook)
        inst:ListenForEvent("death",function(boss)
            inst.liveboss = inst.liveboss - 1
        end, bishop)

    end)

    inst:DoTaskInTime(0,function() inst.hasspawned = true end)

    inst:DoPeriodicTask(FRAMES,function()
        if inst.liveboss <= 0 then
            inst:PushEvent("death")
            inst:Remove()
            inst.liveboss = 33
        end
    end)

    return inst
end

return Prefab( "shadowchesses", chessesfn)
