ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('fisk_houserobbery:haslockpick', function(source, cb, lockpicktype)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getInventoryItem(lockpicktype) ~= nil then
            if xPlayer.getInventoryItem(lockpicktype).count > 0 then
                local toremove = math.random(1, 10)
                if toremove == 1 then
                    xPlayer.removeInventoryItem(lockpicktype, 1)
                end
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end
end)

ESX.RegisterServerCallback('fisk_houserobbery:rewardfridge', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomint1 = math.random(1, 10)
    local randomint2 = math.random(1, 9)
    local randomint3 = math.random(1, 25)
    if xPlayer then
        if randomint1 == 1 or randomint1 == 2 then
            if xPlayer.canCarryItem('fish', randomint2) then
                xPlayer.addInventoryItem('fish', randomint2)
                cb("foundfish")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 3 or randomint1 == 4 then
            if xPlayer.canCarryItem('burger', randomint2) then
                xPlayer.addInventoryItem('burger', randomint2)
                cb("foundburger")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 5 or randomint1 == 6 then
            if xPlayer.canCarryItem('water', randomint2) then
                xPlayer.addInventoryItem('water', randomint2)
                cb("foundwater")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 7 or randomint1 == 8 then
            if xPlayer.canCarryItem('coke_pooch', randomint3) then
                xPlayer.addInventoryItem('coke_pooch', randomint3)
                cb("foundcoke")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 9 then
            cb("police")
        else
            cb("notfound")
        end
    end
end)

ESX.RegisterServerCallback('fisk_houserobbery:rewardcabinet', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomint1 = math.random(1, 10)
    local randomint2 = math.random(20, 100)
    local randomint3 = math.random(1, 40)
    if xPlayer then
        if randomint1 == 1 or randomint1 == 2 then
            if xPlayer.canCarryItem('ammo1', randomint2) then
                xPlayer.addInventoryItem('ammo1', randomint2)
                cb("foundammo")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 3 or randomint1 == 4 then
            if xPlayer.canCarryItem('coke_pooch', randomint3) then
                xPlayer.addInventoryItem('coke_pooch', randomint3)
                cb("foundcoke")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 5 or randomint1 == 6 then
            if xPlayer.canCarryItem('weapon_knife', 1) then
                xPlayer.addInventoryItem('weapon_knife', 1)
                cb("foundknife")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 7 or randomint1 == 8 then
            if xPlayer.canCarryItem('marijuana', randomint3) then
                xPlayer.addInventoryItem('marijuana', randomint3)
                cb("foundmari")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 9 then
            cb("police")
        else
            cb("notfound")
        end
    end
end)

ESX.RegisterServerCallback('fisk_houserobbery:rewardtable', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomint1 = math.random(1, 10)
    local randomint22 = math.random(1, 9)
    local randomint2 = math.random(20, 45)
    local randomint3 = math.random(1, 40)
    if xPlayer then
        if randomint1 == 1 or randomint1 == 2 then
            if xPlayer.canCarryItem('fish', randomint22) then
                xPlayer.addInventoryItem('fish', randomint22)
                cb("foundfish")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 3 or randomint1 == 4 then
            if xPlayer.canCarryItem('water', randomint22) then
                xPlayer.addInventoryItem('water', randomint22)
                cb("foundwater")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 5 or randomint1 == 6 then
            if xPlayer.canCarryItem('ammo1', randomint2) then
                xPlayer.addInventoryItem('ammo1', randomint2)
                cb("foundammo")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 7 or randomint1 == 8 then
            if xPlayer.canCarryItem('coke_pooch', randomint3) then
                xPlayer.addInventoryItem('coke_pooch', randomint3)
                cb("foundcoke")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 9 then
            cb("police")
        else
            cb("notfound")
        end
    end
end)


ESX.RegisterServerCallback('fisk_houserobbery:rewardshelf', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomint1 = math.random(1, 10)
    local randomint55 = math.random(5000, 18000)
    local randomint2 = math.random(20, 45)
    local randomint3 = math.random(1, 40)
    if xPlayer then
        if randomint1 == 1 or randomint1 == 2 then
            if xPlayer.canCarryItem('9mmkasse', 1) then
                xPlayer.addInventoryItem('9mmkasse', 1)
                cb("foundweaponpart")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 3 or randomint1 == 4 then
            if xPlayer.canCarryItem('black_money', randomint55) then
                xPlayer.addInventoryItem('black_money', randomint55)
                cb("foundblackmoney")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 5 or randomint1 == 6 then
            if xPlayer.canCarryItem('ammo1', randomint2) then
                xPlayer.addInventoryItem('ammo1', randomint2)
                cb("foundammo")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 7 or randomint1 == 8 then
            if xPlayer.canCarryItem('coke_pooch', randomint3) then
                xPlayer.addInventoryItem('coke_pooch', randomint3)
                cb("foundcoke")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 9 then
            cb("police")
        else
            cb("notfound")
        end
    end
end)

ESX.RegisterServerCallback('fisk_houserobbery:rewardpainting', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomint1 = math.random(1, 10)
    local randomint2 = math.random(1, 9)
    local randomint3 = math.random(1, 25)
    if xPlayer then
        if randomint1 == 1 or randomint1 == 2 then
            if xPlayer.canCarryItem('painting_1', 1) then
                xPlayer.addInventoryItem('painting_1', 1)
                cb("1")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 3 or randomint1 == 4 then
            if xPlayer.canCarryItem('painting_2', 1) then
                xPlayer.addInventoryItem('painting_2', 1)
                cb("2")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 5 or randomint1 == 6 then
            if xPlayer.canCarryItem('painting_3', 1) then
                xPlayer.addInventoryItem('painting_3', 1)
                cb("3")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 7 or randomint1 == 8 then
            if xPlayer.canCarryItem('painting_4', 1) then
                xPlayer.addInventoryItem('painting_4', 1)
                cb("4")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 9 then
            cb("police")
        else
            cb("notfound")
        end
    end
end)

ESX.RegisterServerCallback('fisk_houserobbery:rewardchest', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomint1 = math.random(1, 10)
    local randomint2 = math.random(25, 150)
    local randomint3 = math.random(1, 2)
    local randomint4 = math.random(10, 50)
    if xPlayer then
        if randomint1 == 1 or randomint1 == 2 then
            if xPlayer.canCarryItem('ammo1', randomint2) then
                xPlayer.addInventoryItem('ammo1', randomint2)
                cb("foundammo")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 3 or randomint1 == 4 then
            if xPlayer.canCarryItem('armour', randomint3) then
                xPlayer.addInventoryItem('armour', randomint3)
                cb("foundvest")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 5 or randomint1 == 6 then
            if xPlayer.canCarryItem('phone', 1) then
                xPlayer.addInventoryItem('phone', 1)
                cb("phone")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 7 or randomint1 == 8 then
            if xPlayer.canCarryItem('coke_pooch', randomint4) then
                xPlayer.addInventoryItem('coke_pooch', randomint4)
                cb("foundcoke")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 9 then
            if xPlayer.canCarryItem('painting_4', 1) then
                xPlayer.addInventoryItem('painting_4', 1)
                cb("4")
            else
                cb("cantcarry")
            end
        else
            cb("notfound")
        end
    end
end)

ESX.RegisterServerCallback('fisk_houserobbery:rewardbed', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomint1 = math.random(1, 11)
    local randomint2 = math.random(25, 150)
    local randomint3 = math.random(1, 2)
    local randomint4 = math.random(10, 50)
    if xPlayer then
        if randomint1 == 1 or randomint1 == 2 then
            if xPlayer.canCarryItem('9mmkasse', 1) then
                xPlayer.addInventoryItem('9mmkasse', 1)
                cb("weaponpart")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 3 or randomint1 == 4 then
            if xPlayer.canCarryItem('armour', randomint3) then
                xPlayer.addInventoryItem('armour', randomint3)
                cb("foundvest")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 5 or randomint1 == 6 then
            if xPlayer.canCarryItem('phone', 1) then
                xPlayer.addInventoryItem('phone', 1)
                cb("phone")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 7 or randomint1 == 8 then
            if xPlayer.canCarryItem('coke_pooch', randomint4) then
                xPlayer.addInventoryItem('coke_pooch', randomint4)
                cb("foundcoke")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 9 then
            if xPlayer.canCarryItem('painting_4', 1) then
                xPlayer.addInventoryItem('painting_4', 1)
                cb("4")
            else
                cb("cantcarry")
            end
        elseif randomint1 == 10 then
            cb("police")
        else
            cb("notfound")
        end
    end
end)

