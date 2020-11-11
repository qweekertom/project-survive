local item = {}

function item:Fire(Aero, Object)
    Aero.Services.InventoryService:PickupItem(Object)
end

return item