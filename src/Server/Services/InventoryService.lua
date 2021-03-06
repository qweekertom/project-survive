-- Inventory Service
-- qweekertom
-- November 10, 2020

local CollectionService = game:GetService("CollectionService")

local InventoryService = {Client = {}}
local Inventories = {}

local InventoryClass

local function isTableBad(table, keys)
    for _, k in pairs(keys) do
        if not (table[k]) then
            return true
        end
    end

    return false
end

function InventoryService.Client:MakeChanges(player, changeTable)
    local inventory = Inventories[player.UserId]
    local changeType = changeTable.Type

    if (changeType == "DROP") then
        --> check to see if our table has all necessary keys
        if isTableBad(changeTable, {"Type","Id","Quantity"}) then return end

        --> perform class method, and react upon success
        local success = inventory:RemoveItem(changeTable.Id, changeTable.Quantity)
        if (success) then
            --> perform the drop into the world
            
            local hipHeight = player.Character.Humanoid.HipHeight
            local rootSize = player.Character.HumanoidRootPart.Size.Y / 2
            local rootCFrame = player.Character.HumanoidRootPart.CFrame
            
            local offset = Vector3.new(0,hipHeight + rootSize - .5,0)
            local targetPosition = (rootCFrame - offset).Position


            --self.Server.Services.ItemService:SpawnItem(position, changeTable.Id)

        end
    elseif (changeType == "PICKUP") then
        --> table check
        if isTableBad(changeTable, {"Type","Object","Id"}) then return end

        --> perform class method, and react upon success
        local success = inventory:AddItem(changeTable.Id, 1)

        if (success) then
            changeTable.Object:Destroy()
        end
    else
        print("unkown change type @InventoryService:MakeChanges() -- given type:",changeType)
    end
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