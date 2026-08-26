#!/bin/bash

set -e

# Initialize data directory if not already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

SQL_FILE="/var/lib/mysql/run_sql.sql"

# Generate setup SQL script with FIXED syntax (backticks instead of single quotes)
cat << EOF > "$SQL_FILE"
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Ensure correct file permissions for mysql user
chown -R mysql:mysql /var/lib/mysql

echo "Starting MariaDB..."

# Execute mysqld as main process
exec mysqld --datadir=/var/lib/mysql --bind-address=0.0.0.0 --init-file="$SQL_FILE"


# set -e

# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     echo "Maria Database is installed"
#     mysql_install_db --user=mysql --datadir=var/lib/mysql > /dev/null
# fi

# SQL_FILE="/var/lib/mysql/run_sql.sql"

# #to edit ENV

# cat << EOF > $SQL_FILE

# FLUSH PRIVILEGES;
# DELETE FROM mysql.user WHERE User='';
# CREATE DATABASE IF NOT EXISTS wordpress_db;
# CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_password1234';
# GRANT ALL PRIVILEGES ON \`wordpress_db\`.* TO 'wp_user'@'%';
# ALTER USER 'root'@'localhost' IDENTIFIED BY 'root_password123';
# FLUSH PRIVILEGES;

# EOF

# # GRANT ALL PRIVILEGES ON 'wordpress_db'.* TO 'wp_user'@'%';
# echo "Maria DB is running"

# sleep 3

# chmod -R 777 /var/lib/mysql

# wait

# exec mysqld --datadir=/var/lib/mysql --bind-address=0.0.0.0 --init-file=$SQL_FILE