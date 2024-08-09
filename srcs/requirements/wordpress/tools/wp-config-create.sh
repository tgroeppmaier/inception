#!/bin/sh
set -e

WP_CONFIG_PATH="/var/www/html/wp-config.php"

# Remove existing wp-config.php if it exists
if [ -f "$WP_CONFIG_PATH" ]; then
    rm "$WP_CONFIG_PATH"
    echo "Existing wp-config.php removed."
fi

# Create wp-config.php
cat << EOF > "$WP_CONFIG_PATH"
<?php
define( 'DB_NAME', '${MYSQL_DATABASE}' );
define( 'DB_USER', '${MYSQL_USER}' );
define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

$(wget -q -O - https://api.wordpress.org/secret-key/1.1/salt/)

\$table_prefix = 'wp_';

define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'WP_DEBUG_DISPLAY', false );
define( 'SCRIPT_DEBUG', true );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF

echo "WordPress config file created successfully!"

# Ensure correct permissions
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

# Don't exit, let the CMD continue to PHP-FPM




# #!/bin/bash

# # Check if wp-config.php exists
# if [ ! -f /var/www/html/wp-config.php ]; then
#     # Create wp-config.php
#     cat << EOF > /var/www/html/wp-config.php
# <?php
# define( 'DB_NAME', '${MYSQL_DATABASE}' );
# define( 'DB_USER', '${MYSQL_USER}' );
# define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );
# define( 'DB_HOST', 'mariadb' );
# define( 'DB_CHARSET', 'utf8' );
# define( 'DB_COLLATE', '' );

# $(wget -q -O - https://api.wordpress.org/secret-key/1.1/salt/)

# \$table_prefix = 'wp_';

# define( 'WP_DEBUG', false );

# if ( ! defined( 'ABSPATH' ) ) {
#     define( 'ABSPATH', __DIR__ . '/' );
# }

# require_once ABSPATH . 'wp-settings.php';
# EOF
    
#     echo "WordPress config file created successfully!"
# else
#     echo "WordPress config file already exists."
# fi

# # Ensure correct permissions
# chown -R www-data:www-data /var/www/html
# chmod -R 755 /var/www/html

# # Start PHP-FPM
# exec "$@"