local ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('qb-scoreboard:server:GetScoreboardData', function(source, cb)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if Player ~= nil then
        name = Player.getName()
        job = Player.getJob().label
        grade = Player.getJob().grade_name
    end
    local ping = GetPlayerPing(src)
    local totalPlayers = 0
    local policeCount = 0
    local players = {}
    local info = {
        servername = Config.name,
        ping = ping .. 'ms',
        name = name,
        ambulanceCount = 0,
        mechanicCount = 0,
        taxiCount = 0,
        job = job,
        grade = grade

    }
   


    for _, v in pairs(GetPlayers()) do
        local Player = ESX.GetPlayerFromId(src)
        if Player then
            totalPlayers += 1

            if Player.getJob().label == 'police'  then
                policeCount += 1
            end

            if Player.getJob().label == 'ambulance'  then
                info.ambulanceCount += 1
            end
            if Player.getJob().label == 'Mechanic'  then
                info.mechanicCount += 1
            end
            if Player.getJob().label == 'taxi'  then
                info.taxiCount += 1
            end


        --    players[v.PlayerData.source] = {}
         --   players[v.PlayerData.source].optin = QBCore.Functions.IsOptin(v.PlayerData.source)
        end
    end
    cb(totalPlayers, policeCount, players, info)
end)

RegisterNetEvent('qb-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qb-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)

