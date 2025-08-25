print("^2[START] AntiCrash + AntiCheat uruchomiony ✅")

-- ZAŁADUJ CONFIG
if not Config then
    Config = {}
    print("^1[AntiCheat] Uwaga: config.lua nie został załadowany, używam domyślnych wartości.^0")
end

-- Funkcja zapisująca logi do konsoli, pliku i SQL (oxmysql)
local function SaveLog(msg, src)
    print("[AntiCheat] " .. msg)

    -- Zapis do pliku
    if Config.SaveLogsToFile then
        -- Ścieżka względna do katalogu zasobu
        local path = ("resources/[anticheat]/anticheat/logs/cheaters.log")
        local file = io.open(path, "a")
        if file then
            file:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. msg .. "\n")
            file:close()
        else
            print("^1[AntiCheat] Nie można zapisać do logs/cheaters.log^0")
        end
    end

    -- Zapis do bazy danych (oxmysql)
    if Config.SaveLogsToSQL and src then
        local playerName = GetPlayerName(src) or "UNKNOWN"
        local playerID = src or 0
        local ok = pcall(function()
            exports.oxmysql:insert(
                "INSERT INTO " .. (Config.SQLTable or "anticheat_logs") .. " (player_id, player_name, log_message, log_time) VALUES (?, ?, ?, NOW())",
                { playerID, playerName, msg }
            )
        end)
        if not ok then
            print("^1[AntiCheat] Błąd zapisu do SQL (sprawdź oxmysql i połączenie DB).^0")
        end
    end
end

-- Odbiór logów z klienta
RegisterNetEvent("anticheat:log")
AddEventHandler("anticheat:log", function(msg)
    local src = source
    SaveLog(("Gracz ID %s -> %s"):format(src, msg), src)
end)

-- ANTI-CRASH: blokada wybuchów
AddEventHandler("explosionEvent", function(sender, ev)
    CancelEvent()
    SaveLog("Zablokowano wybuch od gracza ID " .. tostring(sender), sender)
end)

-- ANTI-CRASH: blokada masowego spawnu pojazdów
AddEventHandler("entityCreating", function(entity)
    local model = GetEntityModel(entity)
    if Config.BlockedModels then
        for _, m in pairs(Config.BlockedModels) do
            if model == m then
                CancelEvent()
                SaveLog("Próba zrespienia zablokowanego modelu: " .. tostring(model), source)
                return
            end
        end
    end
end)

-- ANTI-CHEAT: blokada niebezpiecznych eventów
if Config.BlockedEvents then
    for _, ev in pairs(Config.BlockedEvents) do
        RegisterNetEvent(ev)
        AddEventHandler(ev, function()
            local src = source
            CancelEvent()
            SaveLog("Gracz ID " .. tostring(src) .. " próbował wywołać event: " .. tostring(ev), src)
        end)
    end
end
