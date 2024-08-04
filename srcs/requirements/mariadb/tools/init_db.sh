# #!/bin/bash

# # Wait for MySQL to be ready
# while ! mysqladmin ping -h"localhost" --silent; do
#     sleep 1
# done

# # Create database and user
# mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
# mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
# mysql -e "FLUSH PRIVILEGES;"

# # Secure the MySQL installation
# mysql -e "DELETE FROM mysql.user WHERE User='';"
# mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
# mysql -e "DROP DATABASE IF EXISTS test;"
# mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
# mysql -e "FLUSH PRIVILEGES;"

# # Set root password
# mysqladmin -u root password "${MYSQL_ROOT_PASSWORD}"

# echo "MariaDB setup completed successfully!"

#!/bin/bash
set -e

mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"