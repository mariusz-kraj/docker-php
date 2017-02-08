FROM ubuntu:16.04

ENV ALLOW_OVERRIDE **False**
ENV TERM xterm

# Add repository
RUN apt-get update
RUN apt-get install --no-install-recommends -y software-properties-common python-software-properties
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update

# Install base packages
RUN apt-get install -y git curl nano wget vim

# Install php
RUN apt-get install --no-install-recommends -y \
    php7.1 php7.1-cli php7.1-mysql php7.1-fpm \
    php7.1-curl php7.1-intl php7.1-dom php7.1-mbstring php7.1-zip \
    php7.1-xml php7.1-dev php-pear php7.1-bcmath php7.1-mcrypt

RUN mkdir -p /var/log/php
RUN sed -ie 's/;error_log = syslog/error_log = \/var\/log\/php\/error.log/g' /etc/php/7.1/fpm/php.ini
RUN sed -ie 's/memory_limit = 128M/memory_limit = 1024M/g' /etc/php/7.1/fpm/php.ini

RUN sed -ie 's/listen = \/run\/php\/php7.1-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.1/fpm/pool.d/www.conf
RUN service php7.1-fpm reload

# Install php additional packages

# Mongo
RUN apt-get install --no-install-recommends -y pkg-config libssl-dev
RUN printf "\n" | pecl install mongodb
RUN echo "extension=mongodb.so" > /etc/php/7.1/mods-available/mongodb.ini
RUN ln -s /etc/php/7.1/mods-available/mongodb.ini /etc/php/7.1/cli/conf.d/20-mongodb.ini
RUN ln -s /etc/php/7.1/mods-available/mongodb.ini /etc/php/7.1/fpm/conf.d/20-mongodb.ini

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
RUN service php7.1-fpm start

CMD ["php-fpm7.1", "-F"]
EXPOSE 9000
