local Notifier = class("Notifier")

function Notifier:ctor()
end

function Notifier:SendNotification(notificationName, body, type)
    local facade = Notifier.GetFacade()
    if facade then
        facade:SendNotification(notificationName, body, type)
    end
end

function Notifier.GetFacade()
    return PureMVC.Facade.GetInstance(function()
        return PureMVC.Facade.new()
    end)
end

return Notifier