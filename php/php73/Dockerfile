FROM phpdockerio/php73-fpm:latest

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php7.3-memcached \
    php7.3-memcache \
    php7.3-mbstring \
    php7.3-mysql \
    php7.3-intl \
    php7.3-interbase \
    php7.3-xdebug \
    php7.3-soap \
    php7.3-gd \
    php7.3-imagick \
    php7.3-ldap \
    php7.3-opcache \
    php7.3-zip \
    php-pear php-dev libmcrypt-dev gcc make autoconf libc-dev pkg-config \
    && pecl install mcrypt-1.0.3 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# DO NOT install php7.3-xdebug package for site running in production! It will slow it down significantly.

COPY ./php.ini /etc/php/7.3/fpm/conf.d/90-php.ini
COPY ./php.ini /etc/php/7.3/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data

WORKDIR "/var/www/bitrix"

EXPOSE 9000
