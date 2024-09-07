FROM alpine:3.19

# Install NGINX and necessary packages
RUN apk -U upgrade && apk add --no-cache nginx openssl openrc

# Create www-data user and adds it to www-data group
# RUN adduser -D -S -H -u 82 -G www-data www-data

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=XX/ST=STATE/L=CITY/O=ORGANIZATION/OU=UNIT/CN=tgroeppm.42.fr"

# Remove default nginx configuration
# RUN rm -f /etc/nginx/conf.d/default.conf

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Start NGINX
ENTRYPOINT ["nginx"]

# Set the default command to run NGINX
CMD ["-g", "daemon off;"]

