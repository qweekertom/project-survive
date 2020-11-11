local item = {}

function item:Fire(Aero, Object)
    local changeTable = {
        Type = "PICKUP",
        Id = Object.Name,
        Object = Object
    }

    Aero.Services.InventoryService:MakeChanges(changeTable)
end

return item