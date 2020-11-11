-- Interactions
-- qweekertom
-- November 10, 2020

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")

local InteractionController = {}
local Interactions = {}

local TAG_NAME = "interact"
local PromptDistance = 10
local Prompt

local currentInteraction = nil

local function HandleInput(name, state, object)
    if (state == Enum.UserInputState.End) then
        InteractionController:OnInput()
    end
end

local function Stepped(dt)
    local objects = CollectionService:GetTagged(TAG_NAME)
    local closest = {object = nil, distance = math.huge}
    for _, obj in pairs(objects) do
        local pos = obj.PrimaryPart.Position
        local distance = game.Players.LocalPlayer:DistanceFromCharacter(pos)
        if (distance <= PromptDistance) and (distance < closest.distance) then
            closest.distance = distance
            closest.object = obj
        end
        
        if (closest.object) then
            Prompt.Enabled = true
            Prompt.Adornee = closest.object
            currentInteraction = closest.object
        else
            Prompt.Enabled = false
            Prompt.Adornee = nil
            currentInteraction = nil
        end
        
    end
end

function InteractionController:OnInput()
    if (currentInteraction) then
        for t,m in pairs(Interactions) do
            if (CollectionService:HasTag(currentInteraction, t)) then
                m:Fire(self, currentInteraction)
            end
        end
    else
        return
    end
end

function InteractionController:Setup()
    for _, module in pairs(script:GetChildren()) do
        if (module:IsA("ModuleScript")) then
            local m = require(module)
            Interactions[module.Name] = m
        end
    end
end

function InteractionController:Start()
    local key = self.Modules.Keybinds[TAG_NAME]
    self:Setup()
    Prompt = self.Player.PlayerGui:WaitForChild("Interaction")
    RunService:BindToRenderStep("interaction",1,Stepped)
    ContextActionService:BindAction("interaction",HandleInput,false,key)
end


function InteractionController:Init()
	
end


return InteractionController