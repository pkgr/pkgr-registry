from ubuntu:12.04

run echo "deb http://archive.ubuntu.com/ubuntu/ precise main restricted universe" > /etc/apt/sources.list
run echo "deb http://archive.ubuntu.com/ubuntu/ precise-updates main restricted universe" >> /etc/apt/sources.list
run echo "deb http://security.ubuntu.com/ubuntu/ precise-security main restricted universe" >> /etc/apt/sources.list

run apt-get -y update
run apt-get -y upgrade

run apt-get -y install \
  wget \
  git \
  ruby1.9.1-full \
  sudo \
  lsb-release \
  curl \
  libssl0.9.8 \
  libmysqlclient-dev \
  libpq-dev \
  libsqlite3-0 \
  libevent-dev \
  libssl-dev \
  libxml2-dev \
  libxslt1-dev \
  libreadline-dev \
  build-essential \
  libmagickcore-dev

run ( gem -v | grep 2.2.1 ) || ( REALLY_GEM_UPDATE_SYSTEM=1 gem update --system --no-ri --no-rdoc )

run apt-get -y install upstart postgresql-9.1 postgresql-contrib-9.1

run apt-get install python-software-properties -y
run add-apt-repository ppa:chris-lea/redis-server
run apt-get update

run apt-get install -y redis-server="2:2.8.9-1chl1~precise1"

run mkdir -p /opt

run apt-get install -y zip
run cd /opt && git clone https://github.com/kennethreitz/bpwatch.git && cd bpwatch && make && ln -sf /opt/bpwatch/bpwatch /usr/local/bin/

run apt-get clean
run rm -rf /usr/local/src/*

run service postgresql start && \
  echo "CREATE USER \"user\" SUPERUSER PASSWORD 'pass';" | su - postgres -c psql && \
  echo "CREATE DATABASE dbname;" | su - postgres -c psql && \
  echo "GRANT ALL PRIVILEGES ON DATABASE \"dbname\" TO \"user\";" | su - postgres -c psql

run adduser pkgr --shell /bin/bash --disabled-password --gecos "" --home /home/pkgr --uid 1234 --group --system

run cd /usr/local/src && git clone https://github.com/crohr/pkgr

run echo "pkgr ALL= NOPASSWD: /usr/bin/apt-get\npkgr ALL= NOPASSWD: /usr/sbin/service" >> /etc/sudoers

# required for apps that write to /opt/appname
run chown -R pkgr.pkgr /opt

run chmod 4111 /usr/bin/sudo
