FROM debian:latest
RUN apt-get update && apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    curl zip unzip git lynx-cur msmtp rsyslog \
    apache2 libapache2-mod-php7.0 \
    php-pear \
    php7.0-curl \
    php7.0-memcached \
    php7.0-memcache \
    php7.0-mbstring \
    php7.0-mysql \
    php7.0-intl \
    php7.0-ldap \
    php7.0-xdebug \
    php7.0-soap \
    php7.0-gd \
    php7.0-imagick \
    php7.0-mcrypt \
#    php7.0-opcache \
    php7.0-zip

ENV APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_RUN_DIR=/var/run/apache2 \
    APACHE_PID_FILE=/var/run/apache2.pid 

COPY ./scripts/boot.sh /root/scripts/boot.sh
# COPY ./scripts/bx_cron /etc/cron.d/bx_cron
RUN chmod +x /root/scripts/* && rm -f /var/www/html/index.html
# && chmod 0644 /etc/cron.d/bx_cron

COPY ./conf/conf-available/* /etc/apache2/conf-available/
COPY ./conf/php.ini /etc/php/7.0/apache2/php.ini
COPY ./conf/php.ini /etc/php/7.0/cli/php.ini

COPY ./conf/conf-available/* /etc/apache2/conf-available/
COPY ./conf/mods-available/* /etc/apache2/mods-available/

RUN a2enmod remoteip && a2enconf remoteip && a2enmod php7.0 && a2enmod rewrite 
#ADD http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php /var/www/html
#ADD http://www.1c-bitrix.ru/download/scripts/restore.php /var/www/html/
#RUN chown -R www-data:www-data /var/www/html && chown -R www-data:www-data /var/lib/php

RUN usermod -u 1000 www-data

WORKDIR /var/www/
EXPOSE 80
CMD ["/root/scripts/boot.sh"]