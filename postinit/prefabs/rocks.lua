local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

local _OnWork
local function OnWork(inst, worker, workleft, ...)
    local pt = inst:GetPosition()
    local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
    local x, y, z = inst.Transform:GetWorldPosition()
    local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
    local tags = {"guard"}
    local eles = TheSim:FindEntities(x,y,z, 40, tags)

    if worker and worker:HasTag("player") and not worker:HasTag("sneaky") then

    for k, guardas in pairs(eles) do
        if guardas.components.combat and guardas.components.combat.target == nil then guardas.components.combat:SetTarget(worker) end
        end
    end

    if workleft <= 0 then
        local pt = inst:GetPosition()
        local fx = SpawnPrefab("rock_break_fx")
        fx.Transform:SetPosition(pt:Get())
        inst.components.lootdropper:DropLoot(pt)

        if inst.showCloudFXwhenRemoved then
            local fx = SpawnPrefab("collapse_small")
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end

        if not inst.doNotRemoveOnWorkDone then
            inst:Remove()
        end
    else
        inst.AnimState:PlayAnimation(
            (workleft < TUNING.ROCKS_MINE / 3 and "low") or
            (workleft < TUNING.ROCKS_MINE * 2 / 3 and "med") or
            "full"
        )
    end
    if _OnWork ~= nil then
        _OnWork(inst, worker, workleft, ...)
    end
end

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    if inst.components.workable then
        inst.components.workable:SetOnWorkCallback(OnWork)
    end

end

local t = {
    "rock1",
    "rock2",
    "rock_flintless",
    "rock_flintless_med",
    "rock_flintless_low",
    "rock_moon",
    "rock_moon_shell",
    "moonglass_rock",
    "rock_petrified_tree",
    "rock_petrified_tree_med",
    "rock_petrified_tree_tall",
    "rock_petrified_tree_short",
    "rock_petrified_tree_old",
}

for k, v in ipairs(t) do
    AddPrefabPostInit(v, postinit)
end

