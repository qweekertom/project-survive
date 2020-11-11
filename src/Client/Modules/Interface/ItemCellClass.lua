-- List Item Class
-- qweekertom
-- October 17, 2020



local ItemCellClass = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interface = ReplicatedStorage:WaitForChild("Interface")

ItemCellClass.__index = ItemCellClass

function ItemCellClass.new(id, quantity, totalWeight)

	local self = setmetatable({
		_id = id,
		_quantity = quantity,
		_totalWeight = totalWeight,

		Element = Interface.ItemCell:Clone()

	}, ItemCellClass)

	return self

end

function ItemCellClass:Update()
	--self.Element.Id.Text = "Id: " .. self._id
	self.Element.Quantity.Text = "Quantity: " .. self._quantity
	--self.Element.Weight.Text = "Weight: " .. self._totalWeight
end

function ItemCellClass:SetWeight(weight)
	self._totalWeight = weight
end

function ItemCellClass:SetQuantity(quantity)
	self._quantity = quantity
end

function ItemCellClass:BindClick(func)
	return self.Element.Input.MouseButton1Click:connect(func)
end

function ItemCellClass:Destroy()
	self.Element:Destroy()
	self = nil
	return self
end


return ItemCellClass