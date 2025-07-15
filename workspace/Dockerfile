ARG PHP_WORKSPACE_VERSION
FROM phpdockerio/php:$PHP_WORKSPACE_VERSION-cli

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

ARG PHP_WORKSPACE_VERSION
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php$PHP_WORKSPACE_VERSION-mbstring \
    php$PHP_WORKSPACE_VERSION-memcache \
    php$PHP_WORKSPACE_VERSION-mysql \
    php$PHP_WORKSPACE_VERSION-tokenizer \
    php$PHP_WORKSPACE_VERSION-xml \
    php$PHP_WORKSPACE_VERSION-zip \
    git \
    iputils-ping \
    mc \
    nano \
    ssh \
    vim \
    zsh \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN id ubuntu &>/dev/null && userdel -r ubuntu || true
RUN usermod -u 1000 www-data

WORKDIR "/var/www/bitrix"

# necessary for vscode-server
RUN chown www-data:www-data /var/www

# install nodejs
USER www-data
ARG NODE_VERSION
ENV NVM_DIR /var/www/.nvm
RUN mkdir -p /var/www/.nvm && touch /var/www/.bashrc
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
    bash -c "source $NVM_DIR/nvm.sh && nvm install ${NODE_VERSION} && nvm alias default $NODE_VERSION && \
    nvm use default"
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# install nodejs tools
RUN npm install --global npm yarn pnpm@latest-10 @bitrix/cli

# install zsh
RUN sh -c "$(curl -L https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)" -- \
    -t robbyrussell \
    -p git \
    -p https://github.com/lukechilds/zsh-nvm \
    -x

COPY ./php.ini /etc/php/$PHP_WORKSPACE_VERSION/cli/conf.d/90-custom.ini

# necessary for vscode-server
ENV SHELL /usr/bin/zsh
