local ItemData = {}
local Items = {}

local function LoadAllItems()
    for _, module in pairs(script:GetChildren()) do
        if (module:IsA("ModuleScript")) then
            Items[module.Name] = require(module)
        end
    end
end

local function GetData(id)
    return Items[id]
end

local function GetProperty(id, property)
    local data = Items[id]

    return data[property]
end

ItemData.GetData = GetData
ItemData.GetProperty = GetProperty

LoadAllItems()
return ItemData