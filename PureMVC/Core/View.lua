---@class PureMVC.View
---@field mediatorMap table<string, PureMVC.Mediator>
---@field observerMap table<string, PureMVC.Observer[]>
local View = class("View")
local instance

function View:ctor()
    assert(instance == nil, "View Singleton already constructed!")
    instance         = self
    self.mediatorMap = {}
    self.observerMap = {}
    self:InitializeView()
end

function View:InitializeView()
end

---@param viewFunc fun():PureMVC.View
---@return PureMVC.View
function View.GetInstance(viewFunc)
    if not instance and type(viewFunc) == "function" then
        instance = viewFunc()
    end
    return instance
end

---@param notificationName string
---@param observer PureMVC.Observer
function View:RegisterObserver(notificationName, observer)
    local observers = self.observerMap[notificationName]
    if not observers then
        observers                          = {}
        self.observerMap[notificationName] = observers
    end
    table.insert(observers, observer)
end

---@param notification PureMVC.Notification
function View:NotifyObservers(notification)
    local notificationName = notification:GetName()
    local observers        = self.observerMap[notificationName]
    if observers then
        for _, v in ipairs(observers) do
            v:NotifyObserver(notification)
        end
    end
end

---@param notificationName string
---@param notifyContext any
function View:RemoveObserver(notificationName, notifyContext)
    local observers = self.observerMap[notificationName]
    if not observers then
        return
    end
    for k, v in ipairs(observers) do
        if v:CompareNotifyContext(notifyContext) then
            table.remove(observers, k)
            break
        end
    end
    if #observers == 0 then
        self.observerMap[notificationName] = nil
    end
end

---@param mediator PureMVC.Mediator
function View:RegisterMediator(mediator)
    local mediatorName = mediator:GetMediatorName()
    if not self:HasMediator(mediatorName) then
        self.mediatorMap[mediatorName] = mediator
        local interests                = mediator:ListNotificationInterests()
        if #interests > 0 then
            local observer = PureMVC.Observer.new(mediator.HandleNotification, mediator)
            for _, v in ipairs(interests) do
                self:RegisterObserver(v, observer)
            end
        end
        mediator:OnRegister()
    end
end

---@param mediatorName string
function View:RetrieveMediator(mediatorName)
    return self.mediatorMap[mediatorName]
end

---@param mediatorName string
---@return PureMVC.Mediator
function View:RemoveMediator(mediatorName)
    local mediator = self:RetrieveMediator(mediatorName)
    if mediator then
        local interests = mediator:ListNotificationInterests()
        if #interests > 0 then
            for _, v in ipairs(interests) do
                self:RemoveObserver(v, mediator)
            end
        end
        self.mediatorMap[mediatorName] = nil
        mediator:OnRemove()
    end
    return mediator
end

---@param mediatorName string
---@return boolean
function View:HasMediator(mediatorName)
    return self:RetrieveMediator(mediatorName) ~= nil
end

return View