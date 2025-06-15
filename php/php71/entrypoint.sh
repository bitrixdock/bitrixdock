#!/bin/bash
set -e

# Применение конфигурации безопасности если включено
if [ "$SECURITY_HARDENING" = "true" ]; then
    echo "Применение усиленной безопасности..."
    cp /tmp/php-security.ini /etc/php/7.1/fpm/conf.d/99-security.ini
    cp /tmp/php-security.ini /etc/php/7.1/cli/conf.d/99-security.ini
    
    # Условное отключение опасных функций
    if [ "$DISABLE_DANGEROUS_FUNCTIONS" = "false" ]; then
        echo "Опасные функции остаются включенными (не рекомендуется для production)"
        sed -i 's/^disable_functions.*/; disable_functions = /' /etc/php/7.1/fpm/conf.d/99-security.ini
        sed -i 's/^disable_functions.*/; disable_functions = /' /etc/php/7.1/cli/conf.d/99-security.ini
    fi
fi

# Применение настроек режима разработки/production
if [ "$DEVELOPMENT_MODE" = "false" ]; then
    echo "Применение настроек production..."
    # Переопределение настроек разработки
    echo "display_errors = Off" > /etc/php/7.1/fpm/conf.d/95-production.ini
    echo "display_startup_errors = Off" >> /etc/php/7.1/fpm/conf.d/95-production.ini
    echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT" >> /etc/php/7.1/fpm/conf.d/95-production.ini
fi

# Выполнение оригинальной команды
exec "$@"