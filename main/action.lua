GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})


local function GetRepair_cmp(inst)
	local repairable_cmp, current, max
	if inst.components.finiteuses then
		repairable_cmp, current, max = inst.components.finiteuses, "current", "total"
	elseif inst.components.fueled then
		repairable_cmp, current, max = inst.components.fueled, "currentfuel", "maxfuel"
	elseif inst.components.armor then
		repairable_cmp, current, max = inst.components.armor, "condition", "maxcondition"
	end

	return repairable_cmp, current, max
end

local function repair_item(inst, giver, item)
	local repairable_cmp, current, max = GetRepair_cmp(inst)
	if not repairable_cmp or repairable_cmp:GetPercent() >=1 then
		return
	end

	local repaired_value = 0
	if item then
		repaired_value = inst.repairable_item and inst.repairable_item[item.prefab] or 0
		if item.components.stackable then
			item.components.stackable:Get(1):Remove()
		else
			item:Remove()
		end
	end

	repairable_cmp[current] = math.min(repairable_cmp[current] + repaired_value, repairable_cmp[max])
	repairable_cmp:SetPercent(repairable_cmp:GetPercent())

	inst:PushEvent("repaired", {percent = repairable_cmp:GetPercent()})
end

STRINGS.ACTIONS.REPAIR_ITEM = "修复"
local act = AddAction("REPAIR_ITEM", STRINGS.ACTIONS.REPAIR_ITEM, function(act)
	if act.target then
		repair_item(act.target, act.doer, act.invobject)
		return true
	end
end)
act.priority = -10

ACTIONS.REPAIR_ITEM.stroverridefn = function(buff)
	if buff and buff.action and buff.target then
		return "修复"
	end
    return "不能修复"
end

AddComponentAction("USEITEM", "inventoryitem", function(inst, doer, target, actions, right)  -- 客户端
	if doer:HasTag("player") and inst and target and target:HasTag("repairable") and target.repairable_item then
		for item, value in pairs(target.repairable_item) do
			if inst.prefab == item then
				table.insert(actions, ACTIONS.REPAIR_ITEM)
				break
			end
		end
	end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.REPAIR_ITEM, "give"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.REPAIR_ITEM, "give"))

