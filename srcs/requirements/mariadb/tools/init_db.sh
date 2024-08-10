#!/bin/bash
set -e

# Debug: Print environment variables
echo "MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}"
echo "MYSQL_USER: ${MYSQL_USER}"
echo "MYSQL_PASSWORD: ${MYSQL_PASSWORD}"
echo "MYSQL_DATABASE: ${MYSQL_DATABASE}"

# Check if the database is already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Database not initialized. Initializing now..."

    # Initialize the MySQL data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "MySQL data directory initialized."

    # Start MySQL server
    echo "Starting MySQL server..."
    mysqld --user=mysql &

    # Wait for MySQL to be ready
    echo "Waiting for MySQL to be ready..."
    until mysqladmin ping -h"localhost" --silent; do
        sleep 1
    done
    echo "MySQL is ready."

    # Run the initialization commands
    echo "Running initialization commands..."
    mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"
    echo "Initialization commands executed."

    # Stop MySQL
    echo "Stopping MySQL server..."
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
    echo "MySQL server stopped."
else
    echo "Database already initialized. Starting MySQL server..."
    # If the database is already initialized, just start MySQL
    exec mysqld --user=mysql
fi

# Start MySQL in the foreground
echo "Starting MySQL in the foreground..."
exec mysqld --user=mysql

# #!/bin/bash
# set -e

# # Check if the database is already initialized
# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     # Initialize the MySQL data directory
#     mysql_install_db --user=mysql --datadir=/var/lib/mysql

#     # Start MySQL server
#     mysqld --user=mysql &

#     # Wait for MySQL to be ready
#     until mysqladmin ping -h"localhost" --silent; do
#         sleep 1
#     done

#     # Run the initialization commands
#     mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
#     mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
#     mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
#     mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
#     mysql -e "FLUSH PRIVILEGES;"

#     # Stop MySQL
#     mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
# else
#     # If the database is already initialized, just start MySQL
#     exec mysqld --user=mysql
# fi

# # Start MySQL in the foreground
# exec mysqld --user=mysql