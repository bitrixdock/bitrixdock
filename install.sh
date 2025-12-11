#!/bin/sh
set -e

# Default installation path is current directory, can be overridden via first argument
INSTALL_PATH="${1:-.}"

# Detect OS once
OS="$(uname)"

mkdir -p "$INSTALL_PATH"
cd "$INSTALL_PATH"

# Normalize to absolute path after cd
INSTALL_PATH="$(pwd -P)"

echo "Installing to: $INSTALL_PATH"

echo "Clone repository"
rm -rf "$INSTALL_PATH/bitrixdock"
git clone --depth=1 https://github.com/bitrixdock/bitrixdock.git

echo "Create folder struct"
mkdir -p "$INSTALL_PATH/bitrixdock/www"
rm -f "$INSTALL_PATH/bitrixdock/www/bitrixsetup.php"
curl -fsSL https://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -o "$INSTALL_PATH/bitrixdock/www/bitrixsetup.php"
chmod -R 775 "$INSTALL_PATH/bitrixdock/www"

# Set ownership only on Linux (macOS doesn't have www-data group by default)
if [ "$OS" = "Linux" ]; then
    chown -R root:www-data "$INSTALL_PATH/bitrixdock/www"
fi

echo "Config"
cp -f "$INSTALL_PATH/bitrixdock/.env_template" "$INSTALL_PATH/bitrixdock/.env"

echo "Run"
docker compose -f "$INSTALL_PATH/bitrixdock/docker-compose.yml" -p bitrixdock down 2>/dev/null || true
docker compose -f "$INSTALL_PATH/bitrixdock/docker-compose.yml" -p bitrixdock up -d
