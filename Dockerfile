FROM samber/github-actions-runner:latest

ENV PACKAGES="php7.4-fpm \
    php7.4-cli \
    php7.4-common \
    php7.4-curl \
    php7.4-gd \
    php7.4-intl \
    php7.4-pgsql \
    php7.4-json \
    php7.4-redis \
    php7.4-mbstring \
    php7.4-bcmath \
    php7.4-xml \
    php-mail-mime \
    rsync \
    pssh \
    php7.4-phpdbg \
    php7.4-zip \
    libargon2-1 libidn2-0 libpcre2-8-0 libpcre3 libxml2 libzstd1"

USER root

### PERMISSION TO RUN CONTAINERS ###
RUN groupadd -g 993 docker

RUN usermod -aG docker runner

### PHP ###
RUN curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
    && apt-get update && apt-get install -y -q $PACKAGES \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

### COMPOSER ###
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

### NODE ###
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get update \
    && apt-get install -y -q nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

### AWS CLI ###
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf ./aws awscliv2.zip

RUN npm install -g yarn

### Fix to use actions/setup-python ###
ENV AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache
RUN mkdir -p /opt/hostedtoolcache \
    && mkdir -p _work \
    && ln -s /opt/hostedtoolcache _work/_tool \
    && chown -R runner:runner /opt _work
ADD ./lsb-release /etc

USER runner

CMD /start.sh ; sleep infinity