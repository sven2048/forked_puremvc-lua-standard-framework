---@class PureMVC.Facade
local Facade = class("Facade")
local instance

function Facade:ctor()
    assert(instance == nil, "Facade Singleton already constructed!")
    instance = self
    self:InitializeFacade()
end

---@param facadeFunc fun():PureMVC.Facade
---@return PureMVC.Facade
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

---@param notificationName string
---@param commandFunc fun():PureMVC.BaseCommand
function Facade:RegisterCommand(notificationName, commandFunc)
    self.controller:RegisterCommand(notificationName, commandFunc)
end

---@param notificationName string
function Facade:RemoveCommand(notificationName)
    self.controller:RemoveCommand(notificationName)
end

---@param notificationName string
function Facade:HasCommand(notificationName)
    return self.controller:HasCommand(notificationName)
end

---@param proxy PureMVC.Proxy
function Facade:RegisterProxy(proxy)
    self.model:RegisterProxy(proxy)
end

---@param proxyName string
---@return PureMVC.Proxy
function Facade:RetrieveProxy(proxyName)
    return self.model:RetrieveProxy(proxyName)
end

---@param proxyName string
---@return PureMVC.Proxy
function Facade:RemoveProxy(proxyName)
    return self.model:RemoveProxy(proxyName)
end

---@param proxyName string
---@return boolean
function Facade:HasProxy(proxyName)
    return self.model:HasProxy(proxyName)
end

---@param mediator PureMVC.Mediator
function Facade:RegisterMediator(mediator)
    self.view:RegisterMediator(mediator)
end

---@param mediatorName string
---@return PureMVC.Mediator
function Facade:RetrieveMediator(mediatorName)
    return self.view:RetrieveMediator(mediatorName)
end

---@param mediatorName string
---@return PureMVC.Mediator
function Facade:RemoveMediator(mediatorName)
    return self.view:RemoveMediator(mediatorName)
end

---@param mediatorName string
---@return boolean
function Facade:HasMediator(mediatorName)
    return self.view:HasMediator(mediatorName)
end

---@param notificationName string
---@param body any
---@param type string
function Facade:SendNotification(notificationName, body, type)
    self:NotifyObservers(PureMVC.Notification.new(notificationName, body, type))
end

---@param notification PureMVC.Notification
function Facade:NotifyObservers(notification)
    self.view:NotifyObservers(notification)
end

return Facade