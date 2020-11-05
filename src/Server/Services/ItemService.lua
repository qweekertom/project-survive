-- Item Service
-- Username
-- November 4, 2020

local ServerStorage = game:GetService("ServerStorage")
local ItemsFolder

local ItemService = {Client = {}}

local function TestItemSpawning()
    ItemService:SpawnItem(Vector3.new(136, 12.5, 138), "brick")
    ItemService:SpawnItem(Vector3.new(141, 12.5, 138), "brick")
    ItemService:SpawnItem(Vector3.new(136, 12.5, 144), "brick")
    ItemService:SpawnItem(Vector3.new(141, 12.5, 144), "brick")
end

local function MakeItemsFolder()
    local folder = Instance.new("Folder")
    folder.Name = "Items"
    folder.Parent = workspace:WaitForChild("RuntimeAssets")

    return folder
end

function ItemService:SpawnItem(location, id)
    local Items = ServerStorage.Assets.ItemModels
    if (Items[id]) then
        local c = Items[id]:Clone()
    end
end

function ItemService:Start()
    ItemsFolder = MakeItemsFolder()
    --> Testing 
    TestItemSpawning()
end


function ItemService:Init()
	
end


return ItemService