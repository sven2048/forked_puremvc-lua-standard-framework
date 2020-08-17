local SimpleCommand = class("SimpleCommand", PureMVC.Notifier)

function SimpleCommand:ctor()
    SimpleCommand.super.ctor(self)
end

function SimpleCommand:Execute(notification)
end

return SimpleCommand