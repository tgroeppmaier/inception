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

# FROM alpine:3.14

# RUN apk update && apk add --no-cache mariadb mariadb-client bash

# RUN mkdir -p /var/run/mysqld \
#     && chown -R mysql:mysql /var/run/mysqld

# # Ensure /var/lib/mysql has the correct permissions
# RUN chown -R mysql:mysql /var/lib/mysql

# COPY ./conf/my.cnf /etc/mysql/my.cnf
# COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/

# RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# EXPOSE 3306

# USER mysql

# CMD ["mysqld"]