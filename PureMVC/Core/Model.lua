local Model = class("Model")
local instance

function Model:ctor()
    assert(instance == nil , "Model Singleton already constructed!")
    instance = self
    self.proxyMap = {}
    self:initializeModel()
end

function Model:initializeModel()
end

function Model.getInstance(modelFunc)
    if not instance and type(modelFunc) == "function" then
        instance = modelFunc()
    end
    return instance
end

function Model:registerProxy(proxy)
    self.proxyMap[proxy:getProxyName()] = proxy;
    proxy:onRegister();
end

function Model:retrieveProxy(proxyName)
    return self.proxyMap[proxyName]
end

function Model:removeProxy(proxyName)
    local proxy = self:retrieveProxy(proxyName)
    if proxy then
        self.proxyMap[proxyName] = nil
        proxy:onRemove()
    end
    return proxy
end

function Model:hasProxy(proxyName)
    return self:retrieveProxy(proxyName) ~= nil
end

return Model