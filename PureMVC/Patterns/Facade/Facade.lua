local Facade = class("Facade")
local instance

function Facade:ctor()
    assert(instance == nil , "Facade Singleton already constructed!")
    instance = self
    self:initializeFacade()
end

function Facade.getInstance(facadeFunc)
    if not instance and type(facadeFunc) == "function" then
        instance = facadeFunc()
    end
    return instance
end

function Facade:initializeFacade()
    self:initializeModel();
    self:initializeController();
    self:initializeView();
end

function Facade:initializeModel()
    self.model = Puremvc.Model.getInstance(function() return Puremvc.Model.new() end)
end

function Facade:initializeController()
    self.controller = Puremvc.Controller.getInstance(function() return Puremvc.Controller.new() end)
end

function Facade:initializeView()
    self.view = Puremvc.View.getInstance(function() return Puremvc.View.new() end)
end

function Facade:registerCommand(notificationName,commandFunc)
    self.controller:registerCommand(notificationName,commandFunc)
end

function Facade:removeCommand(notificationName)
    self.controller:removeCommand(notificationName)
end

function Facade:hasCommand(notificationName)
    return self.controller:hasCommand(notificationName)
end

function Facade:registerProxy(proxy)
    self.model:registerProxy(proxy)
end

function Facade:retrieveProxy(proxyName)
    return self.model:retrieveProxy(proxyName)
end

function Facade:removeProxy(proxyName)
    return self.model:removeProxy(proxyName)
end

function Facade:hasProxy(proxyName)
    return self.model:hasProxy(proxyName)
end

function Facade:registerMediator(mediator)
    self.view:registerMediator(mediator)
end

function Facade:retrieveMediator(mediatorName)
    return self.view:retrieveMediator(mediatorName)
end

function Facade:removeMediator(mediatorName)
    return self.view:removeMediator(mediatorName)
end

function Facade:hasMediator(mediatorName)
    return self.view:hasMediator(mediatorName)
end

function Facade:sendNotification(notificationName , body , type)
    self:notifyObservers(Puremvc.Notification.new(notificationName , body, type))
end

function Facade:notifyObservers(notification)
    self.view:notifyObservers(notification)
end

return Facade