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

function View.GetInstance(viewFunc)
    if not instance and type(viewFunc) == "function" then
        instance = viewFunc()
    end
    return instance
end

function View:RegisterObserver(notificationName, observer)
    local observers = self.observerMap[notificationName]
    if not observers then
        observers                          = {}
        self.observerMap[notificationName] = observers
    end
    table.insert(observers, observer)
end

function View:NotifyObservers(notification)
    local notificationName = notification:GetName()
    local observers        = self.observerMap[notificationName]
    if observers then
        for _, v in ipairs(observers) do
            v:NotifyObserver(notification)
        end
    end
end

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

function View:RetrieveMediator(mediatorName)
    return self.mediatorMap[mediatorName]
end

function View:RemoveMediator(mediatorName)
    local mediator = self:RetrieveMediator(mediatorName)
    if mediator then
        local interests = mediator:ListNotificationInterests()
        if #interests > 0 then
            for _, v in ipairs(interests) do
                self:RemoveObserver(v, mediator)
            end
        end
        mediator:OnRemove()
    end
    return mediator
end

function View:HasMediator(mediatorName)
    return self:RetrieveMediator(mediatorName) ~= nil
end

return View