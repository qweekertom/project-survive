-- Character Controller
-- Username
-- November 11, 2020



local CharacterController = {}

local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")

local MaterialTable = {
    --> grass
    [Enum.Material.Grass] = "rbxassetid://3208634618",
    [Enum.Material.Mud] = "rbxassetid://3208634618",

    --> woods
    [Enum.Material.Wood] = "rbxassetid://3199270096",
    [Enum.Material.WoodPlanks] = "rbxassetid://3199270096",

    --> metals
    [Enum.Material.Metal] = "rbxassetid://3205591350",
    [Enum.Material.DiamondPlate] = "rbxassetid://3205591350",
    [Enum.Material.CorrodedMetal] = "rbxassetid://3205591350",

    --> stones
    [Enum.Material.Concrete] = "rbxassetid://3190903775",
    [Enum.Material.Slate] = "rbxassetid://3190903775",
    [Enum.Material.Cobblestone] = "rbxassetid://3190903775",
    [Enum.Material.Rock] = "rbxassetid://3190903775"
}

function CharacterController:Start()

    --ContentProvider:PreloadAsync(Assets)

    Players.LocalPlayer.CharacterAdded:Connect(function(Character)
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        local Running = HumanoidRootPart:WaitForChild("Running")
        local DefaultSound = Running.SoundId
        Running.PlaybackSpeed = 1.5

        Character.Humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
            local FloorMaterial = Character.Humanoid.FloorMaterial
            if MaterialTable[FloorMaterial] then
                Running.SoundId = MaterialTable[FloorMaterial]
            else
                Running.SoundId = DefaultSound
            end
        end)
    end)
    
end


function CharacterController:Init()
	
end


return CharacterController