FROM agideo/backup:4

ENV MYSQL_MAJOR 5.7
ENV MYSQL_VERSION 5.7.18-1debian8

RUN set -ex \
  && wget -O /tmp/mysql.gpg "http://ha.pool.sks-keyservers.net:11371/pks/lookup?op=get&options=mr&search=0xA4A9406876FCBD3C456770C88C718D3B5072E1F5" \
  && apt-key add /tmp/mysql.gpg \
  && echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-${MYSQL_MAJOR}" > /etc/apt/sources.list.d/mysql.list \
  && apt-get update \
  && apt-get install -y mysql-client="${MYSQL_VERSION}" \
  && rm /tmp/mysql.gpg

ENV REDIS_VERSION 2:3.2.8-1~dotdeb+8.1

RUN set -x \
  && wget -O /tmp/dotdeb.gpg "https://www.dotdeb.org/dotdeb.gpg" \
  && apt-key add /tmp/dotdeb.gpg \
  && echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list \
  && apt-get update \
  && apt-get install -y redis-tools="${REDIS_VERSION}" \
  && rm /tmp/dotdeb.gpg

RUN set -ex \
  && mkdir -p /root/Backup \
  && mkdir -p /srv/app_log

COPY etc/logrotate.d/* /etc/logrotate.d/
COPY etc/supervisor/conf.d/* /etc/supervisor/conf.d/
COPY Backup /root/Backup
