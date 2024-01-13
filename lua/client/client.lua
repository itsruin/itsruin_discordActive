local loopTime = 2500 -- ms

local discordAppId = 000000000
local discordRichPresenceNameB = ""
local discordRichPresenceNameS = ""

Citizen.CreateThread(function()
    while true do
        TriggerServerEvent('itsruin_discordActive/server/vRPsyncLoop')
		Wait(5 * 60 * 1000)
	end
end)

RegisterNetEvent('itsruin_discordActive/client/vRPsync')
AddEventHandler('itsruin_discordActive/client/vRPsync', function(name, user_id, faction)
    local vRPsync = ""..name.. " ("..user_id.."번 · "..faction..")"

    Citizen.CreateThread(function()
        SetDiscordAppId(discordAppId)
        SetDiscordRichPresenceAsset(discordRichPresenceNameB)
        SetDiscordRichPresenceAssetSmall(discordRichPresenceNameS)
        while true do
            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
            local streetHash = GetStreetNameAtCoord(x,y,z)

            Citizen.Wait(loopTime)

            if streetHash ~= nil then
                streetName = GetStreetNameFromHashKey(streetHash)

                if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
    		    	if IsPedSprinting(PlayerPedId()) then
    		    		SetRichPresence("".. streetName .."에서 빠르게 뛰는 중\n".. vRPsync .."")
    		    	elseif IsPedRunning(PlayerPedId()) then
    		    		SetRichPresence("".. streetName .."에서 뛰는 중\n".. vRPsync .."")
    		    	elseif IsPedWalking(PlayerPedId()) then
    		    		SetRichPresence("".. streetName .."에서 걷는 중\n".. vRPsync .."")
    		    	elseif IsPedStill(PlayerPedId()) then
    		    		SetRichPresence("".. streetName .."에 서 있는 중\n".. vRPsync .."")
    		    	end
                elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
    		    	local vehicleSpeed = GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId()))
    		    	local curSpeed = math.ceil(vehicleSpeed * 3.6) or math.ceil(vehicleSpeed * 2.236936)
    		    	if curSpeed > 150 then
                    SetRichPresence("".. streetName .."에서 과속 운전하는 중 (규정속도 초과)\n".. vRPsync .."")
    		    	elseif curSpeed <= 150 and curSpeed > 0 then
                        SetRichPresence("".. streetName .."에서 안전 운전하는 중 (규정속도 이하)\n".. vRPsync .."")
    		    	elseif curSpeed == 0 then
    		    		SetRichPresence(""..streetName.."에 정차해 있는 중\n".. vRPsync .."")
    		    	end
                elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
    		    	if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
                        SetRichPresence("".. streetName .." 상공에 있는 중 (비행기/헬기 탑승 중)\n".. vRPsync .."")
    		    	else
                        SetRichPresence("".. streetName .." 지상에 있는 중 (비행기/헬기 탑승 중)\n".. vRPsync .."")
    		    	end
                elseif IsEntityInWater(PlayerPedId()) then
    		    	SetRichPresence("어딘가에서 수영하는 중\n".. vRPsync .."")
    		    elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
                    SetRichPresence("바다에서 항해 중 (보트/선박 탑승 중)\n".. vRPsync .."")
    		    elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
    		    	SetRichPresence("바다에서 잠수 중\n".. vRPsync .."")
                end
            end
            SetDiscordRichPresenceAssetSmallText("현재 체력 : ".. (GetEntityHealth(player)))
            SetDiscordRichPresenceAction(0, "디스코드", "https://discord.gg/hybe")
            SetDiscordRichPresenceAction(1, "서버접속", "fivem://connect/103.156.23.65:30120")
        end
    end)
end)