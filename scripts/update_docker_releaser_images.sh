#!/bin/bash

set -ex
set -o pipefail

REGISTRY_DIR=${REGISTRY_DIR:="/web/registry"}
DOCKER_DIR="${REGISTRY_DIR}/docker"
RPMS3_DOCKER_DIR="${REGISTRY_DIR}/rpm-s3"
REGISTRY=${REGISTRY:=""}

sudo docker build -t ${REGISTRY}rpm_s3/centos:6.4 ${RPMS3_DOCKER_DIR}/
sudo docker push ${REGISTRY}rpm_s3/centos:6.4

echo "DONE!"
