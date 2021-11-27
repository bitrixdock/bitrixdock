#!/bin/sh
set -e

# This script is meant for quick & easy install via:
#   $ curl -fsSL https://raw.githubusercontent.com/bitrixdock/bitrixdock/master/install.sh -o install.sh | sh install.sh

echo "Check requirments"
[ ! hash git ] && apt-get install -y git
[ ! hash docker ] && cd /usr/local/src && wget -qO- https://get.docker.com/ | sh
[ ! hash docker-compose ] && curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose && source ~/.bashrc

echo "Create folder struct"
git clone https://github.com/Cheplev/bitrixdock.git && \
chmod -R 775 pwd | sed 's#.*/##'/ && chown -R root:www-data pwd | sed 's#.*/##'/ && \
echo 'Download restore.php'
mkdir www && cd www && \
wget http://www.1c-bitrix.ru/download/scripts/restore.php && \
cd ../bitrixdock

echo "Config"
cp -f .env_template .env

echo "Run"
docker-compose up -d
