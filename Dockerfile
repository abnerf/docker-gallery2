FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
ENV GALLERY2_URL="http://downloads.sourceforge.net/gallery/gallery-2.3.2-typical.tar.gz"

RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
      apache2 \
      libapache2-mod-php5 \
      php5-mysql \
      imagemagick \
      graphicsmagick \
      dcraw \
      curl && \
   apt-get clean autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/www/*

RUN \
  curl -fsSL ${GALLERY2_URL} | \
    tar xzf - -C /var/www --strip-components=1 && \
  chown -R www-data:www-data /var/www/ && \
  chmod -R g=u /var/www/

RUN a2enmod rewrite
RUN a2enmod expires

ADD apache-default /etc/apache2/sites-available/000-default.conf
ADD entrypoint.sh /entrypoint.sh

VOLUME ["/var/www/"]
EXPOSE 80
ENTRYPOINT /entrypoint.sh
