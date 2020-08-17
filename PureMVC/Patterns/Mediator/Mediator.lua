---@class PureMVC.Mediator : PureMVC.Notifier
local Mediator = class("Mediator", PureMVC.Notifier)

---@param mediatorName string
---@param viewComponent table
function Mediator:ctor(mediatorName, viewComponent)
    if not mediatorName then
        mediatorName = "Mediator"
    end
    self.mediatorName  = mediatorName
    self.viewComponent = viewComponent
end

---@return string
function Mediator:GetMediatorName()
    return self.mediatorName
end

---@return table
function Mediator:GetViewComponent()
    return self.viewComponent
end

---@return string[]
function Mediator:ListNotificationInterests()
    return {}
end

---@param notification PureMVC.Notification
function Mediator:HandleNotification(notification)
end

function Mediator:OnRegister()
end

function Mediator:OnRemove()
end

return Mediator