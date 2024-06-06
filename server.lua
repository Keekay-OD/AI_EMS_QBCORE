local QBCore = exports['qb-core']:GetCoreObject()
local repositoryOwner = "Keekay-OD"
local repositoryName = "vibes-ems"

local function GetLatestReleaseVersion()
    local localVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
    print("^2Vibes^7-^2EMS v^3" .. localVersion .. " ^7- ^2EMS Script by ^1Keekay_YKTV^7")
    
    print("^2Checking for updates...")
    
    local loadingFrames = {"^7[^1-^7]", "^7[^1\\^7]", "^7[^1|^7]", "^7[^1/^7]"}
    local loadingIndex = 1
    
    local function printLoading()
        Citizen.CreateThread(function()
            while loadingIndex > 0 do
                Citizen.Wait(200)
                if loadingIndex > #loadingFrames then
                    loadingIndex = 1
                end
                if loadingIndex > 0 then
                    print(loadingFrames[loadingIndex] .. " ^2Retrieving latest release information...")
                    loadingIndex = loadingIndex + 1
                end
            end
        end)
    end
    
    printLoading()
    
    local request = PerformHttpRequest("https://api.github.com/repos/" .. repositoryOwner .. "/" .. repositoryName .. "/releases/latest", function(statusCode, responseText, headers)
        if statusCode == 200 then
            local releaseData = json.decode(responseText)
            local latestVersion = releaseData.tag_name
            if string.sub(latestVersion, 1, 1) == "v" then
                latestVersion = string.sub(latestVersion, 2)
            end
            
            -- Stop the loading animation
            loadingIndex = 0
            
            -- Version comparison logic
            if localVersion < latestVersion then
				Wait(1000)
                print("^1Your version is out of date!")
                print("^7You are using version: ^1" .. localVersion)
                print("^7A new version is available: ^2" .. latestVersion)
                -- Perform any additional actions you want to take when a new version is available
            elseif localVersion > latestVersion then
				Wait(1000)
                print("^9Shoutouts to you for being a part of the Vibes Dev Team.")
				Wait(1000)
                print("^7You are using a newer version: ^9" .. tostring(localVersion))
				Wait(1000)
                print("^7The latest public release version is: ^2" .. latestVersion)
                -- Perform any additional actions for testers using a newer version
            else
				Wait(1000)
                print("^7You are using the latest version: ^2" .. localVersion)
            end

        else
            -- Stop the loading animation
            loadingIndex = 0
            
            print("^1Failed to retrieve the latest release information. Status Code: " .. statusCode)
        end
    end, "GET", "", { ["Content-Type"] = "application/json" })
end

-- Register the resource start event handler
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        GetLatestReleaseVersion()
    end
end)

QBCore.Functions.CreateCallback('hhfw:docOnline', function(source, cb)
	local src = source
	local Ply = QBCore.Functions.GetPlayer(src)
	local xPlayers = QBCore.Functions.GetPlayers()
	local doctor = 0
	local canpay = false
	if Ply.PlayerData.money["cash"] >= Config.Price then
		canpay = true
	else
		if Ply.PlayerData.money["bank"] >= Config.Price then
			canpay = true
		end
	end

	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
		if xPlayer.PlayerData.job.name == 'ambulance' then
			doctor = doctor + 1
		end
	end

	cb(doctor, canpay)
end)



RegisterServerEvent('hhfw:charge')
AddEventHandler('hhfw:charge', function()
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.PlayerData.money["cash"] >= Config.Price then
		xPlayer.Functions.RemoveMoney("cash", Config.Price)
	else
		xPlayer.Functions.RemoveMoney("bank", Config.Price)
	end
	TriggerEvent("qb-bossmenu:server:addAccountMoney", 'ambulance', Config.Price)
end)
