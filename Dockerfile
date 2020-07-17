FROM ubuntu:16.04
MAINTAINER Jack

# Install Networktools
RUN apt-get update \
    && apt-get -y install net-tools \
    && apt-get -y install iputils-ping

# Install APACHE2
RUN apt-get update \
    && apt-get install -y apache2

# Install Cron
RUN DEBIAN_FRONTEND=noninteractive apt-get install cron


# Install PHP7
RUN apt-get install -y language-pack-en-base \
    && export LC_ALL=en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
&& apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 \    
&& apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php7.4 \
    && apt-get install -y php7.4-xml php7.4-mysql php7.4-json php7.4-mbstring php7.4-ldap php7.4-soap php7.4-zip php7.4-gd php-apcu graphviz curl unzip git \
&& apt-get install -y  php-pear php-net-socket php-imap \
&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --set php /usr/bin/php7.4 \
    && rm -rf /var/www/html/*

# Get iTOP
ARG ITOP_VERSION=2.7.1
ARG ITOP_FILENAME=iTop-2.7.1-5896.zip

RUN rm -rf /var/www/html/* \
    && mkdir -p /tmp/itop \
    && curl -SL -o /tmp/itop/itop.zip https://sourceforge.net/projects/itop/files/itop/$ITOP_VERSION/$ITOP_FILENAME/download \
    && unzip /tmp/itop/itop.zip -d /tmp/itop/ \
    && mv /tmp/itop/web/* /var/www/html \
    && rm -rf /tmp/itop

# COPY services, configs and scripts
COPY scripts /
COPY options/webtz.php /var/www/html
COPY options/itop-cron.logrotate /etc/logrotate.d/itop-cron
COPY options/apache2.fqdn.conf /etc/apache2/conf-available/fqdn.conf
RUN chmod +x /*.sh \
   && a2enconf fqdn \
   && chmod -R 755 /var/www/html \
   && chown -R www-data:www-data /var/www/html

RUN ln -s /make-itop-config-writable.sh /usr/local/bin/conf-w \
    && ln -s /make-itop-config-read-only.sh /usr/local/bin/conf-ro
    

EXPOSE 80

HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/services.sh"]
