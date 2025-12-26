FROM alpine:3.20

RUN apk update && apk add --no-cache \
    nginx \
    curl \
    bash \
    git \
    unzip \
    supervisor \
    nodejs \
    npm \
    php83 \
    php83-fpm \
    php83-cli \
    php83-common \
    php83-curl \
    php83-mbstring \
    php83-xml \
    php83-zip \
    php83-pdo \
    php83-pdo_mysql \
    php83-pdo_sqlite \
    php83-opcache \
    php83-redis \
    php83-phar \
    php83-tokenizer \
    php83-session \
    php83-ctype \
    php83-fileinfo

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin \
    --filename=composer

RUN mkdir -p /run/nginx /var/www/html

WORKDIR /var/www/html

RUN sed -i 's|listen = 127.0.0.1:9000|listen = 127.0.0.1:9000|' /etc/php83/php-fpm.d/www.conf

COPY default.conf /etc/nginx/http.d/default.conf

EXPOSE 80

CMD ["sh", "-c", "php-fpm83 && nginx -g 'daemon off;'"]
