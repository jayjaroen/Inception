FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/* 
#delete all download file

RUN mkdir -p /var/run/mysqld /var/lib/mysql /var/log/mysql \
    && chown -R mysql:mysql /var/run/mysqld /var/lib/mysql /var/log/mysql \
    && chmod 755 /var/run/mysqld /var/lib/mysql /var/log/mysql

#create folder give permission / 777 full access

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/99-custom.conf
COPY tools/run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 3306

USER mysql:mysql

ENTRYPOINT ["/usr/local/bin/run.sh"]

