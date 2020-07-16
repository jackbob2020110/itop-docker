# Configure PHP
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 30M/' /etc/php/7.4/apache2/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/' /etc/php/7.4/apache2/php.ini
sed -i 's/memory_limit = 128M/memory_limit = 256M/' /etc/php/7.4/apache2/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 32M/' /etc/php/7.4/apache2/php.ini
sed -i 's/; max_input_time/max_input_time = 90/' /etc/php/7.4/apache2/php.ini
sed -i 's/;max_input_vars = 1000/max_input_vars = 5000/' /etc/php/7.4/apache2/php.ini
sed -ie 's/;date.timezone =/date.timezone = Asia\/Harbin/g' /etc/php/7.4/apache2/php.ini
