-- Inventory
-- qweekertom
-- November 10, 2020



local Inventory = {}
local ItemCache = {}

local ItemUtil
local InventoryGui

function Inventory:UpdateItems(invData)
    local Items = invData.items
    local List = InventoryGui.Main.Contents.List
    local ItemCellClass = self.Modules.Interface.ItemCellClass

    local AccountedFor = {}

    for id, quantity in pairs(Items) do
        local weight = ItemUtil.GetProperty(id, "Weight")
        local net_weight = quantity * weight
        local listItem = ItemCache[id]
        if (listItem) then
            --listItem:SetWeight(net_weight) --> need to tweak the class for the inventory tooltip
            listItem:SetQuantity(quantity)
            listItem:Update()

            AccountedFor[id] = true
        else
            local newListItem = ItemCellClass.new(id, quantity, net_weight)
            
            newListItem.Element.Parent = List
            ItemCache[id] = newListItem

            AccountedFor[id] = true
        end
    end

    for id, listItem in pairs(ItemCache) do
        if not (AccountedFor[id]) then
            ItemCache[id] = listItem:Destroy()
        end
    end
end

function Inventory:Start()
    ItemUtil = self.Shared.ItemUtil
    InventoryGui = self.Player.PlayerGui:WaitForChild("MainGui").Menus.Inventory

	self.Services.InventoryService.updateInventory:Connect(function(...)
        --Inventory:UpdateItems(...)
    end)
end


function Inventory:Init()
	
end


return Inventory