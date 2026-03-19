local busy = false
local cooldowns = {} -- [carKey] = expireTime

local function getEntityKey(entity)
    local coords = GetEntityCoords(entity)
    return string.format(
        '%.2f_%.2f_%.2f',
        coords.x,
        coords.y,
        coords.z
    )
end

CreateThread(function()
    exports.ox_target:addModel(Config.propList, {
        {
            name = 'scrap_car',
            label = 'Scrap Car',
            icon = 'fa-solid fa-screwdriver-wrench',
            distance = 2.0,
            onSelect = function(data)
                if busy then return end

                local entity = data.entity
                local key = getEntityKey(entity)
                local now = GetGameTimer() / 1000

                -- Client-side cooldown check
                if cooldowns[key] and cooldowns[key] > now then
                    local remaining = math.ceil(cooldowns[key] - now)
                    lib.notify({
                        type = 'error',
                        description = ('You already searched this wreck. Try again in %ds'):format(remaining)
                    })
                    return
                end

                busy = true

                local success = lib.progressBar({
                    duration = Config.ScrapTime * 1000,
                    label = 'Scrapping vehicle...',
                    canCancel = true,
                    disable = {
                        move = true,
                        combat = true,
                        car = true
                    },
                    anim = {
                        dict = 'amb@world_human_welding@male@base',
                        clip = 'base'
                    }
                })

                if success then
                    -- Start cooldown FOR THIS PLAYER ONLY
                    cooldowns[key] = now + Config.CoolDownOnCar

                    TriggerServerEvent(
                        'car_scrap:loot',
                        NetworkGetNetworkIdFromEntity(entity)
                    )
                end

                busy = false
            end
        }
    })
end)
