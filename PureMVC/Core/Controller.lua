local Controller = class("Controller")
local instance

function Controller:ctor()
    assert(instance == nil, "Controller Singleton already constructed!")
    instance        = self
    self.commandMap = {}
    self:InitializeController()
end

function Controller:InitializeController()
    self.view = PureMVC.View.GetInstance(function()
        return PureMVC.View.new()
    end)
end

function Controller.GetInstance(controllerFunc)
    if not instance and type(controllerFunc) == "function" then
        instance = controllerFunc()
    end
    return instance
end

function Controller:HasCommand(notificationName)
    return self.commandMap[notificationName] ~= nil
end

function Controller:ExecuteCommand(notification)
    local commandFunc     = self.commandMap[notification:GetName()]
    local commandInstance = commandFunc()
    commandInstance:Execute(notification)
end

function Controller:RegisterCommand(notificationName, commandFunc)
    if not self:HasCommand(notificationName) then
        self.view:RegisterObserver(notificationName, PureMVC.Observer.new(self.ExecuteCommand, self))
    end
    self.commandMap[notificationName] = commandFunc
end

function Controller:RemoveCommand(notificationName)
    if not self:HasCommand(notificationName) then
        return
    end
    self.view:RemoveObserver(notificationName, self)
    self.commandMap[notificationName] = nil
end

return Controller