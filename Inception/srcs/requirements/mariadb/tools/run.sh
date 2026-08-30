#!/bin/bash

set -e

DB_PASSWORD=$(cat /run/secrets/mariadb_user_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/mariadb_root_password)

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
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF


# Ensure correct file permissions for mysql user
chown -R mysql:mysql /var/lib/mysql

echo "Starting MariaDB..."

# Execute mysqld as main process
exec mysqld --datadir=/var/lib/mysql --bind-address=0.0.0.0 --init-file="$SQL_FILE"
