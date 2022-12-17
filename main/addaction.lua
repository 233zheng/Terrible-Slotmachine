local AddAction = AddAction

AddAction("SPECIAL_ACTION","Special Actions",function(act)
	if act.doer.special_action then
		act.doer.special_action(act)
		return true
	end
end)

AddAction("RANSACK","Ransack",function(act)
	return true
end)

AddAction("BARK","bark_at_friend",function(act)
    return true
end)

AddAction("MOUNTDUNG","Mountdung",function(act)
	act.doer.dung_target:Remove()
    act.doer:AddTag("hasdung") 
    act.doer.dung_target = nil
end)

AddAction("DIGDUNG","Digdung",function(act)
	act.target.components.workable:WorkedBy(act.doer, 1)
end)

-------------actions hamlet-------------------
AddAction(
    "PEAGAWK_TRANSFORM",
    "Peagank Transform",
    function(act)
        --Dummy action for flup hiding
    end
)

AddAction(
    "MANUALEXTINGUISH",
    "Manualextinguish",
    function(act)
	if act.doer:HasTag("extinguisher") then
		if act.target.components.burnable and act.target.components.burnable:IsBurning() then
			act.target.components.burnable:Extinguish()
			return true
		end
	elseif act.target.components.sentientball then
		act.target.components.burnable:Extinguish()
		-- damage player?
		return true
	elseif act.invobject:HasTag("frozen") and act.target.components.burnable and act.target.components.burnable:IsBurning() then
		act.target.components.burnable:Extinguish(true, TUNING.SMOTHERER_EXTINGUISH_HEAT_PERCENT, act.invobject)
		return true
	end
    end
)

AddAction(
    "SPECIAL_ACTION2",
    "Special Actions2",
    function(act)
	if act.doer.special_action2 then
		act.doer.special_action2(act)
		return true
	end
    end
)


AddAction(
    "LAUNCH_THROWABLE",
    "Launch Throwable",
    function(act)
	if act.target and not act.pos then
		act.pos = act.target:GetPosition()
	end
	act.invobject.components.thrower:Throw(act.pos)
	return true
    end
)

AddAction(
    "INFEST",
    "Infest",
    function(act)
	if not act.doer.infesting then
		act.doer.components.infester:Infest(act.target)
	end
    end
)

AddAction(
    "CUREPOISON",
    "Curepoison",
    function(act)
	if act.invobject and act.invobject.components.poisonhealer then
		local target = act.target or act.doer
		return act.invobject.components.poisonhealer:Cure(target)
	end
    end
)

AddAction(
    "USEDOOR",
    "Usedoor",
    function(act)
	if act.target:HasTag("secret_room") then
		return false
	end

	if act.target.components.door and not act.target.components.door.disabled then
		act.target.components.door:Activate(act.doer)
		return true
	elseif act.target.components.door and act.target.components.door.disabled then
		return false, "LOCKED"
	end
    end
)

local SHOP = GLOBAL.Action({priority = 9, rmb = true, distance = 1, mount_valid = false})
SHOP.stroverridefn = function(act)
if act.target.imagename and act.target.cost then
    return "Buy "..act.target.imagename.." for "..act.target.cost.." oincs"
else
return "Shop"
end
end
SHOP.id = "SHOP"
SHOP.fn = function(act)
	if act.doer.components.inventory then
		if act.doer:HasTag("player") and act.doer.components.shopper then 

			if act.doer.components.shopper:IsWatching(act.target) then 

				local sell = true
				local reason = nil

				if act.target:HasTag("shopclosed") or GLOBAL.TheWorld.state.isnight then
					reason = "closed"
					sell = false
				elseif not act.doer.components.shopper:CanPayFor(act.target) then 
					local prefab_wanted = act.target.costprefab
					if prefab_wanted == "oinc" then
						reason = "money"
					else
						reason = "goods"
					end
					sell = false
				end
				
				if sell then
					act.doer.components.shopper:PayFor(act.target)
					act.target.components.shopdispenser:RemoveItem()
					act.target:SetImage(nil)

					if act.target and act.target.shopkeeper_speech then
						act.target.shopkeeper_speech(act.target,STRINGS.CITY_PIG_SHOPKEEPER_SALE[math.random(1,#STRINGS.CITY_PIG_SHOPKEEPER_SALE)])
					end

					return true 
				else 
					if reason == "money" then
						if act.target and act.target.shopkeeper_speech then
							act.target.shopkeeper_speech(act.target,STRINGS.CITY_PIG_SHOPKEEPER_NOT_ENOUGH[math.random(1,#STRINGS.CITY_PIG_SHOPKEEPER_NOT_ENOUGH)])
						end
					elseif reason == "goods" then
						if act.target and act.target.shopkeeper_speech then
							act.target.shopkeeper_speech(act.target,STRINGS.CITY_PIG_SHOPKEEPER_DONT_HAVE[math.random(1,#STRINGS.CITY_PIG_SHOPKEEPER_DONT_HAVE)])
						end						
					elseif reason == "closed" then
						if act.target and act.target.shopkeeper_speech then
							act.target.shopkeeper_speech(act.target,STRINGS.CITY_PIG_SHOPKEEPER_CLOSING[math.random(1,#STRINGS.CITY_PIG_SHOPKEEPER_CLOSING)])
						end						
					end
					return true
				end		
			else
				act.doer.components.shopper:Take(act.target)
				-- THIS IS WHAT HAPPENS IF ISWATCHING IS FALSE
				act.target.components.shopdispenser:RemoveItem()
				act.target:SetImage(nil)
				return true 
			end 
		end
	end
end
SHOP.encumbered_valid =true
AddAction(SHOP)

AddAction(
    "FIX",
    "Fix",
    function(act)
	if act.target then
		local target = act.target
		local numworks = 1
		target.components.workable:WorkedBy(act.doer, numworks)
	--	return target:fix(act.doer)		
	end
    end
)

AddAction(
    "STOCK",
    "Stock",
    function(act)
	if act.target then		
		act.target.restock(act.target,true)
		act.doer.changestock = nil
		return true
	end
    end
)

