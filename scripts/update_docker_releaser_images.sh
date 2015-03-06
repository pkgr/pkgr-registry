#!/bin/bash

set -ex
set -o pipefail

REGISTRY_DIR=${REGISTRY_DIR:="/web/registry"}
DOCKER_DIR="${REGISTRY_DIR}/docker"
RPMS3_DOCKER_DIR="${REGISTRY_DIR}/rpm-s3"
REGISTRY=${REGISTRY:=""}

sudo docker build -t rpm_s3/centos:6.4 ${RPMS3_DOCKER_DIR}/
if [ "$REGISTRY" != "" ]; then
	sudo docker tag rpm_s3/centos:6.4 ${REGISTRY}/rpm_s3/centos:6.4
	sudo docker push ${REGISTRY}/rpm_s3/centos:6.4
fi

echo "DONE!"
