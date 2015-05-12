FROM debian:jessie
MAINTAINER Mizunashi Mana <mizunashi_mana@mma.club.uec.ac.jp>

# Installing packages
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install tar curl supervisor

# Installing nginx
RUN apt-get -y install nginx

# Installing HHVM
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update && apt-get -y install hhvm

# Package clean
RUN apt-get clean && apt-get -y autoremove

# Init
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "expose_php = Off" >> /etc/hhvm/php.ini
RUN /usr/share/hhvm/install_fastcgi.sh
RUN /etc/init.d/hhvm restart
ADD supervisor-config/ /etc/supervisor/conf.d

# Installing Dockuwiki
RUN mkdir -p /var/www/dokuwiki/
RUN cd /var/www/dokuwiki/ && curl http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz | tar xz --strip 1
RUN chown -R www-data:www-data /var/www
RUN rm /etc/nginx/sites-enabled/*
ADD nginx-config/dokuwiki-site /etc/nginx/sites-enabled/

# EXPOSE 80 443
# VOLUME ["/var/www/dokuwiki/data/", "/var/www/dokuwiki/lib/plugins","/var/www/dokuwiki/conf/","/var/www/dokuwiki/lib/tpl/","/var/log"]

CMD supervisord -n