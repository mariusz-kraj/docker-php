FROM ubuntu:16.04

ENV ALLOW_OVERRIDE **False**
ENV TERM xterm

# Add repository
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update

# Install base packages
RUN apt-get install -y git curl nano wget vim

# Install php
RUN apt-get install -y php7.1 php7.1-cli php7.1-mysql php7.1-fpm \
    php7.1-curl php7.1-intl php7.1-dom php7.1-mbstring php7.1-zip \
    php7.1-xml php7.1-dev php-pear php7.1-bcmath
