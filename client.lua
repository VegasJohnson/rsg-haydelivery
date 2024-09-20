local RSGCore = exports['rsg-core']:GetCoreObject()
delv = false
delc = false
delb = false
delr = false
local carthash = 'huntercart01'
local cargohash = 'pg_vehload_haybale01'
local hay = 'p_haybale03x'
local DelPrompt
local prompts = GetRandomIntInRange(0, 0xffffff)
local showplip = Config.ShowBlips

function PromptSetUp()
    local str = "Deliver Hay"
    DelPrompt = PromptRegisterBegin()
    PromptSetControlAction(DelPrompt, 0xF3830D8E)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(DelPrompt, str)
    PromptSetEnabled(DelPrompt, 0)
    PromptSetVisible(DelPrompt, 0)
    PromptSetStandardMode(DelPrompt, 1)
    PromptSetGroup(DelPrompt, prompts)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, DelPrompt, true)
    PromptRegisterEnd(DelPrompt)
end

Citizen.CreateThread(function()
    for bale, v in pairs(Config.DeliverLoc) do
        exports['rsg-core']:createPrompt(v.Valantine.startpoint, v.Valantine.scoords, RSGCore.Shared.Keybinds['J'],
            'Start Hay Delivery ', {
                type = 'client',
                event = 'rsg-haydelivery:client:startv',
                args = {},
            })
        exports['rsg-core']:createPrompt(v.Cholla.startpoint, v.Cholla.scoords, RSGCore.Shared.Keybinds['J'],
            'Start Hay Delivery ', {
                type = 'client',
                event = 'rsg-haydelivery:client:startc',
                args = {},
            })
        exports['rsg-core']:createPrompt(v.Blackwater.startpoint, v.Blackwater.scoords, RSGCore.Shared.Keybinds['J'],
            'Start Hay Delivery ', {
                type = 'client',
                event = 'rsg-haydelivery:client:startb',
                args = {},
            })
        exports['rsg-core']:createPrompt(v.Rhodes.startpoint, v.Rhodes.scoords, RSGCore.Shared.Keybinds['J'],
            'Start Hay Delivery ', {
                type = 'client',
                event = 'rsg-haydelivery:client:startr',
                args = {},
            })
		for k, v in pairs (Config.DeliverLoc.locations) do
			if showplip then 
				local StoreBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.scoords)
				SetBlipSprite(StoreBlip, 874255393, 1)
				SetBlipScale(StoreBlip, 0.2)
				Citizen.InvokeNative(0x9CB1A1623062F402, StoreBlip, v.endpoint)
			end
		end
    end
end)



RegisterNetEvent('rsg-haydelivery:client:startv')
AddEventHandler('rsg-haydelivery:client:startv', function()
    if not delv then
		
		RequestModel(carthash, cargohash)
        while not HasModelLoaded(carthash, cargohash) do
            RequestModel(carthash, cargohash)
            Citizen.Wait(0)
        end
	
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local endpoint = Config.DeliverLoc.locations.Valantine.ecoords
        local wagon = vector4(Config.DeliverLoc.locations.Valantine.spawn)
        local vehicle = CreateVehicle(carthash, wagon, true, false)
        SetVehicleOnGroundProperly(vehicle)
        local cargo = GetHashKey(cargohash)
        Wait(200)
        --SetModelAsNoLongerNeeded(carthash)
        Citizen.InvokeNative(0xD80FAF919A2E56EA, vehicle, cargo)
        delv = true
        CreateThread(function()
            while true do
                Wait(0)
                if delv then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, endpoint.x, endpoint.y, endpoint.z, 0.0, 0.0,
                        0.0,
                        0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
                end
            end
        end)
        if delv then
            StartGpsMultiRoute(GetHashKey("COLOR_RED"), true, true)
            AddPointToGpsMultiRoute(Config.DeliverLoc.locations.Valantine.ecoords)
            SetGpsMultiRouteRender(true)
            CreateThread(function()
                while true do
                    Wait(5)
                    local wagoncoords = GetEntityCoords(vehicle)
                    if #(wagoncoords - endpoint) <= 3.0 then
                        TriggerEvent('rsg-haydelivery:client:endv', vehicle, delv)
                    end
                end
            end)
        end
    else
        RSGCore.Functions.Notify('Job Already Started', 'error')
    end
end)

RegisterNetEvent('rsg-haydelivery:client:startc', function()
    if not delc then
		
		RequestModel(carthash, cargohash)
        while not HasModelLoaded(carthash, cargohash) do
            RequestModel(carthash, cargohash)
            Citizen.Wait(0)
        end
	
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local endpoint = Config.DeliverLoc.locations.Cholla.ecoords
        local wagon = vector4(Config.DeliverLoc.locations.Cholla.spawn)
        local vehicle = CreateVehicle(carthash, wagon, true, false)
        SetVehicleOnGroundProperly(vehicle)
        local cargo = GetHashKey(cargohash)
        Wait(200)
        --SetModelAsNoLongerNeeded(carthash)
        Citizen.InvokeNative(0xD80FAF919A2E56EA, vehicle, cargo)
        delc = true
        CreateThread(function()
            while true do
                Wait(0)
                if delc then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, endpoint.x, endpoint.y, endpoint.z, 0.0, 0.0,
                        0.0,
                        0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
                end
            end
        end)
        if delc then
            StartGpsMultiRoute(GetHashKey("COLOR_RED"), true, true)
            AddPointToGpsMultiRoute(Config.DeliverLoc.locations.Cholla.ecoords)
            SetGpsMultiRouteRender(true)
            CreateThread(function()
                while true do
                    Wait(5)
                    local wagoncoords = GetEntityCoords(vehicle)
                    if #(wagoncoords - endpoint) <= 3.0 then
                        TriggerEvent('rsg-haydelivery:client:endc', vehicle, delc)
                    end
                end
            end)
        end
    else
        RSGCore.Functions.Notify('Job Already Started', 'error')
    end
end)

RegisterNetEvent('rsg-haydelivery:client:startb', function()
    if not delb then
	
		RequestModel(carthash, cargohash)
        while not HasModelLoaded(carthash, cargohash) do
            RequestModel(carthash, cargohash)
            Citizen.Wait(0)
        end
	
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local endpoint = Config.DeliverLoc.locations.Blackwater.ecoords
        local wagon = vector4(Config.DeliverLoc.locations.Blackwater.spawn)
        local vehicle = CreateVehicle(carthash, wagon, true, false)
        SetVehicleOnGroundProperly(vehicle)
        local cargo = GetHashKey(cargohash)
        Wait(200)
        --SetModelAsNoLongerNeeded(carthash)
        Citizen.InvokeNative(0xD80FAF919A2E56EA, vehicle, cargo)
        delb = true
        CreateThread(function()
            while true do
                Wait(0)
                if delb then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, endpoint.x, endpoint.y, endpoint.z, 0.0, 0.0,
                        0.0,
                        0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
                end
            end
        end)
        if delb then
            StartGpsMultiRoute(GetHashKey("COLOR_RED"), true, true)
            AddPointToGpsMultiRoute(Config.DeliverLoc.locations.Blackwater.ecoords)
            SetGpsMultiRouteRender(true)
            CreateThread(function()
                while true do
                    Wait(5)
                    local wagoncoords = GetEntityCoords(vehicle)
                    if #(wagoncoords - endpoint) <= 3.0 then
                        TriggerEvent('rsg-haydelivery:client:endb', vehicle, delb)
                    end
                end
            end)
        end
    else
        RSGCore.Functions.Notify('Job Already Started', 'error')
    end
end)

RegisterNetEvent('rsg-haydelivery:client:startr', function()
    if not delr then
	
		RequestModel(carthash, cargohash)
        while not HasModelLoaded(carthash, cargohash) do
            RequestModel(carthash, cargohash)
            Citizen.Wait(0)
        end
	
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local endpoint = Config.DeliverLoc.locations.Rhodes.ecoords
        local wagon = vector4(Config.DeliverLoc.locations.Rhodes.spawn)
        local vehicle = CreateVehicle(carthash, wagon, true, false)
        SetVehicleOnGroundProperly(vehicle)
        local cargo = GetHashKey(cargohash)
        Wait(200)
        --SetModelAsNoLongerNeeded(carthash)
        Citizen.InvokeNative(0xD80FAF919A2E56EA, vehicle, cargo)
        delr = true
        CreateThread(function()
            while true do
                Wait(0)
                if delr then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, endpoint.x, endpoint.y, endpoint.z, 0.0, 0.0,
                        0.0,
                        0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
                end
            end
        end)
        if delr then
            StartGpsMultiRoute(GetHashKey("COLOR_RED"), true, true)
            AddPointToGpsMultiRoute(Config.DeliverLoc.locations.Rhodes.ecoords)
            SetGpsMultiRouteRender(true)
            CreateThread(function()
                while true do
                    Wait(5)
                    local wagoncoords = GetEntityCoords(vehicle)
                    if #(wagoncoords - endpoint) <= 3.0 then
                        TriggerEvent('rsg-haydelivery:client:endr', vehicle, delr)
                    end
                end
            end)
        end
    else
        RSGCore.Functions.Notify('Job Already Started', 'error')
    end
end)


RegisterNetEvent('rsg-haydelivery:client:endv', function(vehicle, delv)
    if delv then
        DeleteVehicle(vehicle)
        SetGpsMultiRouteRender(false)
        Cooldown()
        TriggerServerEvent('rsg-haydelivery:server:endvpay')
    else
        RSGCore.Functions.Notify('Job Not Started', 'error')
    end
end)

RegisterNetEvent('rsg-haydelivery:client:endc', function(vehicle, delc)
    if delc then
        DeleteVehicle(vehicle)
        SetGpsMultiRouteRender(false)
        Cooldown()
        TriggerServerEvent('rsg-haydelivery:server:endcpay')
    else
        TriggerClientEvent('RSGCore:Notify', src, ('Job Not Started'), 'error')
    end
end)
RegisterNetEvent('rsg-haydelivery:client:endb', function(vehicle, delb)
    if delb then
        DeleteVehicle(vehicle)
        SetGpsMultiRouteRender(false)
        Cooldown()
        TriggerServerEvent('rsg-haydelivery:server:endbpay')
    else
        TriggerClientEvent('RSGCore:Notify', src, ('Job Not Started'), 'error')
    end
end)

RegisterNetEvent('rsg-haydelivery:client:endr', function(vehicle, delr)
    if delr then
        DeleteVehicle(vehicle)
        SetGpsMultiRouteRender(false)
        Cooldown()
        TriggerServerEvent('rsg-haydelivery:server:endrpay')
    else
        TriggerClientEvent('RSGCore:Notify', src, ('Job Not Started'), 'error')
    end
end)


function Cooldown()
    delv = false
    delc = false
    delb = false
    delr = false
end









