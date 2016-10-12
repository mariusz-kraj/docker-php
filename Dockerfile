FROM ubuntu:16.04

ENV ALLOW_OVERRIDE **False**
ENV TERM xterm

RUN apt-get install -y software-properties-common python-software-properties
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php
