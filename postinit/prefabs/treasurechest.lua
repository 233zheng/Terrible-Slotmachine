local AddPrefabPostInit = AddPrefabPostInit
GLOBAL.setfenv(1, GLOBAL)

local _onhit
local function onhit(inst, worker, ...)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("closed", false)
        if inst.components.container ~= nil then
            inst.components.container:DropEverything()
            inst.components.container:Close()
        end
    end
    if _onhit ~= nil then
        _onhit(inst, worker, ...)
    end
end

local function postinit(inst)

    if not TheWorld.ismastersim then return end

    if inst.components.workable then
        inst.components.workable:SetOnWorkCallback(onhit)
    end
end

local t = {
    "treasurechest",
    "pandoraschest",
    "minotaurchest",
    "terrariumchest",
	-- "sunkenchest",
}

for k, v in ipairs(t) do
    AddPrefabPostInit(v, postinit)
end

