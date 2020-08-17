local Facade = class("Facade")
local instance

function Facade:ctor()
    assert(instance == nil, "Facade Singleton already constructed!")
    instance = self
    self:InitializeFacade()
end

function Facade.GetInstance(facadeFunc)
    if not instance and type(facadeFunc) == "function" then
        instance = facadeFunc()
    end
    return instance
end

function Facade:InitializeFacade()
    self:InitializeModel()
    self:InitializeController()
    self:InitializeView()
end

function Facade:InitializeModel()
    self.model = PureMVC.Model.GetInstance(function()
        return PureMVC.Model.new()
    end)
end

function Facade:InitializeController()
    self.controller = PureMVC.Controller.GetInstance(function()
        return PureMVC.Controller.new()
    end)
end

function Facade:InitializeView()
    self.view = PureMVC.View.GetInstance(function()
        return PureMVC.View.new()
    end)
end

function Facade:RegisterCommand(notificationName, commandFunc)
    self.controller:RegisterCommand(notificationName, commandFunc)
end

function Facade:RemoveCommand(notificationName)
    self.controller:RemoveCommand(notificationName)
end

function Facade:HasCommand(notificationName)
    return self.controller:HasCommand(notificationName)
end

function Facade:RegisterProxy(proxy)
    self.model:RegisterProxy(proxy)
end

function Facade:RetrieveProxy(proxyName)
    return self.model:RetrieveProxy(proxyName)
end

function Facade:RemoveProxy(proxyName)
    return self.model:RemoveProxy(proxyName)
end

function Facade:HasProxy(proxyName)
    return self.model:HasProxy(proxyName)
end

function Facade:RegisterMediator(mediator)
    self.view:RegisterMediator(mediator)
end

function Facade:RetrieveMediator(mediatorName)
    return self.view:RetrieveMediator(mediatorName)
end

function Facade:RemoveMediator(mediatorName)
    return self.view:RemoveMediator(mediatorName)
end

function Facade:HasMediator(mediatorName)
    return self.view:HasMediator(mediatorName)
end

function Facade:SendNotification(notificationName, body, type)
    self:NotifyObservers(PureMVC.Notification.new(notificationName, body, type))
end

function Facade:NotifyObservers(notification)
    self.view:NotifyObservers(notification)
end

return Facade