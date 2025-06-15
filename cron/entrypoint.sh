#!/bin/bash
set -e

# Настроить PHP конфигурацию для текущей версии
/usr/local/bin/configure-php.sh

# Обеспечить существование директории логов с правильными правами
mkdir -p /var/log/cron
chown www-data:www-data /var/log/cron

# Создать файл лога cron если он не существует
touch /var/log/cron/bitrix.log
chown www-data:www-data /var/log/cron/bitrix.log

# Запустить cron в режиме foreground
exec "$@"