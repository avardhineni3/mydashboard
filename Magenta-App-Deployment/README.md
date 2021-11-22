# Host Machine must be configured with below property
vm.max_map_count=262144

## Install Magento2 
docker exec -it <containerId> /bin/bash
su - magento
php /var/www/html/bin/magento setup:install --base-url=http://kotechnologies.co.uk --db-host=mysql --db-name=magentodb --db-user=magentoadmin --db-password=magentopassword --admin-firstname=magento --admin-lastname=magento --admin-email=paneendrakumar@kotechnologies.co.uk --admin-user=magento --admin-password=Hello$$Pass@2d --language=en_GB --currency=GBP --timezone=Europe/London --use-rewrites=1 --backend-frontname=admin --elasticsearch-host=elasticsearch --elasticsearch-port=9200

# Permissions 
chown -R magento:apache /var/www/html
