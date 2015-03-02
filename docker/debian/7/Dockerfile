from debian:7

run apt-get update -y

run apt-get -y install wget curl
run apt-get -y install sudo
run apt-get -y install lsb-release
run apt-get -y install git
run apt-get -y install ruby1.9.1 ruby1.9.1-dev
run apt-get -y install libssl1.0.0
run apt-get -y install libmysqlclient-dev
run apt-get -y install libpq-dev
run apt-get -y install libsqlite3-0
run apt-get -y install libevent-dev
run apt-get -y install libssl-dev
run apt-get -y install libxml2-dev
run apt-get -y install libxslt1-dev
run apt-get -y install libreadline-dev
run apt-get -y install libmagickcore-dev
run apt-get -y install build-essential
run apt-get -y install dh-make cmake pkg-config
run apt-get -y install socat
run apt-get -y install bzr
run apt-get -y install mercurial
run apt-get -y install zip

run REALLY_GEM_UPDATE_SYSTEM=1 gem update --system --no-ri --no-rdoc

run mkdir -p /opt

run cd /opt && git clone https://github.com/kennethreitz/bpwatch.git && cd bpwatch && make && ln -sf /opt/bpwatch/bpwatch /usr/local/bin/

run apt-get clean
run rm -rf /usr/local/src/*

run adduser pkgr --shell /bin/bash --disabled-password --gecos "" --home /home/pkgr --uid 1234 --group --system

run cd /usr/local/src && git clone https://github.com/crohr/pkgr

run echo "pkgr ALL= NOPASSWD: /usr/bin/apt-get\npkgr ALL= NOPASSWD: /usr/sbin/service" >> /etc/sudoers

# required for apps that write to /opt/appname
run chown -R pkgr.pkgr /opt

run chmod 4111 /usr/bin/sudo
