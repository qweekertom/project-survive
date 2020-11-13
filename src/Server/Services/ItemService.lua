-- Item Service
-- Username
-- November 4, 2020

local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ItemsFolder

local ItemService = {Client = {}}

local function TestItemSpawning()
    local origin = Vector3.new(136, 12.5, 138)
    local items = {
        "ammo_pistol";
        --"ammo_rifle",
        --"brick"
    }
    for x=1, 4 do
        for z=1, 4 do
            local position = origin + Vector3.new(x*4, 0, z*4)
            local randomItem = math.random(1, #items)
            ItemService:SpawnItem(position, items[randomItem])
        end
    end
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

    if (typeof(location) == "Vector3") then
        location = CFrame.new(location)
    end

    local randomRotation = math.rad(math.random(0, 360))
    local cframe = location * CFrame.Angles(0, randomRotation, 0)
    
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