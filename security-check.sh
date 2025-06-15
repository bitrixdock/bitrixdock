#!/bin/bash

echo "=== Проверка безопасности Bitrixdock ==="
echo

# Определение правильной команды docker compose
if command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE="docker-compose"
elif docker compose version &> /dev/null; then
    DOCKER_COMPOSE="docker compose"
else
    echo "❌ Docker Compose не найден. Установите Docker Compose."
    exit 1
fi

# Проверка запущен ли контейнер
if ! $DOCKER_COMPOSE ps | grep -q "php.*running"; then
    echo "❌ PHP контейнер не запущен"
    exit 1
fi

echo "1. Проверка доступа к cron для www-data..."
$DOCKER_COMPOSE exec php su -s /bin/sh www-data -c "crontab -l" 2>&1 | grep -q "not allowed" && \
    echo "✅ Доступ к cron заблокирован для www-data" || \
    echo "⚠️  Доступ к cron доступен для www-data (риск безопасности)"

echo
echo "2. Проверка отключенных PHP функций..."
DISABLED=$($DOCKER_COMPOSE exec php php -r "echo ini_get('disable_functions');" 2>/dev/null)
if echo "$DISABLED" | grep -q "exec"; then
    echo "✅ Опасные функции отключены"
    echo "   Отключены: ${DISABLED:0:50}..."
else
    echo "⚠️  Опасные функции включены"
fi

echo
echo "3. Проверка настроек безопасности..."
$DOCKER_COMPOSE exec php php -r "
    echo 'allow_url_fopen: ' . ini_get('allow_url_fopen') . PHP_EOL;
    echo 'allow_url_include: ' . ini_get('allow_url_include') . PHP_EOL;
    echo 'expose_php: ' . ini_get('expose_php') . PHP_EOL;
    echo 'display_errors: ' . ini_get('display_errors') . PHP_EOL;
"

echo
echo "4. Проверка прав доступа к файлам..."
$DOCKER_COMPOSE exec php stat -c "%U:%G %a" /var/www/bitrix/upload 2>/dev/null || echo "Директория upload не найдена"

echo
echo "5. Проверка XDebug..."
$DOCKER_COMPOSE exec php php -m | grep -q xdebug && \
    echo "⚠️  XDebug включен (влияет на производительность)" || \
    echo "✅ XDebug не загружен"

echo
echo "6. Настройки окружения:"
grep -E "SECURITY_HARDENING|DEVELOPMENT_MODE|BLOCK_CRON_ACCESS" .env 2>/dev/null || \
    echo "   Переменные безопасности не найдены в .env"

echo
echo "=== Проверка безопасности завершена ===
"
echo "Для production окружения убедитесь:"
echo "- SECURITY_HARDENING=true"
echo "- DEVELOPMENT_MODE=false"
echo "- BLOCK_CRON_ACCESS=true"
echo "- Используйте отдельный контейнер для cron при необходимости"