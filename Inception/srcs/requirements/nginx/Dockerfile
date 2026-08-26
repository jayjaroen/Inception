FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y nginx openssl \
    && rm -rf /var/lib/apt/lists

RUN mkdir -p /etc/nginx/ssl /run/nginx

# RUN rm -f /etc/nginx/sites-enabled/default

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/run.sh /usr/local/bin
#setup.sh certificate

RUN chmod +x /usr/local/bin/run.sh
#give access right to run file

RUN chown -R www-data:www-data /var/lib/nginx \
    && chmod -R 755 /var/lib/nginx

EXPOSE 443

ENTRYPOINT ["sh", "/usr/local/bin/run.sh"]
#run docker image to build docker container
