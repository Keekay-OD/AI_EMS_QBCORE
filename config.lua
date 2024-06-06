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

Config.UsingPhone = true -- Set to true if using a phone system
Config.Phone = "lb-phone" -- Options: "lb-phone", "qb-smartphone", "qs-smartphone"
Config.SMS = true -- Set to true if using a phone system and want to send SMS when the player is revived
Config.SMSSender = "VC Medical"  -- This is where you can change the text message sender name if using the phone. 
