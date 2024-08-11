# Use the official Alpine Linux base image
FROM alpine:3.14

# Install MariaDB
RUN apk --no-cache add mariadb mariadb-client

# Create necessary directories
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Copy custom configuration file
COPY conf/my.cnf /etc/my.cnf

# Expose the default MySQL port
EXPOSE 3306

# Set environment variables for MariaDB
ENV MYSQL_ROOT_PASSWORD=$DB_ROOT_PASSWORD
ENV MYSQL_DATABASE=$DB_NAME
ENV MYSQL_USER=$DB_USER
ENV MYSQL_PASSWORD=$DB_PASSWORD

# Initialize MariaDB
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start MariaDB server
CMD ["mysqld", "--user=mysql", "--datadir=/var/lib/mysql"]



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