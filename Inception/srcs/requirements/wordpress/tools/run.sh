#!bin/bash

set -e

echo "Configuring WordPress..., connecting to Maria DB"

# NOTE: No space between -p and the password string!
while ! mariadb-admin ping -h"${DB_HOST}" -u"{DB_USER}" -p"${DB_PASSWORD}" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

echo "WordPress: MariaDB is up and running"

mkdir -p /var/www/html
cd /var/www/html

# if [ ! -f wp-config.php ]; then
#     # Download WP if index.php doesn't exist
#     if [ ! -f index.php ]; then
#         wp core download --allow-root \
#             --version=6.4.1 \
#             --locale=en_US
#     fi

#     # Create wp-config.php
#     wp config create --allow-root \
#         --dbname="wordpress_db" \
#         --dbuser="wp_user" \
#         --dbpass="wp_password1234" \
#         --dbhost="test_mariadb"

#     # Install WordPress site & admin
#     wp core install --allow-root \
#         --url="test.42.fr" \
#         --title="My WordPress Site" \
#         --admin_user="admin" \
#         --admin_password="adminpass123" \
#         --admin_email="admin@test.com"

#     # Create additional user
#     wp user create author author@test.com \
#         --allow-root \
#         --user_pass="authorpass123" \
#         --role=author
# fi

if [ ! -f wp-config.php ]; then
    wp core download --allow-root --version=6.4.1 --locale=en_US --force

    wp config create --allow-root \
        --dbname="${DB_NAME}" \
        --dbuser="${DB_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost="${DB_HOST}"
fi

# Only run core install if WP is NOT already installed in the database
if ! wp core is-installed --allow-root; then
    wp core install --allow-root \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_EMAIL}"
fi

# Only create the author user if they don't already exist
if ! wp user get author --allow-root > /dev/null 2>&1; then
    wp user create author author@test.com \
        --allow-root \
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


# set -e

# echo "Configuring WordPress..., connecting to Maria DB"

# # NOTE: No space between -p and the password string!
# while ! mariadb-admin ping -h "test_mariadb" -u "wp_user" -pwp_password1234 --silent; do
#     echo "Waiting for MariaDB..."
#     sleep 2
# done

# echo "WordPress: MariaDB is up and running"

# mkdir -p /var/www/html
# cd /var/www/html

# if [ ! -f wp-config.php ]; then
#     # Use --force so it doesn't fail if index.php already exists from a partial run
#     wp core download --allow-root \
#         --version=6.4.1 \
#         --locale=en_US \
#         --force

#     # Create wp-config.php
#     wp config create --allow-root \
#         --dbname="wordpress_db" \
#         --dbuser="wp_user" \
#         --dbpass="wp_password1234" \
#         --dbhost="test_mariadb"

#     # Install WordPress site & admin
#     wp core install --allow-root \
#         --url="test.42.fr" \
#         --title="My WordPress Site" \
#         --admin_user="admin" \
#         --admin_password="adminpass123" \
#         --admin_email="admin@test.com"

#     # Create additional user
#     wp user create author author@test.com \
#         --allow-root \
#         --user_pass="authorpass123" \
#         --role=author
# fi

# # Secure permissions
# chown -R www-data:www-data /var/www/html
# find /var/www/html -type d -exec chmod 755 {} +
# find /var/www/html -type f -exec chmod 644 {} +

# rm -f /run/php/php8.2-fpm.pid

# echo "WordPress is starting..."
# exec /usr/sbin/php-fpm8.2 -F -R
