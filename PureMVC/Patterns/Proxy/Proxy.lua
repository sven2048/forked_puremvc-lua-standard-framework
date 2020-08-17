---@class PureMVC.Proxy : PureMVC.Notifier
local Proxy = class("Proxy", PureMVC.Notifier)

---@param proxyName string
---@param data any
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

---@return string
function Proxy:GetProxyName()
    return self.proxyName
end

---@return any
function Proxy:GetData()
    return self.data
end

return Proxy