#!/bin/bash

set -ex
set -o pipefail

PKGR_STABLE_COMMIT="f297b43fc48b5a44b9b4db03457c54471c392533"
PKGR_TESTING_BRANCH=${PKGR_TESTING_BRANCH:="testing"}

WEB_DIR=${WEB_DIR:="/web"}
DOCKER_DIR="${WEB_DIR}/registry/docker"
RPMS3_DOCKER_DIR="${WEB_DIR}/registry/rpm-s3"
# we don't use it, as it is unreliable, and tries to always login.
REGISTRY=""

sudo docker pull postgres:9.3
sudo docker pull redis:2.8.13
# sudo docker pull ubuntu:12.04
# sudo docker pull ubuntu:14.04
# sudo docker pull debian:7
# sudo docker pull centos:centos6
# sudo docker pull fedora:20

generate_pkgr_install_command() {
  local sha="$1"
  local cmd="cd /usr/local/src/pkgr && git fetch origin && git reset --hard $sha && rm -f *.gem && gem build pkgr.gemspec && gem install *.gem --no-ri --no-rdoc"
  echo "$cmd"
}

generate_dockerfile() {
  local src="$1" # pkgr_base/ubuntu:12.04
  local sha="$2"
  local dir=$(mktemp -d)

  cp -r ${DOCKER_DIR}/common ${dir}/
  cat - > ${dir}/Dockerfile <<EOF
FROM ${REGISTRY}${src}
RUN $(generate_pkgr_install_command "${sha}")
ADD common/bin/annotate-output /usr/bin/
ADD common/bin/logger /usr/bin/
EOF
  echo "$dir"
}

IMAGES="${IMAGES:="debian/7 ubuntu/12.04 ubuntu/14.04 centos/6 centos/7 fedora/20 sles/12"}"
base_tags=""
# Build base docker images
for image in ${IMAGES} ; do
	sudo docker build -t ${REGISTRY}pkgr_base/${image//\//:} ${DOCKER_DIR}/${image}
	base_tags=$(echo -e "${base_tags}\npkgr_base/${image//\//:}")
done

echo $base_tags

# Stable
for tag in ${base_tags} ; do
  dst="stable"
  dst_tag=${tag/base/$dst}
  dir=$(generate_dockerfile "$tag" "${PKGR_STABLE_COMMIT}")
  sudo docker build -t "${REGISTRY}${dst_tag}" ${dir}
  rm -rf "$dir"
done

# Testing
latest_sha=$(git ls-remote --exit-code https://github.com/crohr/pkgr.git "${PKGR_TESTING_BRANCH}" | cut -f 1)
echo "Latest SHA: ${latest_sha}"
for tag in ${base_tags} ; do
  dst="testing"
  dst_tag=${tag/base/$dst}
  dir=$(generate_dockerfile "$tag" "${latest_sha}")
  sudo docker build -t "${REGISTRY}${dst_tag}" ${dir}
  rm -rf "$dir"
done

sudo docker build -t ${REGISTRY}rpm_s3/centos:6.4 ${RPMS3_DOCKER_DIR}/

echo "DONE!"

# cp -r ${DIR}/files/${ENVIRONMENT}/.rpmmacros /home/longhouse/ && chown -R longhouse.longhouse /home/longhouse/.rpmmacros