FROM ubuntu:16.04

ENV ALLOW_OVERRIDE **False**
ENV TERM xterm

# Add repository
RUN apt-get update
RUN apt-get install --no-install-recommends -y software-properties-common python-software-properties
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update

# Install base packages
RUN apt-get install -y git curl nano wget vim make

# Install php
RUN apt-get install --no-install-recommends -y \
    php7.0 php7.0-cli php7.0-mysql php7.0-fpm \
    php7.0-curl php7.0-intl php7.0-dom php7.0-mbstring php7.0-zip \
    php7.0-xml php7.0-dev php-pear php7.0-bcmath

ADD config/www.conf /etc/php/7.0/fpm/pool.d
ADD config/memory-limit.ini /etc/php5/cli/conf.d/memory-limit.ini
ADD config/memory-limit.ini /etc/php5/fpm/conf.d/memory-limit.ini

# Install php additional packages

# Xdebug
RUN printf "\n" | pecl channel-update pecl.php.net
RUN printf "\n" | pecl install xdebug
RUN echo 'zend_extension="/usr/local/php/modules/xdebug.so"' >> /etc/php/7.0/cli/php.ini
RUN echo 'zend_extension="/usr/local/php/modules/xdebug.so"' >> /etc/php/7.0/fpm/php.ini
ADD config/xdebug.ini > /etc/php/7.0/cli/conf.d/20-xdebug.ini
ADD config/xdebug.ini > /etc/php/7.0/fpm/conf.d/20-xdebug.ini

# Mongo
RUN apt-get install --no-install-recommends -y pkg-config libssl-dev
RUN printf "\n" | pecl install mongodb
RUN echo "extension=mongodb.so" > /etc/php/7.0/mods-available/mongodb.ini
RUN ln -s /etc/php/7.0/mods-available/mongodb.ini /etc/php/7.0/cli/conf.d/20-mongodb.ini
RUN ln -s /etc/php/7.0/mods-available/mongodb.ini /etc/php/7.0/fpm/conf.d/20-mongodb.ini

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
RUN service php7.0-fpm start

CMD ["php-fpm7.0", "-F"]
EXPOSE 9000
