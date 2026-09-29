FROM php:8.4-apache

RUN rm -f /etc/apache2/mods-enabled/mpm_*.load /etc/apache2/mods-enabled/mpm_*.conf \
    && a2enmod mpm_prefork rewrite \
    && docker-php-ext-install pdo_mysql \
    && apache2ctl -M 2>/dev/null | awk '/mpm_(event|worker|prefork)_module/ { count++ } END { if (count != 1) exit 1 }'

COPY . /var/www/html/

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
