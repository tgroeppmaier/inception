#!/bin/sh
set -e

# Check if the database is already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialize the MySQL data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MySQL server in the background
    mysqld --user=mysql --skip-networking &
    mysql_pid=$!

    # Wait for MySQL to be ready
    until mysqladmin ping -h"localhost" --silent; do
        sleep 1
    done

# Run the initialization commands
    mysql <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'172.18.0.4' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'172.18.0.4';
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;
EOF

    echo "Database initialized successfully"

    # Stop MySQL server
    mysqladmin -u root shutdown
    wait $mysql_pid
else
    echo "Database already initialized"
fi

# Start MySQL in the foreground
mysqld_safe