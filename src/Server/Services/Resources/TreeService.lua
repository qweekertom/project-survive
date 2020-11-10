-- Tree Service
-- qweekertom
-- November 4, 2020

local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")

local Trees = ServerStorage:FindFirstChild("Assets").Trees

local TreeService = {Client = {}}

function RandomTreeSpawn(center, size)
    for x = 1, size.X do
        for y = 1, size.Y do
            
        end
    end
end

function SpawnTrees()
    local spawners = workspace:WaitForChild("RuntimeAssets").TreeSpawners
    local treeModels = Trees:GetChildren()
    local newFolder = Instance.new("Folder")
    newFolder.Name = "Trees"
    newFolder.Parent = workspace

    for _, spawner in pairs(spawners:GetChildren()) do
        local model = treeModels[math.random(1, #treeModels)]:Clone()
        spawn(function()
            PlaceTree(spawner, model, newFolder)
        end)
    end
end

function PlaceTree(spawner, treeModel, folder)
    local c = treeModel:Clone()
    c:SetPrimaryPartCFrame(spawner.CFrame)
    c.Parent = folder

    CollectionService:AddTag(c, "tree")
end

function TreeService:Start()
    SpawnTrees()
	--RandomTreeSpawn(Vector3.new(0,0,0), Vector2.new(100,100))
end


function TreeService:Init()
	
end


return TreeService