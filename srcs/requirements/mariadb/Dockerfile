# FROM alpine:3.14

# # Install MariaDB
# RUN apk update && apk add --no-cache mariadb mariadb-client

# # Create the /etc/mysql/conf.d directory
# RUN mkdir -p /etc/mysql/conf.d

# # Copy custom configuration
# COPY conf/my.cnf /etc/my.cnf

# # Copy initialization script
# COPY tools/init_db.sh /docker-entrypoint-initdb.d/

# # Set permissions for the initialization script
# RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# # Expose MariaDB port
# EXPOSE 3306

# Start MariaDB
# CMD ["mysqld"]

FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y mariadb-server

RUN mkdir -p /etc/mysql/conf.d

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

EXPOSE 3306

CMD ["mysqld"]