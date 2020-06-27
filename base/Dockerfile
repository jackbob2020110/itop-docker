FROM ubuntu:xenial
MAINTAINER Jack

ARG DEBIAN_FRONTEND=noninteractive

# Install Networktools
RUN apt-get update \
    && apt-get -y install net-tools \
    && apt-get -y install iputils-ping

# Install APACHE2
RUN apt-get update \
    && apt-get install -y apache2

# Install PHP7
RUN apt-get install -y language-pack-en-base \
    && export LC_ALL=en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
#    && apt-key adv --recv-keys 94558F59 --keyserver hkp://keyserver.ubuntu.com:80  \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php7.4 \
    && apt-get install -y php7.4-xml php7.4-mysql php7.4-json php7.4-mbstring php7.4-ldap php7.4-soap php7.4-zip php7.4-gd php-apcu graphviz curl unzip git \
&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --set php /usr/bin/php7.4


ADD tz.php /var/www/html
ADD itop-cron.logrotate /etc/logrotate.d/itop-cron
ADD apache2.fqdn.conf /etc/apache2/conf-available/fqdn.conf

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 777 /var/www/html

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR



EXPOSE 80
CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]