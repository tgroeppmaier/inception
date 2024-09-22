FROM alpine:3.19

# Install necessary packages
RUN apk -U upgrade && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-openssl \
    php82-curl \
    php82-xml \
    php82-session \
    php82-mbstring \
    php82-phar \
    php82-zlib \
    php82-intl \
    php82-dom \
    php82-xmlreader \
    php82-ctype \
    php82-gd \
    php82-iconv \
    php82-simplexml \
    php82-exif \
    php82-fileinfo \
    php82-pecl-imagick \
    php82-zip \
    mysql-client \
    wget

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