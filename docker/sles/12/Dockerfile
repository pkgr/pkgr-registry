from crohr/sles:12

RUN zypper ar --no-gpgcheck -t yast2 "http://storage.googleapis.com/pkgr-io-cache/SLE-12-Server-DVD-x86_64-GM-DVD1" "SLES12 Server DVD1"
RUN zypper ar --no-gpgcheck -t yast2 "http://storage.googleapis.com/pkgr-io-cache/SLE-12-SDK-DVD-x86_64-GM-DVD1" "SLES12 SDK DVD1"

RUN zypper install -y zlib-devel libopenssl-devel
RUN zypper install -y ruby2.1 ruby2.1-devel
RUN zypper install -y rpm-build
RUN zypper install -y git-core ca-certificates
RUN zypper install -y socat

# setup various stuff related to pkgr user
run groupadd --gid 1234 --system pkgr
run useradd pkgr --shell /bin/bash --create-home --uid 1234 --gid 1234 --system
# required for apps that write to /opt/appname
run mkdir -p /opt
run chown -R pkgr.pkgr /opt
run chmod 4111 /usr/bin/sudo

# download pkgr
run cd /usr/local/src && git clone https://github.com/crohr/pkgr
run cd /usr/local/src/pkgr && gem build pkgr.gemspec && gem install pkgr-*.gem --no-ri --no-rdoc
run ln -sf /usr/bin/pkgr.ruby2.1 /usr/bin/pkgr
run ln -sf /usr/bin/fpm.ruby2.1 /usr/bin/fpm

run echo "pkgr ALL=(ALL) NOPASSWD: /usr/bin/zypper" >> /etc/sudoers
run sed -i 's/Defaults    requiretty//' /etc/sudoers
