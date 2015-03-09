from ubuntu:14.04

run locale-gen en_US en_US.UTF-8

run apt-get -y update

run apt-get -y install wget
run apt-get -y install git
run apt-get -y install sudo
run apt-get -y install lsb-release
run apt-get -y install curl
run apt-get -y install libssl0.9.8
run apt-get -y install libmysqlclient-dev
run apt-get -y install libpq-dev
run apt-get -y install libsqlite3-0
run apt-get -y install libevent-dev
run apt-get -y install libssl-dev
run apt-get -y install libxml2-dev
run apt-get -y install libxslt1-dev
run apt-get -y install libreadline-dev
run apt-get -y install build-essential
run apt-get -y install libmagickcore-dev
run apt-get -y install dh-make
run apt-get -y install cmake
run apt-get -y install pkg-config
run apt-get -y install socat
run apt-get -y install bzr
run apt-get -y install mercurial
run apt-get -y install zip

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
