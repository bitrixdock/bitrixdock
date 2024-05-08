FROM httpd:alpine

LABEL org.opencontainers.image.source="https://github.com/bitrixdock/bitrixdock"

RUN apk add --no-cache apache2-proxy; \
    addgroup -g 1000 -S www; \
    adduser -G www -u 1000 -s /bin/sh -D www;

COPY conf /etc/apache2

EXPOSE 80 443

CMD /usr/sbin/httpd -DFOREGROUND
