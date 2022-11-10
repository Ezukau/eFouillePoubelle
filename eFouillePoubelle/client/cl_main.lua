ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

local egal = false
local Cooldown = false

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

function Start_Fouille()
	egal = true
	while egal do
		for k,v in pairs(Config.Item_List) do
			random = math.random(1, #Config.Item_List)
			id = v.id
			item = v.content
            nb = v.number

			if random == id then
				egal = false
                TriggerServerEvent('ePoubelle:fouille', item, nb)
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())
                break
			end
		end
		Citizen.Wait(1000)
	end
end

Citizen.CreateThread(function()
    while true do
        local wait = 1000

        local object, dist = ESX.Game.GetClosestObject()
        local model = GetEntityModel(object)
        local coord = GetEntityCoords(object)


        for k,v in pairs(Config.Props) do 
            if model == v.model then

                if dist <= 2 and Cooldown == false then
                    wait = 0
                    DrawMarker(0, coord.x, coord.y, coord.z + 1.5, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.2, 0.2, 0.2, 255, 20, 20, 180, false, true, p19, false)
                end

                if dist <= 2 and Cooldown == false then
                    wait = 0
                    ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour fouiller la poubelle.')
                    if IsControlJustPressed(1, 51) then
                        loadAnimDict("mini@repair")
                        TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 2.0, 2.0, -1, 1, 0, false, false, false)
                        Wait(5000)
                        Start_Fouille()
                        Cooldown = true
                        Wait(Config.Cooldown * 1000)
                        Cooldown = false
                    end
                end

            end
        end
        Citizen.Wait(wait)
    end
end)