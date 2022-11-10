ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('ePoubelle:fouille')
AddEventHandler('ePoubelle:fouille', function(item, nb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, nb)
    TriggerClientEvent('esx:showNotification', source, 'Vous avez trouver x~'..Config.Couleur..'~'..nb..'~s~, ~'..Config.Couleur..'~'..ESX.GetItemLabel(item)..'~s~.')
end)