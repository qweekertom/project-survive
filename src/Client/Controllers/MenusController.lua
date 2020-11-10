-- Menus Controller
-- qweekertom
-- November 10, 2020

local MainGui

local MenusController = {}
local ActiveMenu

local function TweenSize(gui, xSize, time)
    time = time or 0.2
    xSize = xSize or 100
    gui:TweenSize(UDim2.new(0, xSize, 0, 50), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.5, true)
end

function BindMenuButtons()
    for _, btn in pairs(MainGui.Buttons:GetChildren()) do
        if (btn:IsA("TextButton")) then
            btn.MouseButton1Click:Connect(function()
                local menu = MainGui.Menus:FindFirstChild(btn.Name)
                if (ActiveMenu ~= nil and ActiveMenu ~= menu) then --> if a menu is open, and it's not the one we want
                    ActiveMenu.Visible = false
                    menu.Visible = true
                    TweenSize(btn, 110)
                    TweenSize(MainGui.Buttons[ActiveMenu.Name], 100)
                    ActiveMenu = menu
                elseif (ActiveMenu == menu) then --> if the open menu is the one we want, close it
                    menu.Visible = false
                    TweenSize(btn, 100)
                    ActiveMenu = nil
                else --> if there is no open menu, open the one we want
                    menu.Visible = true
                    TweenSize(btn, 110)
                    ActiveMenu = menu
                end
            end)
        end
    end
end

function MenusController:Start()
    MainGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("MainGui")
    BindMenuButtons()
end


function MenusController:Init()
	
end


return MenusController