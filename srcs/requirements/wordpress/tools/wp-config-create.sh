#!/bin/sh
set -e

if [ ! -f /usr/local/bin/wp ]; then
  echo "Installing WP"
  
# Download WP-CLI
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

echo "WP-CLI installed successfully"

# Download WordPress
wp core download --allow-root

# Create wp-config.php
wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST

# Install WordPress
wp core install --allow-root --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

echo "WP installed successfully"

else
  echo "WP already installed."
fi

php-fpm82 -F -R
# su -s /bin/sh www-data -c "php-fpm82 -F"
