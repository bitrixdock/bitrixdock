FROM phpdockerio/php:7.4-fpm

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

# Установить cron
RUN apt-get update && apt-get install -y cron \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Копировать конфигурацию PHP (использовать из php контейнера)
COPY ./php/php74/php.ini /etc/php/7.4/cli/conf.d/90-php.ini

# Копировать конфигурацию безопасности для cron
COPY ./cron/php-cron-security.ini /etc/php/7.4/cli/conf.d/99-security.ini

# Копировать crontab
COPY ./cron/bitrix.cron /etc/cron.d/bitrix
RUN chmod 0644 /etc/cron.d/bitrix

# Создать директорию для логов
RUN mkdir -p /var/log/cron && chmod 755 /var/log/cron

# Entrypoint для обработки переменных окружения
COPY ./cron/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/bitrix

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["cron", "-f"]