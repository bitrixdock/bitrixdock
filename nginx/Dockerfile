FROM nginx:1.26.2

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

COPY conf/nginx.conf /etc/nginx/
COPY conf/default.conf /etc/nginx/conf.d/
COPY conf/upstream.conf /etc/nginx/conf.d/

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80 443
