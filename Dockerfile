FROM php:7.1.33-apache
COPY symcom-synonym-tool/ /var/www/html/symcom-synonym-tool
WORKDIR /var/www/html/symcom-synonym-tool

RUN apt-get update && apt-get install -y \
    curl git vim

RUN apt install -y libpng-dev libjpeg-dev libfreetype6-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV PATH="$PATH:/usr/local/bin"

RUN ls /usr/local/bin
RUN php composer.phar show && php composer.phar install
RUN cd symcom/api/ && php composer.phar show && php composer.phar install


EXPOSE 80

CMD [ "apache2-foreground" ] 
