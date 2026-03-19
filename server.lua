local QBCore = exports['qb-core']:GetCoreObject()

local function getRandomLoot()
    for _, loot in ipairs(Config.lootPool) do
        if math.random(100) <= loot.chance then
            return loot.item, math.random(loot.min, loot.max)
        end
    end
    return nil
end

RegisterNetEvent('car_scrap:loot', function(netId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local item, amount = getRandomLoot()
    if item then
        Player.Functions.AddItem(item, amount)
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'success',
            description = ('You salvaged %sx %s'):format(amount, item)
        })
    else
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'inform',
            description = 'You didn’t find anything useful.'
        })
    end
end)
