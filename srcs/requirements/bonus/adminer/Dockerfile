FROM alpine:3.19

RUN apk -U upgrade && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-session \
    php82-pdo \
    php82-pdo_mysql \
    openrc \
    wget

RUN mkdir -p /var/www/html

RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O /var/www/html/adminer.php

RUN adduser -u 82 -D -S -G www-data www-data

COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf

WORKDIR /var/www/html

CMD ["php-fpm82"]
