FROM php:7.3-fpm

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

# Используется официальный образ php:7.3-fpm вместо phpdockerio/php73-fpm
# т.к. пакеты для PHP 7.3 больше не доступны в ondrej/php PPA после достижения EOL.
# Расширения устанавливаются через компиляцию из исходников.

# Debian bullseye LTS ended on 2026-08-31. The last bullseye-security index
# on deb.debian.org expired on 2026-09-07 and its pool no longer holds every
# package that index lists, so the build uses the Debian snapshot of the
# final LTS day for all three suites. check-valid-until is off for these
# sources only, their Release files are older than apt allows by default.
RUN printf '%s\n' \
    'deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/20260901T000000Z bullseye main' \
    'deb [check-valid-until=no] http://snapshot.debian.org/archive/debian-security/20260901T000000Z bullseye-security main' \
    'deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/20260901T000000Z bullseye-updates main' \
    > /etc/apt/sources.list

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
    && docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-webp-dir=/usr \
    && docker-php-ext-install -j$(nproc) \
    gd \
    intl \
    mysqli \
    pdo_mysql \
    soap \
    zip \
    opcache \
    && curl -fSL -o /tmp/memcache.tgz https://pecl.php.net/get/memcache-4.0.5.2.tgz \
    && curl -fSL -o /tmp/memcached.tgz https://pecl.php.net/get/memcached-3.4.0.tgz \
    && curl -fSL -o /tmp/imagick.tgz https://pecl.php.net/get/imagick-3.8.1.tgz \
    && pecl install /tmp/memcache.tgz \
    && pecl install /tmp/memcached.tgz \
    && pecl install /tmp/imagick.tgz \
    && rm -f /tmp/memcache.tgz /tmp/memcached.tgz /tmp/imagick.tgz \
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

# Создаем симлинки для обратной совместимости с phpdockerio/php73-fpm
# чтобы поддержать существующие volume mounts
RUN mkdir -p /etc/php/7.3/fpm /etc/php/7.3/cli \
    && ln -s /usr/local/etc/php/conf.d /etc/php/7.3/fpm/conf.d \
    && ln -s /usr/local/etc/php/conf.d /etc/php/7.3/cli/conf.d \
    && ln -s /usr/local/etc/php-fpm.d /etc/php/7.3/fpm/pool.d

RUN usermod -u 1000 www-data

RUN echo "www-data" > /etc/cron.deny && chmod 644 /etc/cron.deny

WORKDIR "/var/www/bitrix"

EXPOSE 9000
