# FROM debian:buster-slim

# RUN apt-get update && apt-get install -y mariadb-server

# COPY my.cnf /etc/mysql/my.cnf
# COPY init_db.sh /docker-entrypoint-initdb.d/init_db.sh

# RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# EXPOSE 3306

# CMD ["/docker-entrypoint-initdb.d/init_db.sh"]

FROM alpine:3.14

RUN apk update && apk add --no-cache mariadb mariadb-client bash

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

EXPOSE 3306

CMD ["/docker-entrypoint-initdb.d/init_db.sh"]