-- Runtime Service
-- qweekertom
-- November 4, 2020

local ServerStorage = game:GetService("ServerStorage")
local RuntimeAssets = ServerStorage:FindFirstChild("RuntimeAssets")

local WorkspaceAssets

local RuntimeService = {Client = {}}

function MakeAssetsFolder(parent)
    local folder = Instance.new("Folder")
    folder.Name = "RuntimeAssets"
    folder.Parent = parent

    return folder
end

function RuntimeService:Start()
    WorkspaceAssets = MakeAssetsFolder(workspace)

    for _, runtimeAsset in pairs(RuntimeAssets:GetChildren()) do
        runtimeAsset.Parent = WorkspaceAssets
    end
end


function RuntimeService:Init()
	
end


return RuntimeService