#!/bin/sh
set -e

if [ ! -f /usr/local/bin/wp ]; then
  echo "Installing WP"
  


# Download WP-CLI
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

echo "WP-CLI installed successfully"

# go to wordpress directory
# cd /var/www/wordpress
# give permission to wordpress directory
# chmod -R 755 /var/www/wordpress/
# change owner of wordpress directory to www-data
# chown -R www-data:www-data /var/www/wordpress

# Navigate to the web root
# cd /var/www/html

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


# #!/bin/sh
# set -e

# WP_CONFIG_PATH="/var/www/html/wp-config.php"

# # Remove existing wp-config.php if it exists
# if [ -f "$WP_CONFIG_PATH" ]; then
#     rm "$WP_CONFIG_PATH"
#     echo "Existing wp-config.php removed."
# fi


# # Create wp-config.php
# cat << EOF > "$WP_CONFIG_PATH"
# <?php
# define( 'DB_NAME', '${MYSQL_DATABASE}' );
# define( 'DB_USER', '${MYSQL_USER}' );
# define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );
# define( 'DB_HOST', 'mariadb' );
# define( 'DB_CHARSET', 'utf8' );
# define( 'DB_COLLATE', '' );

# $(wget -q -O - https://api.wordpress.org/secret-key/1.1/salt/)

# \$table_prefix = 'wp_';

# define( 'WP_DEBUG', true );
# define( 'WP_DEBUG_LOG', true );
# define( 'WP_DEBUG_DISPLAY', true );
# define( 'SCRIPT_DEBUG', true );

# // Add these lines for more detailed error reporting
# define( 'WP_DEBUG_LOG', '/var/www/html/wp-content/debug.log' );
# error_reporting(E_ALL);
# ini_set('display_errors', 1);

# // Add this block to test the database connection
# if (!function_exists('mysqli_connect')) {
#     die("MySQL support is not installed or enabled.");
# }

# \$link = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD);
# if (!\$link) {
#     die("MySQL connection failed: " . mysqli_connect_error());
# }

# if (!mysqli_select_db(\$link, DB_NAME)) {
#     die("MySQL database selection failed: " . mysqli_error(\$link));
# }

# mysqli_close(\$link);

# if ( ! defined( 'ABSPATH' ) ) {
#     define( 'ABSPATH', __DIR__ . '/' );
# }

# require_once ABSPATH . 'wp-settings.php';
# EOF

# echo "WordPress config file created successfully!"

# # Ensure correct permissions
# chown -R www-data:www-data /var/www/html

# # Create wp-content/debug.log if it doesn't exist
# mkdir -p /var/www/html/wp-content
# touch /var/www/html/wp-content/debug.log
# chown www-data:www-data /var/www/html/wp-content/debug.log
# chmod 644 /var/www/html/wp-content/debug.log

