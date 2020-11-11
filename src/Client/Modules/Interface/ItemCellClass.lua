-- List Item Class
-- qweekertom
-- October 17, 2020



local ItemCellClass = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interface = ReplicatedStorage:WaitForChild("Interface")

ItemCellClass.__index = ItemCellClass

local function setupViewport(element, viewportData)
	local viewport = element:FindFirstChildOfClass("ViewportFrame")
	local model = viewportData.object
	local camera = Instance.new("Camera")
	
	model:SetPrimaryPartCFrame(CFrame.new(0,0,0))
	camera.CFrame = viewportData.cameraCFrame

	viewport.CurrentCamera = camera

	camera.Parent = viewport
	model.Parent = viewport
end

function ItemCellClass.new(id, quantity, totalWeight, viewportData)

	local self = setmetatable({
		_id = id,
		_quantity = quantity,
		_totalWeight = totalWeight,
		_viewportData = viewportData,

		Element = Interface.ItemCell:Clone()

	}, ItemCellClass)

	--setupViewport(self.Element, self._viewportData)

	return self
end

function ItemCellClass:Update()
	self.Element.Quantity.Text = self._quantity
	setupViewport(self.Element, self._viewportData)
end

function ItemCellClass:SetWeight(weight)
	self._totalWeight = weight
end

function ItemCellClass:SetQuantity(quantity)
	self._quantity = quantity
end

function ItemCellClass:SetViewportData(viewportData)
	self._viewportData = viewportData
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