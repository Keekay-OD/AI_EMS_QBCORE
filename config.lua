-------------------
-- CONFIG --
-------------------
Config = {}

Config.Doctor = 1 -- Minimum Amount of EMS to work
Config.Price = 150 -- Price to call EMS
Config.ReviveTime = 10000  --in msec
Config.UseHelpCommand = true -- /help command to show the help message
Config.NotifyType = "okok" -- Options: "qb", "okok", "mythic", "custom"
Config.CustomNotifyFunction = nil -- Set this to your custom notification function if NotifyType is "custom"