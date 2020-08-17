local Mediator = class("Mediator", PureMVC.Notifier)

function Mediator:ctor(mediatorName, viewComponent)
    if not mediatorName then
        mediatorName = "Mediator"
    end
    self.mediatorName  = mediatorName
    self.viewComponent = viewComponent
end

function Mediator:GetMediatorName()
    return self.mediatorName
end

function Mediator:GetViewComponent()
    return self.viewComponent
end

function Mediator:ListNotificationInterests()
    return {}
end

function Mediator:HandleNotification(notification)
end

function Mediator:OnRegister()
end

function Mediator:OnRemove()
end

return Mediator