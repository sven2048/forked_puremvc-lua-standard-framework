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

function Model.GetInstance(modelFunc)
    if not instance and type(modelFunc) == "function" then
        instance = modelFunc()
    end
    return instance
end

function Model:RegisterProxy(proxy)
    self.proxyMap[proxy:GetProxyName()] = proxy
    proxy:OnRegister()
end

function Model:RetrieveProxy(proxyName)
    return self.proxyMap[proxyName]
end

function Model:RemoveProxy(proxyName)
    local proxy = self:RetrieveProxy(proxyName)
    if proxy then
        self.proxyMap[proxyName] = nil
        proxy:OnRemove()
    end
    return proxy
end

function Model:HasProxy(proxyName)
    return self:RetrieveProxy(proxyName) ~= nil
end

return Model