FROM debian:bookworm

# Install required packages (Added ca-certificates)
RUN apt-get update && apt-get install -y --no-install-recommends \
    php8.2-xml \
    php8.2-mysql \
    php8.2-fpm \
    mariadb-client \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download WP-CLI
RUN curl -LO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy FPM config & startup script
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Prepare directory permissions
RUN mkdir -p /run/php /var/www/html \
    && chown -R www-data:www-data /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/run.sh"]
