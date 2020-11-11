-- Menus Controller
-- qweekertom
-- November 10, 2020

local MainGui

local MenusController = {}
local ActiveMenu

local function SetActiveColor(gui, isActive)
    if isActive then
        gui.BackgroundColor3 = Color3.fromRGB(248, 255, 201)
    else
        gui.BackgroundColor3 = Color3.fromRGB(255,255,255)
    end
end

function BindMenuButtons()
    for _, btn in pairs(MainGui.Buttons:GetChildren()) do
        if (btn:IsA("TextButton")) then
            btn.MouseButton1Click:Connect(function()
                local menu = MainGui.Menus:FindFirstChild(btn.Name)
                if (ActiveMenu ~= nil and ActiveMenu ~= menu) then --> if a menu is open, and it's not the one we want
                    ActiveMenu.Visible = false
                    menu.Visible = true
                    SetActiveColor(btn, true)
                    SetActiveColor(MainGui.Buttons[ActiveMenu.Name], false)
                    ActiveMenu = menu
                elseif (ActiveMenu == menu) then --> if the open menu is the one we want, close it
                    menu.Visible = false
                    SetActiveColor(btn, false)
                    ActiveMenu = nil
                else --> if there is no open menu, open the one we want
                    menu.Visible = true
                    SetActiveColor(btn, true)
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