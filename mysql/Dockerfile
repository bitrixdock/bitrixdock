FROM mysql:8.0-debian

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

MAINTAINER vitams

COPY my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306
