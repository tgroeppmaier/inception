FROM alpine:3.14

# Install dependencies
RUN apk update && apk add --no-cache \
    php7 \
    php7-fpm \
    php7-mysqli \
    php7-json \
    php7-openssl \
    php7-curl \
    php7-zlib \
    php7-xml \
    php7-phar \
    php7-intl \
    php7-dom \
    php7-xmlreader \
    php7-ctype \
    php7-session \
    php7-mbstring \
    wget \
    unzip

# # Ensure www-data user exists
# RUN if ! id -u www-data > /dev/null 2>&1; then \
#         adduser -D -H -u 82 -s /sbin/nologin www-data; \
#     fi

# Create the www-data user and group
#RUN addgroup -S www-data && adduser -S www-data -G www-data
RUN adduser -S www-data -G www-data

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

# Start PHP-FPM and run the WordPress setup script
CMD ["/bin/sh", "-c", "/usr/local/bin/wp-config-create.sh && php-fpm7 -F"]






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