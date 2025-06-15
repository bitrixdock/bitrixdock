ARG PHP_VERSION=php74
FROM phpdockerio/php:7.4-fpm

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

# Установить cron
RUN apt-get update && apt-get install -y cron \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Копировать конфигурацию PHP (использовать из php контейнера)
COPY ./php/${PHP_VERSION}/php.ini /tmp/php-base.ini

# Копировать конфигурацию безопасности для cron
COPY ./cron/php-cron-security.ini /tmp/php-cron-security.ini
COPY ./cron/configure-php.sh /usr/local/bin/configure-php.sh
RUN chmod +x /usr/local/bin/configure-php.sh

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