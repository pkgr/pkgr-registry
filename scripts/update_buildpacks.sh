#!/bin/sh

set -e

ROOT_DIR=${ROOT_DIR:="/web/buildpacks"}
SOURCES_DIR="${ROOT_DIR}/sources"
MANIFESTS_DIR="${ROOT_DIR}/manifests"

BUILDPACKS="
https://github.com/heroku/heroku-buildpack-ruby.git
https://github.com/heroku/heroku-buildpack-nodejs.git
https://github.com/pkgr/heroku-buildpack-ruby.git
https://github.com/kr/heroku-buildpack-go.git
"

mkdir -p ${ROOT_DIR} ${SOURCES_DIR} ${MANIFESTS_DIR}

for buildpack in ${BUILDPACKS}; do
  org=$(basename $(dirname ${buildpack}))
  name=$(basename ${buildpack} .git)
  target_dir="${SOURCES_DIR}/${org}/${name}.git"

  if [ -d "${target_dir}" ]; then
    echo "--> Updating ${buildpack}..."
    cd "${target_dir}"
    git remote update
  else
    echo "--> Cloning ${buildpack} into ${target_dir}..."
    git clone --mirror "${buildpack}" "${target_dir}"
  fi
  echo "--> done."
done

# The paths have to make sense for pkgr running within a docker container
# (/tmp/buildpacks is the mount point)

cat > /web/buildpacks/manifests/sles12 <<EOF
/tmp/buildpacks/sources/pkgr/heroku-buildpack-ruby.git#universal,BUILDPACK_NODE_VERSION="0.6.8"
/tmp/buildpacks/sources/heroku/heroku-buildpack-nodejs.git#v58
/tmp/buildpacks/sources/kr/heroku-buildpack-go.git
EOF

cat > /web/buildpacks/manifests/fedora20 <<EOF
/tmp/buildpacks/sources/pkgr/heroku-buildpack-ruby.git#universal,BUILDPACK_NODE_VERSION="0.6.8"
/tmp/buildpacks/sources/heroku/heroku-buildpack-nodejs.git#v58
/tmp/buildpacks/sources/kr/heroku-buildpack-go.git
EOF

cat > /web/buildpacks/manifests/wheezy <<EOF
/tmp/buildpacks/sources/pkgr/heroku-buildpack-ruby.git#universal,BUILDPACK_NODE_VERSION="0.6.8"
/tmp/buildpacks/sources/heroku/heroku-buildpack-nodejs.git#v58
/tmp/buildpacks/sources/kr/heroku-buildpack-go.git
EOF

cat > /web/buildpacks/manifests/precise <<EOF
/tmp/buildpacks/sources/pkgr/heroku-buildpack-ruby.git#universal,BUILDPACK_NODE_VERSION="0.6.8"
/tmp/buildpacks/sources/heroku/heroku-buildpack-nodejs.git#v58
/tmp/buildpacks/sources/kr/heroku-buildpack-go.git
EOF

cat > /web/buildpacks/manifests/trusty <<EOF
/tmp/buildpacks/sources/pkgr/heroku-buildpack-ruby.git#universal,BUILDPACK_NODE_VERSION="0.6.8"
/tmp/buildpacks/sources/heroku/heroku-buildpack-nodejs.git#v58
/tmp/buildpacks/sources/kr/heroku-buildpack-go.git
EOF

cat > /web/buildpacks/manifests/centos6 <<EOF
/tmp/buildpacks/sources/pkgr/heroku-buildpack-ruby.git#universal,BUILDPACK_NODE_VERSION="0.6.8"
/tmp/buildpacks/sources/heroku/heroku-buildpack-nodejs.git#v58
/tmp/buildpacks/sources/kr/heroku-buildpack-go.git
EOF
