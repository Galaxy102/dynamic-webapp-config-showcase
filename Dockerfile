FROM httpd:2.4.62-alpine

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
# CMD must be repeated for some reason
CMD ["httpd-foreground"]

COPY --chmod=0755 docker/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apk add --no-cache gettext-envsubst

COPY public/ /usr/local/apache2/htdocs/
