-- Player Service
-- qweekertom
-- November 4, 2020

local Players = game:GetService("Players")

local PlayerService = {Client = {}}


function PlayerService:Start()
    --> player joining
    Players.PlayerAdded:Connect(function(plr)
        self.Services.InventoryService:MakeInventory(plr)
        plr.CharacterAdded:Connect(function(character)
            self.Services.StarterToolService:GivePlayerTools(plr)
        end)
    end)

    --> player removing
    Players.PlayerRemoving:Connect(function(plr)
        
    end)
end


function PlayerService:Init()
	
end


return PlayerService