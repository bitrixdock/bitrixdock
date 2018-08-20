FROM php:7.1.20-alpine

RUN apk add --no-cache --virtual .build-deps \
	    $PHPIZE_DEPS \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd opcache mysqli \
    && docker-php-ext-enable gd opcache mysqli \
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --no-cache --virtual .php-rundeps \
	    freetype \
	    libpng \
	    libjpeg \
	&& apk del .build-deps \
	&& rm -rf /tmp/pear ~/.pearrc

WORKDIR /var/www/bitrix
