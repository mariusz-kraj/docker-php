FROM ubuntu:16.04

ENV ALLOW_OVERRIDE **False**
ENV TERM xterm

# Add repository
RUN apt-get autoclean && apt-get update
RUN apt-get install --no-install-recommends -y software-properties-common python-software-properties
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update

# Install base packages
RUN apt-get install -y git curl nano wget vim

# Install php
RUN apt-get install --no-install-recommends -y \
    php5.6 php5.6-cli php5.6-mysql php5.6-fpm \
    php5.6-curl php5.6-intl php5.6-dom php5.6-mbstring php5.6-zip \
    php5.6-xml php5.6-dev php-pear php5.6-bcmath php5.6-mcrypt

RUN mkdir -p /var/log/php
RUN sed -ie 's/;error_log = syslog/error_log = \/var\/log\/php\/error.log/g' /etc/php/5.6/fpm/php.ini
RUN sed -ie 's/memory_limit = 128M/memory_limit = 1024M/g' /etc/php/5.6/fpm/php.ini

RUN sed -ie 's/listen = \/run\/php\/php5.6-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/5.6/fpm/pool.d/www.conf
RUN service php5.6-fpm reload

# Install php additional packages

# Mongo
RUN apt-get install --no-install-recommends -y pkg-config libssl-dev
RUN printf "\n" | pecl install mongodb
RUN echo "extension=mongodb.so" > /etc/php/5.6/mods-available/mongodb.ini
RUN ln -s /etc/php/5.6/mods-available/mongodb.ini /etc/php/5.6/cli/conf.d/20-mongodb.ini
RUN ln -s /etc/php/5.6/mods-available/mongodb.ini /etc/php/5.6/fpm/conf.d/20-mongodb.ini

# Symfony installer
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH $PATH:/usr/share/nginx/html/app/vendor/bin

# Phing
RUN wget http://www.phing.info/get/phing-latest.phar
RUN mv phing-latest.phar /usr/local/bin/phing
RUN chmod +x /usr/local/bin/phing

# Running fpm service
RUN service php5.6-fpm start

CMD ["php-fpm5.6", "-F"]
EXPOSE 9000
