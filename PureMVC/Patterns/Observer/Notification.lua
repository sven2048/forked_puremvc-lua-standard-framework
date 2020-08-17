local Notification = class("Notification")

function Notification:ctor(name, body, type)
    self.name = name
    self.body = body
    self.type = type
end

function Notification:GetName()
    return self.name
end

function Notification:GetBody()
    return self.body
end

function Notification:GetType()
    return self.type
end

function Notification:ToString()
    return string.format("Notification Name: %s\nBody: %s\nType: %s", tostring(self.name), tostring(self.body), tostring(self.type))
end

return Notification