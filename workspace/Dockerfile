ARG PHP_WORKSPACE_VERSION
FROM phpdockerio/php:$PHP_WORKSPACE_VERSION-cli

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php$PHP_WORKSPACE_VERSION-mbstring \
    php$PHP_WORKSPACE_VERSION-zip \
    git \
    iputils-ping \
    nano \
    ssh \    
    vim \    
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN usermod -u 1000 www-data

WORKDIR "/var/www/bitrix"

# necessary for vscode-server
RUN chown www-data:www-data /var/www

# install nvm nodejs npm bitrix/cli
USER www-data
ARG NODE_VERSION
ENV NVM_DIR=/var/www/.nvm
RUN mkdir -p /var/www/.nvm && touch /var/www/.bashrc
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
    bash -c "source $NVM_DIR/nvm.sh && nvm install ${NODE_VERSION} && nvm alias default $NODE_VERSION && \
    nvm use default"
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN npm install --global @bitrix/cli
USER root

# necessary for vscode-server
ENV SHELL /bin/bash