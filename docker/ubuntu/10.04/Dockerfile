from ubuntu:10.04
run apt-get -y install gpgv

run echo "deb http://archive.ubuntu.com/ubuntu lucid main universe" > /etc/apt/sources.list
run apt-get -y update

# need to install ruby and rubygems from scratch (at least rubygems)

run apt-get -y install wget git-core \
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

run cd /usr/local/src/ && wget http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz && tar xzf yaml-0.1.4.tar.gz
run cd /usr/local/src/yaml-0.1.4/ && ./configure --prefix=/usr/local && make && make install

run cd /usr/local/src/ && wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p429.tar.gz && tar xzf ruby-1.9.3-p429.tar.gz
run cd /usr/local/src/ruby-1.9.3-p429/ && ./configure --prefix=/usr/local --enable-shared --disable-install-doc --with-opt-dir=/usr/local/lib --with-openssl-dir=/usr/local && make && make install

run cd /usr/local/src/ && wget http://production.cf.rubygems.org/rubygems/rubygems-2.2.1.tgz && tar xzf rubygems-2.2.1.tgz
run cd /usr/local/src/rubygems-2.2.1/ && ruby setup.rb --prefix=/usr/local

run apt-get -y install vim upstart

run apt-get install python-software-properties -y
run add-apt-repository ppa:chris-lea/redis-server
run apt-get update

run apt-get install -y redis-server="2:2.8.7-1chl1~lucid1"

run apt-get -y install postgresql-8.4 postgresql-contrib-8.4

run service postgresql-8.4 start && \
  echo "CREATE USER \"user\" SUPERUSER PASSWORD 'pass';" | su - postgres -c psql && \
  echo "CREATE DATABASE dbname;" | su - postgres -c psql && \
  echo "GRANT ALL PRIVILEGES ON DATABASE \"dbname\" TO \"user\";" | su - postgres -c psql

run adduser pkgr --shell /bin/bash --disabled-password --gecos "" --home /home/pkgr --uid 1234 --group --system

run mkdir -p /opt

run apt-get install -y zip
run cd /opt && git clone https://github.com/kennethreitz/bpwatch.git && cd bpwatch && make && ln -sf /opt/bpwatch/bpwatch /usr/local/bin/

run apt-get clean
run rm -rf /usr/local/src/*

run cd /usr/local/src && git clone https://github.com/crohr/pkgr

workdir /usr/local/src/pkgr
run git fetch origin && git checkout -f e5e00f1dc356c12ea20f9a290bb8f6df22a1e932
run gem build pkgr.gemspec
run ls pkgr-*.gem | sort -r | head -1 | xargs gem install --no-ri --no-rdoc

run rm -f /var/run/postgresql/.s.PGSQL.5432.lock
run ln -s /etc/init.d/postgresql-8.4 /etc/init.d/postgresql

run echo "pkgr ALL= NOPASSWD: /usr/bin/apt-get\npkgr ALL= NOPASSWD: /usr/sbin/service" >> /etc/sudoers

run echo "deb http://ubuntu.bhs.mirrors.ovh.net/ubuntu precise main universe" > /etc/apt/sources.list

# required for apps that write to /opt/appname
run chown -R pkgr.pkgr /opt
