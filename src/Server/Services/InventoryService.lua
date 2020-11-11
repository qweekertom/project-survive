-- Inventory Service
-- qweekertom
-- November 10, 2020



local InventoryService = {Client = {}}
local Inventories = {}

local InventoryClass

function InventoryService.Client:PickupItem(Player, Object)
    local inventory = Inventories[Player.UserId]
    inventory:AddItem(Object.Name, 1)
    Object:Destroy()
end

function InventoryService:MakeInventory(player)
    local newInv = InventoryClass.new(player)
    Inventories[player.UserId] = newInv

    newInv.sync.Changed:Connect(function(value)
        if value then return end
        self:FireClient("updateInventory",player, newInv)
        newInv:SetSync(true)
    end)
end

function InventoryService:Start()
	InventoryClass = self.Modules.InventoryClass
end


function InventoryService:Init()
	self:RegisterClientEvent("updateInventory")
end


return InventoryService