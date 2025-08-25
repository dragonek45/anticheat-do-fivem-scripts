fx_version 'cerulean'
game 'gta5'

author 'ChatGPT x TwójNick'
description 'AntiCrash + AntiCheat + Optymalizacja FPS + SQL'
version '2.5.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

-- ✅ AntiCrash – blokuje crashujące modele, wybuchy
-- ✅ AntiCheat – blokuje exploity (eventy ESX/ox), godmode, niewidzialność, speedhack
-- ✅ Optymalizacja FPS – lekki kod, brak ticków 0ms
-- ✅ Logi – konsola + zapis do pliku logs/cheaters.log + SQL
-- ✅ Konfiguracja w config.lua (łatwe włączanie/wyłączanie opcji)
