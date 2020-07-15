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
    && update-alternatives --set php /usr/bin/php7.4

# Get iTOP

RUN rm -rf /var/www/html/* \
    && mkdir -p /tmp/itop \
    && git clone https://github.com/jackbob2020110/iTop.git  /tmp/itop/ \
    && mv /tmp/itop/* /var/www/html \
    && rm -rf /tmp/itop

ADD tz.php /var/www/html
RUN echo "ServerName localhost" > /etc/apache2/conf-available/fqdn.conf \
&& a2enconf fqdn

ADD services.sh /
RUN chmod +x /*.sh \
&& chmod -R 755 /var/www/html \
&& chown -R www-data:www-data /var/www/html

EXPOSE 80 443

HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/services.sh"]
