-- Inventory
-- qweekertom
-- November 10, 2020



local Inventory = {}
local CellCache = {}

local ItemData
local InventoryGui

local TooltipOffset = Vector2.new(20, 0)
local TooltipBox
local Mouse

function OnMouseMove()
    if not TooltipBox.Visible then return end
    local origin = InventoryGui.AbsolutePosition
    TooltipBox.Position = UDim2.new(
        0, Mouse.X - origin.X + TooltipOffset.X,
        0, Mouse.Y - origin.Y + TooltipOffset.Y
    )
end

function UpdateTooltip(visible, id)
    if (visible) then
        local data = ItemData.GetData(id)
        TooltipBox.ItemName.Text = data.Name
        TooltipBox.Description.Text = data.Description
        TooltipBox.Weight.Text = data.Weight .. " lbs"
        TooltipBox.ItemType.Text = data.Type
    end
    TooltipBox.Visible = visible
end

function Inventory:UpdateItems(invData)
    local Items = invData.items
    local List = InventoryGui.Items
    local ItemCellClass = self.Modules.Interface.ItemCellClass

    local AccountedFor = {}

    for id, quantity in pairs(Items) do
        local weight = ItemData.GetProperty(id, "Weight")
        local net_weight = quantity * weight
        local listItem = CellCache[id]

        if (listItem) then
            --listItem:SetWeight(net_weight) --> need to tweak the class for the inventory tooltip
            listItem:SetQuantity(quantity)
            listItem:Update()

            AccountedFor[id] = true
        else
            --> gather viewport resources
            local viewportObject = self.Services.ItemService:GetViewportObject(id)
            local viewportData = {
                object = viewportObject,
                cameraCFrame = ItemData.GetProperty(id, "ViewportCFrame")
            }

            --> construct the new item cell
            local newListItem = ItemCellClass.new(id, quantity, net_weight, viewportData)
            
            --> bind the tooltip
            newListItem.Element.Input.MouseEnter:Connect(function()
                UpdateTooltip(true, id)
            end)

            newListItem.Element.Input.MouseLeave:Connect(function()
                UpdateTooltip(false, nil)
            end)

            --> update the cell & viewport
            newListItem:Update()

            --> add the item to the list and tables
            newListItem.Element.Parent = List
            CellCache[id] = newListItem
            AccountedFor[id] = true
        end
    end

    for id, listItem in pairs(CellCache) do
        if not (AccountedFor[id]) then
            CellCache[id] = listItem:Destroy()
        end
    end
end

function Inventory:Start()
    Mouse = self.Player:GetMouse()
    ItemData = self.Shared.ItemData
    InventoryGui = self.Player.PlayerGui:WaitForChild("MainGui").Menus.Inventory
    TooltipBox = InventoryGui.Tooltip

    TooltipBox.Visible = false

	self.Services.InventoryService.updateInventory:Connect(function(...)
        print(...)
        Inventory:UpdateItems(...)
    end)

    Mouse.Move:Connect(OnMouseMove)
end


function Inventory:Init()
	
end


return Inventory