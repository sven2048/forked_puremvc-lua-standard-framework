---@class PureMVC.SimpleCommand : PureMVC.BaseCommand
local SimpleCommand = class("SimpleCommand", PureMVC.BaseCommand)

function SimpleCommand:ctor()
    SimpleCommand.super:ctor()
end

---@param notification PureMVC.Notification
function SimpleCommand:Execute(notification)
end

return SimpleCommand