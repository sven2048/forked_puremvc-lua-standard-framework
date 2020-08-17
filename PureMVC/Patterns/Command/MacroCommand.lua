local MacroCommand = class("MacroCommand", PureMVC.Notifier)

function MacroCommand:ctor()
    MacroCommand.super.ctor(self)
    self.subCommands = {}
    self:InitializeMacroCommand()
end

function MacroCommand:InitializeMacroCommand()
end

function MacroCommand:AddSubCommand(commandFunc)
    
    table.insert(self.subCommands, commandFunc)
end

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