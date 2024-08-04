FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y mariadb-server

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

RUN chown -R mysql:mysql /var/lib/mysql

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

EXPOSE 3306

USER mysql

CMD ["mysqld"]