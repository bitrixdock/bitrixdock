FROM phpdockerio/php:8.0-fpm

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php8.0-curl \
    php8.0-mbstring \
    php8.0-opcache \
    php8.0-xml \
    php8.0-zip \
    php-gd \
    php-imagick \
    php-intl \
    php-memcached \
    php-mysql \
    php-soap \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY ./php.ini /etc/php/8.0/fpm/conf.d/90-php.ini
COPY ./php.ini /etc/php/8.0/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data

WORKDIR "/var/www/bitrix"

EXPOSE 9000
