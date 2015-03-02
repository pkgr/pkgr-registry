from centos:6

run yum update -y
run yum install -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
run yum install -y git
run yum install -y python-boto
run yum install -y deltarpm python-deltarpm

run cd /usr/local/src && git clone https://github.com/crohr/rpm-s3 --recursive
run cd /usr/local/src/rpm-s3 && git fetch origin && git reset --hard 500d4c9
