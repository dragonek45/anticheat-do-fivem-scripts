Config = {}

-- Czy zapisywać logi do pliku? (true/false)
Config.SaveLogsToFile = true

-- Czy zapisywać logi do bazy danych (MySQL)? (true/false)
Config.SaveLogsToSQL = true

-- Nazwa tabeli w bazie danych
Config.SQLTable = "anticheat_logs"

-- Modele pojazdów które mają być blokowane
Config.BlockedModels = {
    `cargoplane`, `rhino`, `hydra`, `apc`, `insurgent`,
    `dump`, `bus`, `freight`, `blimp`, `titan`
}

-- Eventy które mają być blokowane
Config.BlockedEvents = {
    "esx:giveItem",
    "esx:giveWeapon",
    "esx:setMoney",
    "esx:addWeapon",
    "esx:addMoney"
}
