local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

SetSharedLootTable("shadow_chesspiece2",
{
    { "nightmarefuel",  1.0 },
    { "nightmarefuel",  0.5 },
    {"goldnugget",    1.00},
    {"goldnugget",    1.00},
    {"goldnugget",    1.00},
    {"goldnugget",    1.00},
    {"nightsword",    1.00},
})

local function Newretargetfn(inst)
    --retarget nearby players if current target is fleeing or not a player
    local target = inst.components.combat.target
    if target ~= nil then
        local dist = TUNING[string.upper(inst.prefab)].RETARGET_DIST * 5
        if target:HasTag("player") and inst:IsNear(target, dist) or not inst:IsNearPlayer(dist, true) then
            return
        end
        target = nil
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    local players = FindPlayersInRange(x, y, z, TUNING.SHADOWCREATURE_TARGET_DIST * 5, true)
    local rangesq = math.huge
    for i, v in ipairs(players) do
        local distsq = v:GetDistanceSqToPoint(x, y, z)
        if distsq < rangesq and inst.components.combat:CanTarget(v) then
            rangesq = distsq
            target = v
        end
    end
    return target, true
end

local function postinit(inst)

	inst.AnimState:UsePointFiltering(true)

    if TheWorld.ismastersim then

    if inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable("shadow_chesspiece2")
    end

    if inst.components.combat ~= nil then
        inst.components.combat:SetRetargetFunction(3, Newretargetfn)
    end

    end
end

AddPrefabPostInit("spiderqueen", postinit)
