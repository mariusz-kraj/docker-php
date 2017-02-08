FROM mariusz-kraj:7.1

RUN apt-get install -y php7.1-xdebug

# Enable Remote xdebug
RUN echo "xdebug.idekey = PHPSTORM" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.default_enable = 0" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.remote_enable = 1" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.remote_autostart = 0" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.remote_connect_back = 0" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.profiler_enable = 0" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.remote_host = 10.200.10.1" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.max_nesting_level = 700" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini

RUN service php7.1-fpm reload
