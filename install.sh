#!/bin/sh
set -e

echo "Create folder struct"
mkdir -p /var/www/bitrix && \
cd /var/www && \
rm -f /var/www/bitrix/bitrixsetup.php && \
curl -fsSL https://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -o /var/www/bitrix/bitrixsetup.php && \
rm -rf /var/www/bitrixdock && \
git clone --depth=1 https://github.com/bitrixdock/bitrixdock.git && \
chmod -R 775 /var/www/bitrix && chown -R root:www-data /var/www/bitrix && \

echo "Config"
cp -f /var/www/bitrixdock/.env_template /var/www/bitrixdock/.env
sed -i 's/SITE_PATH=.\/www/SITE_PATH=\/var\/www\/bitrix/' /var/www/bitrixdock/.env

echo "Run"
docker compose -p bitrixdock down
docker compose -f /var/www/bitrixdock/docker-compose.yml -p bitrixdock up -d
