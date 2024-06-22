@echo off
setlocal

echo Create folder structure
if not exist C:\var\www\bitrix mkdir C:\var\www\bitrix
cd C:\var\www
if exist C:\var\www\bitrix\bitrixsetup.php del C:\var\www\bitrix\bitrixsetup.php
curl -fsSL https://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -o C:\var\www\bitrix\bitrixsetup.php
if exist C:\var\www\bitrixdock rd /s /q C:\var\www\bitrixdock
git clone --depth=1 https://github.com/bitrixdock/bitrixdock.git C:\var\www\bitrixdock
icacls C:\var\www\bitrix /grant Everyone:(OI)(CI)F /T

echo Config
copy /y C:\var\www\bitrixdock\.env_template C:\var\www\bitrixdock\.env
powershell -Command "(Get-Content C:\var\www\bitrixdock\.env).replace('SITE_PATH=./www', 'SITE_PATH=C:/var/www/bitrix') | Set-Content C:\var\www\bitrixdock\.env"

echo Run
docker compose -p bitrixdock down
docker compose -f C:\var\www\bitrixdock\docker-compose.yml -p bitrixdock up -d

endlocal
