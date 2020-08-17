---@class PureMVC.Observer
local Observer = class("Observer")

---@param notifyMethod fun(notification:PureMVC.Notification):void
---@param notifyContext any
function Observer:ctor(notifyMethod, notifyContext)
    self.notifyMethod  = notifyMethod
    self.notifyContext = notifyContext
end

---@return any
function Observer:GetNotifyContext()
    return self.notifyContext
end

---@param notification PureMVC.Notification
function Observer:NotifyObserver(notification)
    if self.notifyMethod and type(self.notifyMethod) == "function" then
        self.notifyMethod(self.notifyContext, notification)
    end
end

---@param notifyContext any
function Observer:CompareNotifyContext(notifyContext)
    return self.notifyContext == notifyContext
end

return Observer