FROM alpine:3.19

# Install necessary packages
RUN apk -U upgrade && apk add --no-cache \
    php \
    php-fpm \
    php-mysqli \
    php-json \
    php-openssl \
    php-curl \
    php-xml \
    php-session \
    php-mbstring \
    php-phar \
    php-zlib \
    php-intl \
    php-dom \
    php-xmlreader \
    php-ctype \
    php-gd \
    php-iconv \
    php-simplexml \
    php-exif \
    php-fileinfo \
    php82-pecl-imagick \
    php-zip \
    mysql-client \
    wget \
    openrc \
    php-zlib \
    php-intl \
    php-dom \
    php-xmlreader \
    php-ctype \
    php-gd \
    php-iconv \
    php-simplexml \
    php-tokenizer \
    unzip 

# Create the group 'website1' with a specific GID
RUN addgroup -g 1001 -S website1

# Create the user 'website1' with a specific UID and add it to the 'website1' group
RUN adduser -u 1001 -G website1 -S -H website1

# Create the /var/www/html directory
RUN mkdir -p /var/www/html

# Configure PHP-FPM
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf

# Set up WordPress configuration
COPY tools/wp-config-create.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-config-create.sh

# Set working directory
WORKDIR /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp-config-create.sh"]