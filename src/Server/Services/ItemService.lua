-- Item Service
-- Username
-- November 4, 2020

local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ItemsFolder

local ItemService = {Client = {}}

local function TestItemSpawning()
    ItemService:SpawnItem(Vector3.new(136, 12.5, 138), "brick")
    ItemService:SpawnItem(Vector3.new(141, 12.5, 138), "brick")
    ItemService:SpawnItem(Vector3.new(136, 12.5, 144), "brick")
    ItemService:SpawnItem(Vector3.new(141, 12.5, 144), "brick")
end

function ItemService.Client:GetViewportObject(player, id)
    local model = self.Server:GetItemModel(id)
    model.Parent = ReplicatedStorage.ViewportObjects
    return model
end

function ItemService:GetItemModel(id)
    local Items = ServerStorage.Assets.ItemModels
    local Model = Items[id]
    if (Model) then
        return Model:Clone()
    else
        warn("Failed to find item @id:",id)
        return nil
    end
end

function ItemService:SpawnItem(location, id)
    local clone = self:GetItemModel(id)
    local cframe = CFrame.new(location)
    clone:SetPrimaryPartCFrame(cframe) 
    CollectionService:AddTag(clone, "interact")
    CollectionService:AddTag(clone, "item")
    clone.Parent = ItemsFolder

end

function ItemService:Start()
    ItemsFolder = self.Services.RuntimeService:GetFolder("Items")
    --> Testing 
    TestItemSpawning()
end


function ItemService:Init()
	
end


return ItemService