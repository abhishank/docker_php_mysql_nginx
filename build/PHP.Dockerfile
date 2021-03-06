FROM php:7.4-fpm
#maintained by: abhishank@yahoo.com

# RUN pecl install xdebug && docker-php-ext-enable xdebug


COPY --from=composer:1.10.22 /usr/bin/composer /usr/local/bin/composer

RUN apt-get update \
    && apt-get install -y \
        git zip unzip zlib1g-dev libzip-dev libicu-dev libxml2-dev \
        libpng-dev g++ libxslt-dev libfreetype6-dev libjpeg62-turbo-dev \
        cron \
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

# RUN mkdir -p /home/www-data/.ssh/
# COPY keys/config /home/www-data/.ssh/config
# COPY keys/aws-code-commit-ssh.pub /home/www-data/.ssh/aws-code-commit-ssh.pub
# RUN chmod -R 0600 /home/www-data/.ssh/*
# RUN chown -R www-data:www-data /home/www-data/.ssh/*

RUN mkdir -p /var/www/.ssh/
COPY keys/config /var/www/.ssh/config
COPY keys/aws-code-commit-ssh /var/www/.ssh/aws-code-commit-ssh
RUN chmod -R 0700 /var/www/.ssh
RUN chmod 600 /var/www/.ssh/aws-code-commit-ssh
RUN chown -R www-data:www-data /var/www/


RUN mkdir /var/log/cron
RUN touch /var/log/cron/cron.log
RUN chown -R www-data:www-data /var/log/cron
COPY cronSchedule /cronSchedule
RUN /usr/bin/crontab -u www-data /cronSchedule
# CMD ["cron", "-f"]
CMD cron && docker-php-entrypoint php-fpm


WORKDIR /home/projects/public_erp


# COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
# RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# CMD ["/usr/local/bin/docker-entrypoint.sh"]