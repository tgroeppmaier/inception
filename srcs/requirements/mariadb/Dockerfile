FROM alpine:3.14

RUN apk update && apk add --no-cache mariadb mariadb-client

# Create necessary directories
RUN mkdir -p /run/mysqld /var/lib/mysql

# Set proper permissions
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Copy initialization script
COPY tools/init_db.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# Ensure MariaDB listens on all interfaces
RUN sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

# Initialize the database if it's not already initialized
CMD ["/bin/sh", "-c", "[ ! -d /var/lib/mysql/mysql ] && mysql_install_db --user=mysql --datadir=/var/lib/mysql; /docker-entrypoint-initdb.d/init_db.sh"]


# FROM alpine:3.14

# RUN apk update && apk add --no-cache mariadb mariadb-client bash

# RUN mkdir -p /var/run/mysqld \
#     && chown -R mysql:mysql /var/run/mysqld \
#     && chown -R mysql:mysql /var/lib/mysql

# COPY ./conf/my.cnf /etc/mysql/my.cnf
# COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/

# RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# EXPOSE 3306

# CMD ["/docker-entrypoint-initdb.d/init_db.sh"]