local SimpleCommand = class("SimpleCommand" ,  Puremvc.Notifier)

function SimpleCommand:ctor()
    SimpleCommand.super.ctor(self)
end

function SimpleCommand:execute(notification)
end

return SimpleCommand