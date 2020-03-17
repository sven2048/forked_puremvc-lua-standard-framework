Puremvc = Puremvc or {}
Puremvc.PACKAGE_NAME = "3rdParty.PureMVC"

require(Puremvc.PACKAGE_NAME..".oop")

Puremvc.Observer = require(Puremvc.PACKAGE_NAME..".Patterns.Observer.Observer")
Puremvc.View = require(Puremvc.PACKAGE_NAME..".Core.View")
Puremvc.Model = require(Puremvc.PACKAGE_NAME..".Core.Model")
Puremvc.Controller = require(Puremvc.PACKAGE_NAME..".Core.Controller")
Puremvc.Facade = require(Puremvc.PACKAGE_NAME..".Patterns.Facade.Facade")
Puremvc.Notifier = require(Puremvc.PACKAGE_NAME..".Patterns.Observer.Notifier")

Puremvc.Proxy = require(Puremvc.PACKAGE_NAME..".Patterns.Proxy.Proxy")
Puremvc.Mediator = require(Puremvc.PACKAGE_NAME..".Patterns.Mediator.Mediator")
Puremvc.MacroCommand = require(Puremvc.PACKAGE_NAME .. '.Patterns.Command.MacroCommand')
Puremvc.SimpleCommand = require(Puremvc.PACKAGE_NAME .. '.Patterns.Command.SimpleCommand')
Puremvc.Notification = require(Puremvc.PACKAGE_NAME..".Patterns.Observer.Notification")