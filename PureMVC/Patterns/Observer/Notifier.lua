local Notifier = class("Notifier")

function Notifier:ctor()
end

function Notifier:sendNotification(notificationName,body,type)
    local facade = Notifier.getFace()
    if facade then
        facade:sendNotification(notificationName,body,type)
    end
end

function Notifier.getFace()
    return Puremvc.Facade.getInstance(function() return Puremvc.Facade.new() end)
end

return Notifier