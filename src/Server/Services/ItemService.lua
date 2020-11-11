-- Item Service
-- Username
-- November 4, 2020

local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")

local ItemsFolder

local ItemService = {Client = {}}

local function TestItemSpawning()
    ItemService:SpawnItem(Vector3.new(136, 12.5, 138), "brick")
    ItemService:SpawnItem(Vector3.new(141, 12.5, 138), "brick")
    ItemService:SpawnItem(Vector3.new(136, 12.5, 144), "brick")
    ItemService:SpawnItem(Vector3.new(141, 12.5, 144), "brick")
end

function ItemService:SpawnItem(location, id)
    local Items = ServerStorage.Assets.ItemModels
    if (Items[id]) then
        local clone = Items[id]:Clone()
        local cframe = CFrame.new(location)
        clone:SetPrimaryPartCFrame(cframe) 
        CollectionService:AddTag(clone, "interact")
        CollectionService:AddTag(clone, "item")
        clone.Parent = ItemsFolder
    end
end

function ItemService:Start()
    ItemsFolder = self.Services.RuntimeService:GetFolder("Items")
    --> Testing 
    TestItemSpawning()
end


function ItemService:Init()
	
end


return ItemService