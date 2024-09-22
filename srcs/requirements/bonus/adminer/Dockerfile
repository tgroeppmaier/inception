FROM alpine:3.19

# Install necessary packages
RUN apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-json \
    php81-session \
    php81-mbstring \
    php81-iconv \
    php81-openssl \
    php81-pdo \
    php81-pdo_mysql \
    php81-tokenizer \
    php81-xml \
    php81-simplexml \
    php81-ctype \
    php81-fileinfo \
    php81-phar \
    php81-dom \
    php81-xmlreader \
    php81-xmlwriter \
    php81-zip \
    mariadb-client \
    wget

# Create the target directory
RUN mkdir -p /var/www/html

# Download Adminer
RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O /var/www/html/adminer.php

# Create a PHP-FPM configuration file
RUN adduser -u 82 -D -S -G www-data www-data

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

STOPSIGNAL SIGQUIT

EXPOSE 9000

WORKDIR /var/www/html

CMD ["php-fpm81", "-F"]

# FROM alpine:3.19

# # Install necessary packages
# RUN apk add --no-cache \
#     php81 \
#     php81-fpm \
#     php81-mysqli \
#     php81-json \
#     php81-session \
#     php81-pdo \
#     php81-pdo_mysql \
#     wget

# # Create the www-data user and group
# RUN adduser -u 82 -D -S -G www-data www-data

# # Create the target directory and set permissions
# RUN mkdir -p /var/www/html && \
#     chown -R www-data:www-data /var/www/html

# # Download Adminer
# RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O /var/www/html/index.php && \
#     chown www-data:www-data /var/www/html/index.php

# # Configure PHP-FPM
# COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

# WORKDIR /var/www/html

# EXPOSE 9000

# CMD ["php-fpm81", "-F"]