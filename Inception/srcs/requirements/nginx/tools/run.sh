#! /bin/bash

set -e

echo "Set up TLS configuration"

#generate certificate, to enter ENV
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=TH/ST=Bangkok/L=Bangkok/O=42Bangkok/OU=Student/CN=${DOMAIN_NAME}"


echo "Nginx is up and running"

exec nginx -g "daemon off;"
#run in foreground
# -g / -d

