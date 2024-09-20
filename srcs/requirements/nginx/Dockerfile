FROM alpine:3.19

# Install NGINX and necessary packages
RUN apk -U upgrade && apk add --no-cache nginx openssl openrc

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=XX/ST=STATE/L=CITY/O=ORGANIZATION/OU=UNIT/CN=tgroeppm.42.fr"

RUN addgroup -g 1001 -S website1

RUN adduser -u 1001 -G website1 -S -H website1

RUN adduser nginx website1

# Copy custom nginx configuration
COPY /conf/nginx.conf /etc/nginx/nginx.conf

# Start NGINX
ENTRYPOINT ["nginx"]

# Set the default command to run NGINX
CMD ["-g", "daemon off;"]

