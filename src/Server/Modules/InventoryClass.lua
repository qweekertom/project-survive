-- Inventory Class
-- qweekertom
-- October 12, 2020



local InventoryClass = {}
local ItemUtil

InventoryClass.__index = InventoryClass

function InventoryClass.new(player)

	local self = setmetatable({
		_godmode 		= false;
		_overweight 	= false;
		Player 			= player;
		max_weight		= 30;
		total_weight 	= 0;
		sync 			= Instance.new("BoolValue");
		items 			= {};
		equipment 		= {};
	}, InventoryClass)

	self.sync.Value = true

	return self

end

function InventoryClass:_updateWeight()
	local netWeight = 0

	for id, quantity in pairs(self.items) do
		local weight = ItemUtil.GetProperty(id, "Weight")

		netWeight += weight * quantity
	end

	self.total_weight = netWeight
	self._overweight = (self.total_weight > self.max_weight)
end

function InventoryClass:AddItem(id, quantity)
	local itemWeight = ItemUtil.GetProperty(id, "Weight") * quantity
	
	local canTake = (itemWeight + self.total_weight <= self.max_weight)
	if not (canTake) then return false end

	local existingStack = self.items[id]
	if (existingStack) then
		self.items[id] += quantity
	else
		self.items[id] = quantity
	end

	self:_updateWeight()
	self:SetSync(false)

	return true
end

function InventoryClass:RemoveItem(id, quantity)
	if not (self.items[id]) then return false end

	self.items[id] -= quantity

	if (self.items[id] <= 0) then
		self.items[id] = nil
	end

	self:_updateWeight()
	self:SetSync(false)

	return true
end

function InventoryClass:EquipItem(slot, id)
	local CanEquip = ItemUtil.GetProperty(id, "CanEquip")
	if (CanEquip) then
		self.equipment[slot] = id

		return true
	else
		return false
	end
end

function InventoryClass:UnequipItem(slot)
	local item = self.equipment[slot]
	if (item) then
		self.equipment[slot] = nil

		return self:AddItem(item,1)
	else
		return false
	end
end

function InventoryClass:GetItems()
	return self.items
end

function InventoryClass:GetEquipment()
	return self.equipment
end

function InventoryClass:GetMaxWeight()
	return self.max_weight
end

function InventoryClass:GetTotalWeight()
	return self.total_weight
end

function InventoryClass:EnableGodMode()
	self._godmode = true
end

function InventoryClass:SetSync(bool)
	assert(type(bool) == "boolean", "InventoryClass:_setType() argument must be boolean")

	self.sync.Value = bool
end

function InventoryClass:Start()
	ItemUtil = self.Shared.ItemData
end

return InventoryClass