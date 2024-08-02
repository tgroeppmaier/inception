FROM alpine:3.14

# Install dependencies
RUN apk update && apk add --no-cache \
    php7 \
    php7-fpm \
    php7-mysqli \
    wget \
    unzip

# Create the /var/www/html directory
RUN mkdir -p /var/www/html

# Install WordPress
RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && mv wordpress/* /var/www/html/ \
    && rm latest.zip \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Configure PHP-FPM
COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

# Set up WordPress configuration
COPY tools/wp-config-create.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-config-create.sh

# Set working directory
WORKDIR /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm7", "-F"]