-- Starter Tool Service
-- qweekertom
-- November 4, 2020

local ServerStorage = game:GetService("ServerStorage")
local StarterTools

local StarterToolService = {Client = {}}

function StarterToolService:GivePlayerTools(player)
    local Tools = StarterTools:GetChildren()
    for _, tool in pairs(Tools) do
        local c = tool:Clone()
        c.Parent = player.Backpack
    end
end

function StarterToolService:Start()
	StarterTools = ServerStorage.Assets:WaitForChild("StarterTools")
end


function StarterToolService:Init()
	
end


return StarterToolService