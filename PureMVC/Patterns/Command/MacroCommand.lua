local MacroCommand = class("MacroCommand" , Puremvc.Notifier)

function MacroCommand:ctor()
    MacroCommand.super.ctor(self)
    self.subcommands = {}
    self:initializeMacroCommand()
end

function MacroCommand:initializeMacroCommand()
end

function MacroCommand:addSubCommand(commandFunc)
    table.insert(self.subcommands , commandFunc)
end

function MacroCommand:execute(notification)
    if #self.subcommands == 0 then
        return
    end
    for _, commandFunc in ipairs(self.subcommands) do
        local commandInstance = commandFunc()
        commandInstance:execute(notification)
    end
    self.subcommands = {}
end

return MacroCommand