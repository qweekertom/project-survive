-- Runtime Service
-- qweekertom
-- November 4, 2020

local ServerStorage = game:GetService("ServerStorage")
local RuntimeAssets = ServerStorage:FindFirstChild("RuntimeAssets")

local WorkspaceAssets

local RuntimeService = {Client = {}}
local Folders = {}

function MakeAssetsFolder(parent)
    local folder = Instance.new("Folder")
    folder.Name = "RuntimeAssets"
    folder.Parent = parent

    return folder
end

function RuntimeService:GetFolder(name)
    return Folders[name]
end

function RuntimeService:Start()
    game.Workspace:FindFirstChild("RuntimeDestroy"):Destroy()
    WorkspaceAssets = MakeAssetsFolder(workspace)

    for _, runtimeAsset in pairs(RuntimeAssets:GetChildren()) do
        runtimeAsset.Parent = WorkspaceAssets
        if (runtimeAsset:IsA("Folder")) then
            Folders[runtimeAsset.Name] = runtimeAsset
        end
    end
end


function RuntimeService:Init()
	
end


return RuntimeService