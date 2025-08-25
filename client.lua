-- [ANTI-CHEAT CLIENT] 🚀
-- Zabezpieczenia klienta + optymalizacja

-- 🔹 FPS optymalizacja (żadnych pętli 0ms)
CreateThread(function()
    while true do
        Wait(1000)
    end
end)

-- 🔹 BLOKADA NIEWIDZIALNOŚCI
CreateThread(function()
    while true do
        Wait(5000)
        local ped = PlayerPedId()
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true, false)
            TriggerServerEvent("anticheat:log", "Niewidzialność (PlayerID: " .. GetPlayerServerId(PlayerId()) .. ")")
        end
    end
end)

-- 🔹 BLOKADA GODMODE
CreateThread(function()
    while true do
        Wait(5000)
        local ped = PlayerPedId()
        if GetPlayerInvincible(PlayerId()) then
            SetEntityInvincible(ped, false)
            TriggerServerEvent("anticheat:log", "Godmode (PlayerID: " .. GetPlayerServerId(PlayerId()) .. ")")
        end
    end
end)

-- 🔹 BLOKADA SUPER SPEEDA
CreateThread(function()
    while true do
        Wait(3000)
        local ped = PlayerPedId()
        local speed = GetEntitySpeed(ped)
        if speed > 12.0 then -- sprint ~7-8
            TriggerServerEvent("anticheat:log", "SpeedHack (" .. speed .. " m/s) (PlayerID: " .. GetPlayerServerId(PlayerId()) .. ")")
        end
    end
end)

-- 🔹 BLOKADA NIELEGALNEJ BRONI (prosty whitelist)
local allowedWeapons = {
    `WEAPON_UNARMED`, `WEAPON_PISTOL`, `WEAPON_KNIFE`
}

CreateThread(function()
    while true do
        Wait(3000)
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)

        local allowed = false
        for _, w in ipairs(allowedWeapons) do
            if weapon == w then allowed = true end
        end

        if not allowed then
            RemoveWeaponFromPed(ped, weapon)
            TriggerServerEvent("anticheat:log", "Nielegalna broń: " .. weapon .. " (PlayerID: " .. GetPlayerServerId(PlayerId()) .. ")")
        end
    end
end)

-- 🔹 KOMENDA TESTOWA
RegisterCommand("antitest", function()
    TriggerEvent('chat:addMessage', {
        args = {"^2[AntiCheat]", "System działa 🚀 Serwer jest chroniony"}
    })
end)
