local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent('h_discordActive:server:vRPsyncLoop')
AddEventHandler('h_discordActive:server:vRPsyncLoop', function()
    local name = vRP.getPlayerName({source})
    local user_id = vRP.getUserId({source})
    local faction = vRP.getUserGroupByType({user_id, "job"})    
	TriggerClientEvent('h_discordActive:client:vRPsync', source, name, user_id, faction)
end)