#!/bin/bash
# Скрипт конфигурации PHP для контейнера cron
# Определяет правильные пути для разных версий PHP

# Определение версии PHP и соответствующих путей
if php5 --version >/dev/null 2>&1; then
    PHP_VERSION="5"
    PHP_PATH="/etc/php5/cli/conf.d"
elif php7.1 --version >/dev/null 2>&1; then
    PHP_VERSION="7.1"
    PHP_PATH="/etc/php/7.1/cli/conf.d"
elif php7.3 --version >/dev/null 2>&1; then
    PHP_VERSION="7.3"
    PHP_PATH="/etc/php/7.3/cli/conf.d"
elif php7.4 --version >/dev/null 2>&1; then
    PHP_VERSION="7.4"
    PHP_PATH="/etc/php/7.4/cli/conf.d"
elif php8.0 --version >/dev/null 2>&1; then
    PHP_VERSION="8.0"
    PHP_PATH="/etc/php/8.0/cli/conf.d"
elif php8.1 --version >/dev/null 2>&1; then
    PHP_VERSION="8.1"
    PHP_PATH="/etc/php/8.1/cli/conf.d"
elif php8.2 --version >/dev/null 2>&1; then
    PHP_VERSION="8.2"
    PHP_PATH="/etc/php/8.2/cli/conf.d"
elif php8.3 --version >/dev/null 2>&1; then
    PHP_VERSION="8.3"
    PHP_PATH="/etc/php/8.3/cli/conf.d"
elif php8.4 --version >/dev/null 2>&1; then
    PHP_VERSION="8.4"
    PHP_PATH="/etc/php/8.4/cli/conf.d"
else
    echo "Неподдерживаемая версия PHP"
    exit 1
fi

echo "Настройка PHP ${PHP_VERSION} для cron..."

# Создать директорию если не существует
mkdir -p "$PHP_PATH"

# Копировать базовую конфигурацию
cp /tmp/php-base.ini "$PHP_PATH/90-php.ini"

# Копировать конфигурацию безопасности для cron
cp /tmp/php-cron-security.ini "$PHP_PATH/99-security.ini"

echo "Конфигурация PHP ${PHP_VERSION} завершена"