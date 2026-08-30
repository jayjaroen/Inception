#!/bin/bash

set -e

DB_PASSWORD=$(cat /run/secrets/mariadb_user_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wordpress_root_password)
WP_PASSWORD=$(cat /run/secrets/wordpress_user_password)

echo "Configuring WordPress..., connecting to Maria DB"

# NOTE: No space between -p and the password string!

while ! mariadb-admin ping -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

echo "WordPress: MariaDB is up and running"

mkdir -p /var/www/html
cd /var/www/html

if [ ! -f wp-config.php ]; then
    if [ ! -f index.php ]; then
        wp core download --allow-root \
                        --version=6.4.1 \
                        --locale=en_US
    fi

    wp config create --allow-root \
                    --dbname="${DB_NAME}" \
                    --dbuser="${DB_USER}" \
                    --dbpass="${DB_PASSWORD}" \
                    --dbhost="${DB_HOST}"

    wp core install --allow-root \
                    --url="${WP_URL}" \
                    --title="${WP_TITLE}" \
                    --admin_user="${WP_ADMIN}" \
                    --admin_password="${WP_ADMIN_PASSWORD}" \
                    --admin_email="${WP_ADMIN_EMAIL}"

    wp user create --allow-root \
                    "${WP_USER}" \
                    "${WP_EMAIL}" \
                    --user_pass="${WP_PASSWORD}" \
                    --role=author
fi

# Secure permissions / check later
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} +
find /var/www/html -type f -exec chmod 644 {} +

rm -f /run/php/php8.2-fpm.pid

echo "WordPress is starting..."
exec /usr/sbin/php-fpm8.2 -F -R