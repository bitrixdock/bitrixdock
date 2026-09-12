FROM bitrixdock/php71-fpm:latest

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

MAINTAINER vitams

COPY ./php.ini /etc/php/7.1/fpm/conf.d/90-php.ini
COPY ./php.ini /etc/php/7.1/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data

RUN echo "www-data" > /etc/cron.deny && chmod 644 /etc/cron.deny

WORKDIR "/var/www/bitrix"

# php-fpm готов, когда принимает соединения на порту 9000
HEALTHCHECK --interval=30s --timeout=10s --retries=10 --start-period=10s \
    CMD php -r 'exit(@fsockopen("127.0.0.1", 9000) ? 0 : 1);'

EXPOSE 9000