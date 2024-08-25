FROM alpine:3.19

# Install dependencies
RUN apk -U upgrade && apk add --no-cache \

    php83 \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-openssl \
    php83-curl \
    php83-xml \
    php83-session \
    php83-mbstring \
    php83-phar \
    # php83-zlib \
    # php83-intl \
    # php83-dom \
    # php83-xmlreader \
    # php83-ctype \
    # php83-gd \
    # php83-iconv \
    # php83-simplexml \
    wget \
    # unzip \
    mysql-client \
    openrc



# Create the www-data user and group
RUN adduser -D -S -H -u 82 -G www-data www-data

# Create the /var/www/html directory
RUN mkdir -p /var/www/html

# Install WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz \
    && mv wordpress/* /var/www/html/ \
    && rm latest.tar.gz \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Configure PHP-FPM
COPY conf/www.conf /etc/php83/php-fpm.d/www.conf

# Set up WordPress configuration
COPY tools/wp-config-create.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-config-create.sh

# Set working directory
WORKDIR /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

CMD ["/bin/sh", "-c", "/usr/local/bin/wp-config-create.sh && php-fpm83 -F"]
