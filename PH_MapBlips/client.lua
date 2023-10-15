ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports.es_extended:getSharedObject()
		Citizen.Wait(0)
	end
end)

local state = false
local Blips = {}

RegisterNetEvent('PH_MapBlips:ShowBlippolice')
AddEventHandler('PH_MapBlips:ShowBlippolice', function()
    state = true

    for k,v in pairs (Config.PH_MapBlipspolice) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, v.blip)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.scale)
        SetBlipColour(blip, v.color)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.display)
        EndTextCommandSetBlipName(blip)
        table.insert(Blips, blip)
    end

    if Config.EnableBlipTime then
        Citizen.Wait(Config.BlipTime * 1000)
        TriggerEvent('PH_MapBlips:RemoveBlip')
    end
end)
--NEW SECTION HERE--
RegisterNetEvent('PH_MapBlips:ShowBlipNEWBLIPNAME')
AddEventHandler('PH_MapBlips:ShowBlipNEWBLIPNAME', function()
    state = true

    for k,v in pairs (Config.PH_MapBlipsNEWBLIPNAME) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, v.blip)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.scale)
        SetBlipColour(blip, v.color)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.display)
        EndTextCommandSetBlipName(blip)
        table.insert(Blips, blip)
    end

    if Config.EnableBlipTime then
        Citizen.Wait(Config.BlipTime * 1000)
        TriggerEvent('PH_MapBlips:RemoveBlip')
    end
end)
--END OF NEW SECTION__

RegisterNetEvent('PH_MapBlips:ShowBlipambulance')
AddEventHandler('PH_MapBlips:ShowBlipambulance', function()
    state = true

    for k,v in pairs (Config.PH_MapBlipsambulance) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, v.blip)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.scale)
        SetBlipColour(blip, v.color)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.display)
        EndTextCommandSetBlipName(blip)
        table.insert(Blips, blip)
    end

    if Config.EnableBlipTime then
        Citizen.Wait(Config.BlipTime * 1000)
        TriggerEvent('PH_MapBlips:RemoveBlip')
    end
end)

RegisterNetEvent('PH_MapBlips:RemoveBlippolice')
AddEventHandler('PH_MapBlips:RemoveBlippolice', function()
    state = false

    for i=1, #Blips, 1 do
        RemoveBlip(Blips[i])
        Blips[i] = nil
    end
end)


function debug(msg)
	if Config.Debug then
		print(msg)
	end
end


local Blips = {--This is Just the Naming of the Names shown in the Menu!
	'Delete new Markers',
	'Police',
	'Ambulance',
	'Something'
}

local MapOptions = {
	{label = Blips[1],value = 'no/delete'},
	{label = Blips[2],value = 'police'},
	{label = Blips[3],value = 'ambulance'},
	{label = Blips[4],value = 'something'}
}

local yesno = {--This is Just the Naming of the Names shown in the Menu!
	'Yes'
}

local yesnoOptions = {
	{label = yesno[1],value = 'yes'}
}

function BlipMenu(selectedOption)
	ESX.UI.Menu.Open(
		'default',
		GetCurrentResourceName(), 'my_blipmenu',
		{
			title = 'Blips',
			align = 'bottom-right',
			elements = MapOptions,
		},
		function(data,menu)
			local selectedOption = data.current.value
			local player = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(player,false)
			if Config.DebugMenu == true then 
				print(selectedOption)
                --print(json.encode(Config.PH_MapBlips[1])) -- if you feel like something is wrong enable this print and check for the right value in []
				
			end
			if data.current.value == 'no/delete' then 
				TriggerEvent('PH_MapBlips:RemoveBlippolice')
			end

			if data.current.value == 'police' then 
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'my_blipmenu2',
			{
				title = 'Blips',
				align = 'bottom-right',
				elements = yesnoOptions,
			},function(data,menu)
				if data.current.value == 'yes' then
					TriggerEvent('PH_MapBlips:ShowBlippolice')
				end
			end,
			function(data,menu)
				menu.close()
		end)
			end
			if data.current.value == 'something' then 
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'my_blipmenu2',
				{
					title = 'Blips',
					align = 'bottom-right',
					elements = yesnoOptions,
				},function(data,menu)
					if data.current.value == 'yes' then
						TriggerEvent('PH_MapBlips:ShowBlipNEWBLIPNAME')
					end
				end,
				function(data,menu)
					menu.close()
			end)
				end
			if data.current.value == 'ambulance' then 
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'my_blipmenu2',
					{
						title = 'Blips',
						align = 'bottom-right',
						elements = yesnoOptions,
					},function(data,menu)
						if data.current.value == 'yes' then
							TriggerEvent('PH_MapBlips:ShowBlipambulance')
						end
					end,
					function(data,menu)
						menu.close()
				end)
			end
			
		end,
		function(data,menu)
			menu.close()
		end)
		--PASTE NEW STUFF HERE and so on --
		
end




RegisterCommand('DebugMapMenu', function()
	BlipMenu()
end)