FROM php:8.0-fpm

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

# Используется официальный образ php:8.0-fpm вместо phpdockerio/php:8.0-fpm
# т.к. пакеты для PHP 8.0 больше не доступны в ondrej/php PPA после достижения EOL.
# Расширения устанавливаются через компиляцию из исходников.

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libzip-dev \
    libmemcached-dev \
    libxml2-dev \
    libicu-dev \
    libmagickwand-dev \
    zlib1g-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) \
    gd \
    intl \
    mysqli \
    pdo_mysql \
    soap \
    zip \
    opcache \
    && pecl install memcache-8.0 \
    && pecl install memcached-3.2.0 \
    && pecl install imagick \
    && docker-php-ext-enable memcache memcached imagick \
    && apt-get install -y --no-install-recommends \
    libfreetype6 \
    libjpeg62-turbo \
    libpng16-16 \
    libwebp6 \
    libzip4 \
    libmemcached11 \
    libicu67 \
    libmagickwand-6.q16-6 \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libzip-dev \
    libxml2-dev \
    libicu-dev \
    libmagickwand-dev \
    zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY ./php.ini /usr/local/etc/php/conf.d/90-php.ini

# Создаем симлинки для обратной совместимости с phpdockerio/php:8.0-fpm
# чтобы поддержать существующие volume mounts
RUN mkdir -p /etc/php/8.0/fpm /etc/php/8.0/cli \
    && ln -s /usr/local/etc/php/conf.d /etc/php/8.0/fpm/conf.d \
    && ln -s /usr/local/etc/php/conf.d /etc/php/8.0/cli/conf.d \
    && ln -s /usr/local/etc/php-fpm.d /etc/php/8.0/fpm/pool.d

RUN usermod -u 1000 www-data

RUN echo "www-data" > /etc/cron.deny && chmod 644 /etc/cron.deny

WORKDIR "/var/www/bitrix"

EXPOSE 9000
