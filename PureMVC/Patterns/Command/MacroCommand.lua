---@class PureMVC.MacroCommand : PureMVC.BaseCommand
---@field subCommands PureMVC.BaseCommand[]
local MacroCommand = class("MacroCommand", PureMVC.BaseCommand)

function MacroCommand:ctor()
    MacroCommand.super:ctor()
    self.subCommands = {}
    self:InitializeMacroCommand()
end

function MacroCommand:InitializeMacroCommand()
end

---@param commandFunc fun():PureMVC.BaseCommand
function MacroCommand:AddSubCommand(commandFunc)
    
    table.insert(self.subCommands, commandFunc)
end

---@param notification PureMVC.Notification
function MacroCommand:Execute(notification)
    if #self.subCommands == 0 then
        return
    end
    for _, commandFunc in ipairs(self.subCommands) do
        local commandInstance = commandFunc()
        commandInstance:Execute(notification)
    end
    self.subCommands = {}
end

return MacroCommand