FROM php:7.4-fpm-alpine

# Install necessary PHP extensions and other dependencies
RUN apk add --no-cache \
    mysql-client \
    netcat-openbsd \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set up WordPress
WORKDIR /var/www/html
RUN wp core download --allow-root

# Set up entrypoint script
COPY ./tools/wordpress-setup.sh /wordpress-setup.sh
RUN chmod +x /wordpress-setup.sh

EXPOSE 9000

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD php-fpm -v || exit 1

ENTRYPOINT ["/wordpress-setup.sh"]
CMD ["php-fpm"]

# FROM alpine:3.14

# # Install dependencies
# RUN apk update && apk add --no-cache \
#     php7 \
#     php7-fpm \
#     php7-mysqli \
#     wget \
#     unzip

# # Create the www-data user and group
# #RUN addgroup -S www-data && adduser -S www-data -G www-data
# RUN adduser -S www-data -G www-data

# # Create the /var/www/html directory
# RUN mkdir -p /var/www/html

# # Install WordPress
# RUN wget https://wordpress.org/latest.zip \
#     && unzip latest.zip \
#     && mv wordpress/* /var/www/html/ \
#     && rm latest.zip \
#     && chown -R www-data:www-data /var/www/html \
#     && chmod -R 755 /var/www/html

# # Configure PHP-FPM
# COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

# # Set up WordPress configuration
# COPY tools/wp-config-create.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/wp-config-create.sh

# # Set working directory
# WORKDIR /var/www/html

# # Expose port 9000 for PHP-FPM
# EXPOSE 9000

# # Start PHP-FPM
# CMD ["php-fpm7", "-F"]