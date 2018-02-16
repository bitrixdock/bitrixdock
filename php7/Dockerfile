FROM phpdockerio/php7-fpm:latest

MAINTAINER vitams

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php7.0-memcached \
    php7.0-memcache \
    php7.0-mbstring \
    php7.0-mysql \
    php7.0-intl \
    php7.0-xdebug \
    php7.0-soap \
    php7.0-gd \
    php7.0-imagick \
    php7.0-mcrypt \
    php7.0-opcache \
    php7.0-zip \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

ADD ./php.ini /etc/php/7.0/fpm/conf.d/90-php.ini
ADD ./php.ini /etc/php/7.0/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data

EXPOSE 9000

WORKDIR "/var/www/bitrix"
