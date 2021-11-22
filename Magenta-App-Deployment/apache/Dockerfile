FROM amazonlinux:latest
RUN amazon-linux-extras install php7.4 \
    && yum -y install php-pdo php-mysqlnd php-pdo-mysql php-opcache php-fpm php-xml php-gd php-devel php-intl php-bcmath php-json php-iconv php-soap php-mbstring php-sodium \
    && sed -i 's/memory_limit\s*=.*/memory_limit=4096M/g' /etc/php.ini
RUN yum -y install httpd
RUN yum -y install unzip 
RUN adduser magento && usermod -g apache magento
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
RUN composer global require "squizlabs/php_codesniffer=*"
COPY ./auth.json /root/.config/composer/auth.json
RUN composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition /var/www/html
RUN cd /var/www/html && find var generated vendor pub/static pub/media app/etc -type f -exec chmod 664 {} + && find var generated vendor pub/static pub/media app/etc -type d -exec chmod 775 {} + && chmod u+x bin/magento
RUN chown -R magento:apache /var/www/html
COPY ./magento.conf /etc/httpd/conf.d/
WORKDIR /var/www/html
COPY ./start_services.sh / 
RUN chmod +x /start_services.sh
ENTRYPOINT ["/start_services.sh"]
EXPOSE 80

