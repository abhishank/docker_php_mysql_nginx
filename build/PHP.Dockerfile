FROM php:7.4-fpm

# RUN pecl install xdebug && docker-php-ext-enable xdebug


COPY --from=composer:1.10.22 /usr/bin/composer /usr/local/bin/composer

RUN apt-get update \
    && apt-get install -y git zip unzip zlib1g-dev libzip-dev libicu-dev libxml2-dev libpng-dev g++ libxslt-dev libfreetype6-dev libjpeg62-turbo-dev     \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath intl gd zip soap xsl sockets

RUN docker-php-ext-configure intl

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
    
ADD . /home/projects/public

RUN chmod -R 777 /var/www/

RUN usermod -u 1000 www-data

RUN mkdir -p /home/www-data/.ssh/
COPY keys/config /home/www-data/.ssh/config
COPY keys/code_commit_rsa /home/www-data/.ssh/code_commit_rsa
RUN chmod -R 0600 /home/www-data/.ssh/*
RUN chown -R www-data:www-data /home/www-data/.ssh/*

WORKDIR /home/projects/public


# COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
# RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# CMD ["/usr/local/bin/docker-entrypoint.sh"]