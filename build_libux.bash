#!/bin/bash
#
# build_linux.bash
#
# Usage:
#     build_linux.bash TAG_NAME
#

# 引数チェック
if [ "${1}" = '' ]; then
  echo "Usage: build_linux.bash TAG_NAME"
  exit 1
fi

VERSION="${1}"
OS="linux"
ARCH="x64"
SUFFIX="${OS}-${ARCH}-${VERSION}"

CURRENT_DIR=$(cd $(dirname $0);pwd)

APP_NAME="devcontainer"
BIN_PATH="./dist/devcontainer-${SUFFIX}"
CONFIG="${CURRENT_DIR}/tmp/sea-config-linux.json"
BLOB="${CURRENT_DIR}/tmp/sea-prep-linux.blob"

# compile devcontainers/cli
cd upstream
yarn
yarn compile-prod

# create sea
cd ${CURRENT_DIR}
mkdir -p dist
mkdir -p tmp

cp /usr/local/bin/node ${BIN_PATH}

echo '{"main": "./upstream/dist/spec-node/devContainersSpecCLI.js", "output": "'${BLOB}'", "disableExperimentalSEAWarning": true}' > ${CONFIG}
node --experimental-sea-config ${CONFIG}

npx -y postject ${BIN_PATH} NODE_SEA_BLOB ${BLOB} --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2

