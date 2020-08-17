---@class PureMVC.Model
---@field proxyMap table<string, PureMVC.Proxy>
local Model = class("Model")
local instance

function Model:ctor()
    assert(instance == nil, "Model Singleton already constructed!")
    instance      = self
    self.proxyMap = {}
    self:InitializeModel()
end

function Model:InitializeModel()
end

---@param modelFunc fun()
---@return PureMVC.Model
function Model.GetInstance(modelFunc)
    if not instance and type(modelFunc) == "function" then
        instance = modelFunc()
    end
    return instance
end

---@param proxy PureMVC.Proxy
function Model:RegisterProxy(proxy)
    self.proxyMap[proxy:GetProxyName()] = proxy
    proxy:OnRegister()
end

---@param proxyName string
---@return PureMVC.Proxy
function Model:RetrieveProxy(proxyName)
    return self.proxyMap[proxyName]
end

---@param proxyName string
---@return PureMVC.Proxy
function Model:RemoveProxy(proxyName)
    local proxy = self:RetrieveProxy(proxyName)
    if proxy then
        self.proxyMap[proxyName] = nil
        proxy:OnRemove()
    end
    return proxy
end

---@param proxyName string
---@return boolean
function Model:HasProxy(proxyName)
    return self:RetrieveProxy(proxyName) ~= nil
end

return Model