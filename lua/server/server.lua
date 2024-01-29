local Proxy = require("vrp", "lib/Proxy")
local Tunnel = require("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent('itsruin_discordActive/server/vRPsyncLoop')
AddEventHandler('itsruin_discordActive/server/vRPsyncLoop', function()
    local name = vRP.getPlayerName({source})
    local user_id = vRP.getUserId({source})
    local faction = vRP.getUserGroupByType({user_id, "job"})
	TriggerClientEvent('itsruin_discordActive/client/vRPsync', source, name, user_id, faction)
end)