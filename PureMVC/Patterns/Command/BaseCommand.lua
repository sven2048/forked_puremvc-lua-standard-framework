---@class PureMVC.BaseCommand : PureMVC.Notifier
local BaseCommand = class("BaseCommand", PureMVC.Notifier)

function BaseCommand:ctor()
    BaseCommand.super:ctor()
end

---@param notification PureMVC.Notification
function BaseCommand:Execute(notification)
end

return BaseCommand