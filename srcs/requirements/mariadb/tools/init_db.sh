#!/bin/bash
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
    mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -e "CREATE USER 'wpuser42'@'wordpress' IDENTIFIED BY 'password';"
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser42'@'wordpress';"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

    echo "Database initialized successfully"

    # Stop MySQL server
    mysqladmin -u root shutdown
    wait $mysql_pid
else
    echo "Database already initialized"
fi

# Start MySQL in the foreground
exec mysqld --user=mysql --console


# #!/bin/sh

# echo "[DB config] Configuring MariaDB..."

# if [ ! -d "/run/mysqld" ]; then
#     echo "[DB config] Granting MariaDB daemon run permissions..."
#     mkdir -p /run/mysqld
#     chown -R mysql:mysql /run/mysqld
# fi

# if [ -d "/var/lib/mysql/mysql" ]
# then
#     echo "[DB config] MariaDB already configured."
# else
#     echo "[DB config] Installing MySQL Data Directory..."
#     chown -R mysql:mysql /var/lib/mysql
#     mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
#     echo "[DB config] MySQL Data Directory done."

#     echo "[DB config] Configuring MySQL..."
#     TMP=/tmp/.tmpfile

#     echo "USE mysql;" > ${TMP}
#     echo "FLUSH PRIVILEGES;" >> ${TMP}
#     echo "DELETE FROM mysql.user WHERE User='';" >> ${TMP}
#     echo "DROP DATABASE IF EXISTS test;" >> ${TMP}
#     echo "DELETE FROM mysql.db WHERE Db='test';" >> ${TMP}
#     echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" >> ${TMP}
#     echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> ${TMP}
#     echo "CREATE DATABASE ${MYSQL_DATABASE};" >> ${TMP}
#     echo "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> ${TMP}
#     echo "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" >> ${TMP}
#     echo "FLUSH PRIVILEGES;" >> ${TMP}

#     /usr/bin/mysqld --user=mysql --bootstrap < ${TMP}
#     rm -f ${TMP}
#     echo "[DB config] MySQL configuration done."
# fi

# echo "[DB config] Allowing remote connections to MariaDB"
# sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
# sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

# echo "[DB config] Starting MariaDB daemon on port 3306."
# exec /usr/bin/mysqld --user=mysql --console



