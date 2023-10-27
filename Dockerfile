FROM ubuntu:22.045

LABEL version="0.1"
LABEL description="This is the custm EMP LAMP Stack image."

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update

# Install apache, php
RUN apt install -y apache2 php && \
    apt install php8.1-common php8.1-mysql php-pdo php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-dev php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip php8.1-intl -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

RUN mkdir -p /run/php && \
    chown -R www-data:www-data /var/www && \
    chown -R www-data:www-data /run/php


RUN rm /var/www/html/index.html
COPY index.html /var/www/html/


WORKDIR /var/www/
COPY --from=composer:2.0.4 /usr/bin/composer /usr/local/bin/composer
RUN chown -R www-data:www-data /var/www/html/

CMD apachectl -D FOREGROUND