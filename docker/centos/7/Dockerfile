from centos:7

run yum -y install \
  git \
  vim \
  sudo \
  wget \
  curl \
  openssl-devel \
  readline-devel \
  libxml2-devel \
  libxslt-devel \
  libevent-devel \
  postgresql-devel \
  mysql-devel \
  sqlite-devel \
  gcc gcc-c++ kernel-devel

run yum install -y rpm-build
run yum install -y ruby ruby-devel

run yum install -y pkgconfig cmake
run yum install -y socat
run yum install -y bzr mercurial git
run yum install -y make

# setup various stuff related to pkgr user
run groupadd --gid 1234 --system pkgr
run adduser pkgr --shell /bin/bash --create-home --uid 1234 --gid 1234 --system
# required for apps that write to /opt/appname
run mkdir -p /opt
run chown -R pkgr.pkgr /opt
run chmod 4111 /usr/bin/sudo

# download pkgr
run cd /usr/local/src && git clone https://github.com/crohr/pkgr
run cd /usr/local/src/pkgr && gem build pkgr.gemspec && gem install pkgr-*.gem --no-ri --no-rdoc

run echo "pkgr ALL=(ALL) NOPASSWD: /usr/bin/yum" >> /etc/sudoers
run sed -i 's/Defaults    requiretty//' /etc/sudoers
