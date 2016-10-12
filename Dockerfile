FROM ubuntu:16.04

ENV ALLOW_OVERRIDE **False**
ENV TERM xterm

RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php
