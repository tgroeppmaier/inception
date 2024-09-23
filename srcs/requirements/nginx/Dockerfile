FROM alpine:3.19

RUN apk -U upgrade && apk add --no-cache \
    nginx \
    openssl \
    openrc

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=XX/ST=STATE/L=CITY/O=ORGANIZATION/OU=UNIT/CN=tgroeppm.42.fr"

RUN addgroup -g 1001 -S website1

RUN adduser -u 1001 -G website1 -S -H website1

RUN adduser nginx website1

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT ["nginx"]

CMD ["-g", "daemon off;"]

