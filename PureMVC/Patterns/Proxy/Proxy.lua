local Proxy = class("Proxy", PureMVC.Notifier)

function Proxy:ctor(proxyName, data)
    if not proxyName then
        proxyName = "Proxy"
    end
    self.proxyName = proxyName
    self.data      = data
end

function Proxy:OnRegister()
end

function Proxy:OnRemove()
end

function Proxy:GetProxyName()
    return self.proxyName
end

function Proxy:GetData()
    return self.data
end

return Proxy