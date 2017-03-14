FROM mariuszkraj/php:7.1

RUN apt-get update && apt-get install -y php7.1-xdebug

# Enable Remote xdebug
RUN echo "xdebug.idekey = PHPSTORM" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.default_enable = 0" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.remote_enable = 1" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.remote_autostart = 0" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.remote_connect_back = 0" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.profiler_enable = 0" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.remote_host = 10.200.10.1" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && echo "xdebug.max_nesting_level = 700" >> /etc/php/7.1/fpm/conf.d/20-xdebug.ini

# Disable xdebug for cli
RUN rm -f /etc/php/7.1/cli/conf.d/20-xdebug.ini

RUN service php7.1-fpm reload

RUN wget https://phar.phpunit.de/phpunit.phar \
    && chmod +x phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit

RUN wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && chmod +x phpcs.phar \
    && mv phpcs.phar /usr/local/bin/phpcs

RUN wget https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar \
    && chmod +x phpcbf.phar \
    && mv phpcbf.phar /usr/local/bin/phpcbf

RUN wget http://static.phpmd.org/php/latest/phpmd.phar \
    && chmod +x phpmd.phar \
    && mv phpmd.phar /usr/local/bin/phpmd

RUN wget https://phar.phpunit.de/phpcpd.phar \
    && chmod +x phpcpd.phar \
    && mv phpcpd.phar /usr/local/bin/phpcpd

RUN wget http://static.pdepend.org/php/latest/pdepend.phar \
    && chmod +x pdepend.phar \
    && mv pdepend.phar /usr/local/bin/pdepend

RUN wget https://phar.phpunit.de/phploc.phar \
    && chmod +x phploc.phar \
    && mv phploc.phar /usr/local/bin/phploc

RUN wget http://codeception.com/codecept.phar \
    && chmod +x codecept.phar \
    && mv codecept.phar /usr/local/bin/codecept
