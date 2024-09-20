local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterServerEvent('rsg-haydelivery:server:endvpay', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', Config.DeliverLoc.locations.Valantine.pay)
end)
RegisterServerEvent('rsg-haydelivery:server:endcpay', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', Config.DeliverLoc.locations.Cholla.pay)
end)
RegisterServerEvent('rsg-haydelivery:server:endbpay', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', Config.DeliverLoc.locations.Blackwater.pay)
end)
RegisterServerEvent('rsg-haydelivery:server:endrpay', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', Config.DeliverLoc.locations.Rhodes.pay)
end)
