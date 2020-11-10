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

function ItemService:SpawnItem(location, id)
    local Items = ServerStorage.Assets.ItemModels
    if (Items[id]) then
        local c = Items[id]:Clone()
        local cf = CFrame.new(location)
        c:SetPrimaryPartCFrame(cf)
        c.Parent = ItemsFolder
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