---@class PureMVC.Notification
local Notification = class("Notification")

---@param name string
---@param body any
---@param type string
function Notification:ctor(name, body, type)
    self.name = name
    self.body = body
    self.type = type
end

---@return string
function Notification:GetName()
    return self.name
end

---@return any
function Notification:GetBody()
    return self.body
end

---@return string
function Notification:GetType()
    return self.type
end

---@return string
function Notification:ToString()
    return string.format("Notification Name: %s\nBody: %s\nType: %s", tostring(self.name), tostring(self.body), tostring(self.type))
end

return Notification