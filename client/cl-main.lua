ESX = exports["es_extended"]:getSharedObject()

PlayerData = {}

Citizen.CreateThread(function()
    ESX = exports["es_extended"]:getSharedObject()

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
    
    PlayerData = ESX.GetPlayerData()
end)

local houseRobberies = {}
local houseRobberiesData = {}
local targetout
local forladhus
local refrigevrator
local cabin1
local cabin2
local table1
local table2
local table3
local table4
local table5
local shelf1
local shelf2
local bed1

for houseNum, house in pairs(Config.Houses) do
    houseRobberies[houseNum .. "_houserobbery"] = exports.ox_target:addBoxZone({
        coords = vector3(house.entry),
        size = vector3(1, 1, 1),
        options = {
            {
                label = 'Røv hus',
                icon = 'fa-solid fa-house',
                onSelect = function()
                    if houseRobberiesData[houseNum .. "_houserobbery"].cooldown > 0 then
                        lib.notify({
                            title = 'Husrøveri',
                            description = 'Du kan ikke røve dette hus i ' .. houseRobberiesData[houseNum .. "_houserobbery"].cooldown / 1000 .. ' sekunder mere!',
                            type = 'error'
                        })
                    else
                        local result = false
                        local result3 = false

                        ESX.TriggerServerCallback('fisk_houserobbery:haslockpick', function(result2)
                            if result2 then
                                result = exports['lockpick']:startLockpick()
                                if result then
                                    lib.notify({
                                        title = 'Husrøveri',
                                        description = 'Du har røvet dig ind i huset!',
                                        type = 'success'
                                    })
                                    SetEntityCoords(GetPlayerPed(-1), house.entry.x, house.entry.y, house.entry.z)
                                    local housecoords = GetEntityCoords(GetPlayerPed(-1))
                                    local respawncoords = GetEntityCoords(GetPlayerPed(-1))
                                    housecoords = { x = housecoords.x, y = housecoords.y, z = housecoords.z - 25 }
                                    local houseimin = {}
                                    local housingspawned = exports['mythic_interiors']:CreateTier1HouseFurnished(housecoords, false)
                                    houseimin = housingspawned[1]
        
                                    Citizen.Wait(1000)
                                    local playercoords = GetEntityCoords(GetPlayerPed(-1))
        
        
                                    refrigevrator = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x - 2.382513, playercoords.y + 11.07, playercoords.z),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg Kølleskabet',
                                                icon = 'fa-solid fa-temperature-low',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søger køleskab..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(refrigevrator)
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardfridge', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'foundburger' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt burger!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundwater' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt vand!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundfish' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt fisk!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end,
                                                distance = 1,
                                            }
                                        }
                                    })
        
                                    cabin1 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x - 1.382513, playercoords.y + 8.6911, playercoords.z + 0.8),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg Cabinet',
                                                icon = 'fa-solid fa-table',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søger cabinet..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(cabin1)
                                                        cabin1 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardcabinet', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'ammo1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ammo!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundknife' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt en kniv!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundmari' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt marijuana!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    })
        
                                    cabin2 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x - 4.382513, playercoords.y + 8.6911, playercoords.z + 0.8),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg Cabinet',
                                                icon = 'fa-solid fa-table',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søger cabinet..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(cabin2)
                                                        cabin2 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardcabinet', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'ammo1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ammo!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundknife' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt en kniv!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundmari' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt marijuana!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    })
        
                                    table1 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x - 7.382513, playercoords.y + 8.6911, playercoords.z - 0.1),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg Bord',
                                                icon = 'fa-solid fa-table-cells',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søger bord..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(table1)
                                                        table1 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardtable', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'ammo1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ammo!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundwater' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt vand!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundfish' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt fisk!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    })
        
                                    table2 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x - 8.282513, playercoords.y + 15.5911, playercoords.z - 0.1),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg Bord',
                                                icon = 'fa-solid fa-table-cells',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søger bord..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(table2)
                                                        table2 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardtable', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'ammo1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ammo!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundwater' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt vand!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundfish' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt fisk!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    })
        
                                    table3 = exports.ox_target:addBoxZone({-- 5.082513
                                        coords = vector3(playercoords.x - 5.082513, playercoords.y + 16.0911, playercoords.z - 0.1),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg Bord',
                                                icon = 'fa-solid fa-table-cells',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søger bord..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(table3)
                                                        table3 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardtable', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'ammo1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ammo!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundwater' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt vand!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundfish' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt fisk!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    })
        
                                    shelf1 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x - 1.282513, playercoords.y + 16.0911, playercoords.z + 0.6),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg Hylde',
                                                icon = 'fa-solid fa-table-cells',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søger hylde..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(shelf1)
                                                        shelf1 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardshelf', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'ammo1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ammo!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundweaponpart' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt et våbendel!!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundblackmoney' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt sorte penge!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    }) -- 1393.2886, -570.1284, 52.7955, 6.0602
        
                                    painting1 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x + 0.582513, playercoords.y + 14.6911, playercoords.z + 0.8),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Skift maleri ud',
                                                icon = 'fa-solid fa-table-cells',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Skifter maleri..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(painting1)
                                                        painting1 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardpainting', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == '1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt Maleri #41',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == '2' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt Maleri #2!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == '3' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt Maleri #3!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == '4' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt Maleri #4!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    }) -- 1393.2886, -570.1284, 52.7955, 6.0602
        
                                    table4 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x + 4.582513, playercoords.y + 12.6911, playercoords.z - 0.2),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg bord',
                                                icon = 'fa-solid fa-table-cells',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søg bord..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(table4)
                                                        table4 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardtable', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'ammo1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ammo!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundwater' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt vand!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundfish' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt fisk!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    })
        
                                    chest1 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x + 5.882513, playercoords.y + 13.6911, playercoords.z - 0.2),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg kiste',
                                                icon = 'fa-solid fa-table-cells',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søg kiste..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(chest1)
                                                        chest1 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardchest', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'ammo1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ammo!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundvest' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt en skudsikkervest!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'phone' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt en telefon!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == '4' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt Maleri #4!',
                                                                    type = 'inform'
                                                                })
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    }) 
        
                                    bed1 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x + 3.882513, playercoords.y + 16.8911, playercoords.z - 0.2),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg Seng',
                                                icon = 'fa-solid fa-table-cells',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søger seng..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(bed1)
                                                        bed1 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardbed', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'weaponpart' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt en våbendel!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundvest' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt en skudsikkervest!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'phone' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt en telefon!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == '4' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt Maleri #4!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    })
        
                                    table5 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x + 2.482513, playercoords.y + 17.6911, playercoords.z - 0.2),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg Bord',
                                                icon = 'fa-solid fa-table-cells',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søger bord..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(table5)
                                                        table5 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardtable', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'ammo1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ammo!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundwater' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt vand!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundfish' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt fisk!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'police' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du larmet for meget, politiet er blivet tilkaldt!',
                                                                    type = 'error'
                                                                })
                                                                TriggerEvent('police:houseRobbery')
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    })
        
                                    shelf2 = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x + 3.882513, playercoords.y + 19.4911, playercoords.z),
                                        size = vector3(1, 1, 1),
                                        options = {
                                            {
                                                label = 'Søg Skab',
                                                icon = 'fa-solid fa-table-cells',
                                                onSelect = function()
                                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                                    if lib.progressBar({
                                                        duration = Config.SearchTime * 1000,
                                                        label = 'Søger skab..',
                                                        useWhileDead = false,
                                                        canCancel = true,
                                                        anim = {
                                                            dict = 'missmechanic',
                                                            clip = 'work_base'
                                                        },
                                                    }) then 
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                        exports.ox_target:removeZone(shelf2)
                                                        shelf2 = nil
                                                        ESX.TriggerServerCallback('fisk_houserobbery:rewardchest', function(data)
                                                            if data == 'cantcarry' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du kan ikke have mere på dig!',
                                                                    type = 'error'
                                                                })
                                                            elseif data == 'ammo1' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ammo!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundvest' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt en skudsikkervest!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'phone' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt en telefon!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == 'foundcoke' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt coke i poser!',
                                                                    type = 'inform'
                                                                })
                                                            elseif data == '4' then
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt Maleri #4!',
                                                                    type = 'inform'
                                                                })
                                                            else
                                                                lib.notify({
                                                                    title = 'Husrøveri',
                                                                    description = 'Du fandt ikke noget!',
                                                                    type = 'inform'
                                                                })
                                                            end
                                                        end)
                                                    else
                                                        FreezeEntityPosition(GetPlayerPed(-1), false)
                                                    end
                                                end
                                            }
                                        }
                                    })
        
                                    forladhus = exports.ox_target:addBoxZone({
                                        coords = vector3(playercoords.x, playercoords.y, playercoords.z),
                                        options = {
                                            {
                                                label = 'Forlad hus',
                                                icon = 'fa-solid fa-house',
                                                onSelect = function()
                                                    local outofhouse = exports['mythic_interiors']:DespawnInterior(houseimin)
                                                    SetEntityCoords(GetPlayerPed(-1), house.entry.x, house.entry.y, house.entry.z)
                                                    if refrigevrator ~= nil then
                                                        exports.ox_target:removeZone(refrigevrator)
                                                    end
                                                    if cabin1 ~= nil then
                                                        exports.ox_target:removeZone(cabin1)
                                                    end
                                                    if cabin2 ~= nil then
                                                        exports.ox_target:removeZone(cabin2)
                                                    end
                                                    if table1 ~= nil then
                                                        exports.ox_target:removeZone(table1)
                                                    end
                                                    if table2 ~= nil then
                                                        exports.ox_target:removeZone(table2)
                                                    end
                                                    if table3 ~= nil then
                                                        exports.ox_target:removeZone(table3)
                                                    end
                                                    if table4 ~= nil then
                                                        exports.ox_target:removeZone(table4)
                                                    end
                                                    if table5 ~= nil then
                                                        exports.ox_target:removeZone(table5)
                                                    end
                                                    if shelf1 ~= nil then
                                                        exports.ox_target:removeZone(shelf1)
                                                    end
                                                    if shelf2 ~= nil then
                                                        exports.ox_target:removeZone(shelf2)
                                                    end
                                                    if painting1 ~= nil then
                                                        exports.ox_target:removeZone(painting1)
                                                    end
                                                    if chest1 ~= nil then
                                                        exports.ox_target:removeZone(chest1)
                                                    end
                                                    if bed1 ~= nil then
                                                        exports.ox_target:removeZone(bed1)
                                                    end
                                                    exports.ox_target:removeZone(forladhus)
                                                end,
                                                distance = 1
                                            }
                                        }
                                    })
        
                                    houseRobberiesData[houseNum .. "_houserobbery"].cooldown = Config.Cooldown * 1000
                                    houseRobberiesData[houseNum .. "_houserobbery"].status = true
                                    TriggerEvent('fisk_houserobbery:housecooldown', houseNum)
                                else
                                    lib.notify({
                                        title = 'Husrøveri',
                                        description = 'Du mislykkes, politiet er blivet tilkaldt!',
                                        type = 'error'
                                    })
                                    TriggerEvent('police:houseRobbery')
                                end
                            else
                                lib.notify({
                                    title = 'Husrøveri',
                                    description = 'Du har ingen lockpick!',
                                    type = 'error'
                                })
                            end
                        end, house.lockpick)
                    end
                end,
                distance = 1
            }
        }
    })
    houseRobberiesData[houseNum .. "_houserobbery"] = {
        cooldown = 0,
        cooldownstatus = false,
        looted = {}
    }
end

RegisterNetEvent('fisk_houserobbery:housecooldown', function(houseNum)
    while houseRobberiesData[houseNum .. "_houserobbery"].status do
        Citizen.Wait(1000)
        if houseRobberiesData[houseNum .. "_houserobbery"].cooldown < 1 then
            houseRobberiesData[houseNum .. "_houserobbery"].status = false
        else
            houseRobberiesData[houseNum .. "_houserobbery"].cooldown = houseRobberiesData[houseNum .. "_houserobbery"].cooldown - 1000
        end
    end
end)