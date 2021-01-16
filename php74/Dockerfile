FROM phpdockerio/php74-fpm:latest

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php7.4-memcached \
    php7.4-memcache \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-intl \
    php7.4-xdebug \
    php7.4-interbase \
    php7.4-soap \
    php7.4-gd \
    php7.4-imagick \
    php7.4-opcache \
    php7.4-zip \
    php-pear php7.4-dev libmcrypt-dev gcc make autoconf libc-dev pkg-config \
    && pecl install mcrypt-1.0.4 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# DO NOT install php7.4-xdebug package for site running in production! It will slow it down significantly.

ADD ./php.ini /etc/php/7.4/fpm/conf.d/90-php.ini
ADD ./php.ini /etc/php/7.4/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data

WORKDIR "/var/www/bitrix"

EXPOSE 9000
