#!/bin/sh
set -e

# This script is meant for quick & easy install via:
#   $ curl -fsSL https://raw.githubusercontent.com/bitrixdock/bitrixdock/master/install.sh -o install.sh | sh install.sh

echo "Check requirments"
[ ! hash git ] && apt-get install -y git
[ ! hash docker ] && cd /usr/local/src && wget -qO- https://get.docker.com/ | sh
[ ! hash docker-compose ] && curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose && source ~/.bashrc

echo "Create folder struct"
mkdir -p /var/www/bitrix && \
cd /var/www/bitrix && \
wget http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php && \
cd /var/www/ && \
git clone https://github.com/bitrixdock/bitrixdock.git && \
cd /var/ && chmod -R 775 www/ && chown -R root:www-data www/ && \
cd /var/www/bitrixdock

echo "Config"
cp -f .env_template .env

echo "Run"
docker-compose up -d