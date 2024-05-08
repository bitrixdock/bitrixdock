FROM bitrixdock/php71-fpm:latest

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

MAINTAINER vitams

COPY ./php.ini /etc/php/7.1/fpm/conf.d/90-php.ini
COPY ./php.ini /etc/php/7.1/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data

WORKDIR "/var/www/bitrix"

EXPOSE 9000