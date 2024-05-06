FROM php:7.4.33-fpm-bookworm

# Install general debian packages and php extensions
RUN apt-get update \
    && apt-get install -y \
        vim \
        curl \
        zsh \
        wget \
        dnsutils \
    && rm -rf /var/lib/apt/lists/*  \

# Add extension manager https://github.com/mlocati/docker-php-extension-installer and install php extensions needed by our projects
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions \
    xdebug \
    gd \
    mbstring \
    mysqli \
    opcache \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    zip \
    imagick \
    redis \
    bcmath \
    mongodb \
    blackfire \
    grpc \
    protobuf

# Install and configure OhMyZSH
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
    && sed -i -e "s/bin\/bash/bin\/zsh/" /etc/passwd \
    && echo "echo \"===========================================================\"" >> ~/.bashrc \
    && echo "echo \"This container has zsh installed, use that instead of bash!\"" >> ~/.bashrc \
    && echo "echo \"===========================================================\"" >> ~/.bashrc

# Add a simple vimrc for highlighting and numbers
RUN echo "set number\nsyntax on" > ~/.vimrc

# Add composer vendor binaries to path, primarily for Drush
ENV PATH="/var/www/vendor/bin:${PATH}" \
    SHELL="/bin/zsh" \
    TERM="xterm" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

# Use the provided default configuration for a production environment.
# We will override anything needed for dev with overlayed configuration.
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Add xdebug configuration to prevent always on behavior and preserve performance with 'trigger mode'
COPY zz-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug.ini

RUN mkdir -p /var/www/docroot

WORKDIR /var/www/docroot
