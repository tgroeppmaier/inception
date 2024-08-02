FROM alpine:3.14

# Install MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

# Copy custom configuration
COPY conf/my.cnf /etc/my.cnf

# Copy initialization script
COPY tools/init_db.sh /docker-entrypoint-initdb.d/

# Set permissions for the initialization script
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# Expose MariaDB port
EXPOSE 3306

# Start MariaDB
CMD ["mysqld"]