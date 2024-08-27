FROM alpine:3.19

RUN apk -U upgrade && apk add --no-cache mariadb mariadb-client openrc

RUN mkdir -p /var/run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql

COPY ./conf/my.cnf /etc/my.cnf
COPY ./tools/init_db.sh /

RUN chmod +x /init_db.sh

ENTRYPOINT ["/init_db.sh"]