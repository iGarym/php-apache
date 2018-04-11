FROM ubuntu:16.04

RUN apt-get update \
    && apt-get -y install \
    --assume-yes apt-utils \
    apache2 \
    curl \
    php7.0 \
    libapache2-mod-php7.0 \
    php7.0-cli \
    php7.0-common \
    php7.0-mbstring \
    php7.0-gd \
    php7.0-mysql \
    php7.0-zip \
    php7.0-curl \
    wget \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && sed -i 's/variables_order.*/variables_order = "EGPCS"/g' /etc/php/7.0/apache2/php.ini

RUN mkdir -p /app && rm -rf /var/www/html && ln -s /app /var/www/html

COPY . /app

WORKDIR /app

RUN chmod 755 ./start.sh

EXPOSE 80

CMD ["./start.sh"]
