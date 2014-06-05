from centos:centos6

run yum check-update || true

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

# required for postgres
run echo "NETWORKING=yes" > /etc/sysconfig/network

# setup postgres
run yum install -y http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/pgdg-centos91-9.1-4.noarch.rpm
run yum install -y postgresql91-server
run ln -s /etc/init.d/postgresql-9.1 /etc/init.d/postgresql
run service postgresql initdb

# setup postgres database
run service postgresql start && sleep 3 && \
  echo "CREATE USER \"user\" SUPERUSER PASSWORD 'pass';" | su - postgres -c psql && \
  echo "CREATE DATABASE dbname;" | su - postgres -c psql && \
  echo "GRANT ALL PRIVILEGES ON DATABASE \"dbname\" TO \"user\";" | su - postgres -c psql

# setup redis
# run curl http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm > epel-release-6-8.noarch
# rpm -Uvh epel-release-6*.rpm
# epel is required for the dependencies
run yum install -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
run yum install -y http://rpms.famillecollet.com/enterprise/6/remi/x86_64/redis-2.8.17-2.el6.remi.x86_64.rpm
run ln -s /etc/init.d/redis /etc/init.d/redis-server
run yum install -y tar

# install ruby
run cd /usr/local/src/ && wget -q http://pyyaml.org/download/libyaml/yaml-0.1.6.tar.gz && tar xzf yaml-0.1.6.tar.gz
run cd /usr/local/src/yaml-0.1.6/ && ./configure --prefix=/usr/local && make && make install
run cd /usr/local/src && wget -q https://rvm.io/binaries/centos/6.4/x86_64/ruby-2.1.0.tar.bz2 && tar xjf ruby-2.1.0.tar.bz2 -C /usr/local/ --strip-components=1
run mkdir -p /usr/local/rvm/gems/cache

# rubygems 2.0.0 is buggy as hell
run gem update --system --no-ri --no-rdoc

run rm -rf /usr/local/src/*

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

run echo "pkgr ALL=(ALL) NOPASSWD: /usr/bin/yum, /sbin/service" >> /etc/sudoers
run sed -i 's/Defaults    requiretty//' /etc/sudoers

run echo "host    all             all             127.0.0.1/32            md5" > /var/lib/pgsql/9.1/data/pg_hba.conf

run yum install -y pkgconfig cmake
run yum install -y socat
run yum install -y bzr mercurial

# more recent version of git, otherwise it does not work with gopkg.in
run rpm -i 'http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm'
run rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
run yum install -y git --enablerepo=rpmforge-extras
