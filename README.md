# 🚀 AntiCrash + AntiCheat do FiveM (z SQL)

## Funkcje
- ✅ AntiCrash – blokuje crashujące pojazdy, wybuchy i spam entity
- ✅ AntiCheat – godmode, niewidzialność, speedhack, nielegalne bronie (whitelist)
- ✅ Blokada niebezpiecznych eventów (ESX/ox): giveItem, giveWeapon, setMoney
- ✅ Optymalizacja FPS – brak ticków 0ms
- ✅ Logi – konsola, `logs/cheaters.log`, baza danych MySQL

## Instalacja
1. Skopiuj folder `resources/[anticheat]/anticheat` na serwer.
2. Zainstaluj **oxmysql** (https://github.com/overextended/oxmysql).
3. W `server.cfg` dodaj kolejno:
   ```
   ensure oxmysql
   ensure anticheat
   ```
4. Zaimportuj plik SQL do bazy (patrz niżej).

## SQL
Uruchom ten skrypt w swojej bazie danych (np. przez phpMyAdmin lub konsolę MySQL):
```sql
CREATE TABLE IF NOT EXISTS anticheat_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  player_id INT NOT NULL,
  player_name VARCHAR(64) NOT NULL,
  log_message TEXT NOT NULL,
  log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS anticheat_bans (
  id INT AUTO_INCREMENT PRIMARY KEY,
  identifier VARCHAR(80) NOT NULL UNIQUE,
  reason VARCHAR(255) NOT NULL,
  banned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Konfiguracja
- Wszystkie ustawienia: `config.lua`
- Możesz łatwo dodawać własne modele i eventy do blokady.

## Uwaga
- Ten zasób to solidna **warstwa ochronna**, ale nie zastąpi pełnoprawnego anti-cheata (np. płatne AC).
- Zadbaj o poprawne nadawanie uprawnień i zabezpiecz inne zasoby (zwłaszcza admin-menu).
