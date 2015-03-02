from ubuntu:14.04

run apt-get -y update

run apt-get -y install \
  wget \
  git \
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

run apt-get install -y dh-make cmake pkg-config
run apt-get install -y socat
run apt-get install -y bzr mercurial
run apt-get install -y zip

run locale-gen en_US en_US.UTF-8

run curl https://s3.amazonaws.com/pkgr-buildpack-ruby/current/ubuntu-14.04/ruby-2.1.5.tgz -o - | tar xzf - -C /usr/local

run apt-get clean
run rm -rf /usr/local/src/*

run mkdir -p /opt

run adduser pkgr --shell /bin/bash --disabled-password --gecos "" --home /home/pkgr --uid 1234 --group --system

run cd /usr/local/src && git clone https://github.com/crohr/pkgr

run echo "pkgr ALL= NOPASSWD: /usr/bin/apt-get" >> /etc/sudoers

# required for apps that write to /opt/appname
run chown -R pkgr.pkgr /opt
run chmod 4111 /usr/bin/sudo
