# FROM debian:bullseye-slim

# RUN apt-get update && apt-get install -y mariadb-server

# RUN mkdir -p /etc/mysql/conf.d

# COPY ./conf/my.cnf /etc/mysql/my.cnf
# COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/

# RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# EXPOSE 3306

# CMD ["mysqld"]

FROM debian:bullseye-slim

# Install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server

# Create the /etc/mysql/conf.d directory
RUN mkdir -p /etc/mysql/conf.d

# Copy custom configuration
COPY ./conf/my.cnf /etc/mysql/my.cnf

# Copy initialization script
COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/

# Set permissions for the initialization script
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# Create mysql user and group
# RUN groupadd -r mysql && useradd -r -g mysql mysql

# Change ownership of necessary directories
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld /etc/mysql

# Expose MariaDB port
EXPOSE 3306

# Run mysqld as mysql user
USER mysql
CMD ["mysqld"]