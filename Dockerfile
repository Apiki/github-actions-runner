FROM samber/github-actions-runner:latest

ENV PACKAGES="php7.2-fpm \
    php7.2-cli \
    php7.2-common \
    php7.2-curl \
    php7.2-gd \
    php7.2-intl \
    php7.2-pgsql \
    php7.2-json \
    php7.2-redis \
    php7.2-mbstring \
    php7.2-bcmath \
    php-mail-mime \
    rsync \
    pssh"

USER root

### PERMISSION TO RUN CONTAINERS ###
RUN groupadd -g 993 docker

RUN usermod -aG docker runner


### PHP ###
RUN curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
    && apt-get update && apt-get install -y -q $PACKAGES \
    && apt-get clean                        \
    && rm -rf /var/lib/apt/lists/*

RUN curl -k -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ \
    && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

### NODE ###
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get update \
    && apt-get install -y -q nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn

USER runner

CMD /start.sh ; sleep infinity