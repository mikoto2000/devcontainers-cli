#!/bin/bash
#
# build_linux_by_nexe.bash
#
# Usage:
#     build_linux_by_nexe.bash TAG_NAME
#

# 引数チェック
if [ "${1}" = '' ]; then
  echo "Usage: build_linux_by_nexe.bash TAG_NAME NODE_VERSION"
  exit 1
fi

if [ "${2}" = '' ]; then
  echo "Usage: build_linux_by_nexe.bash TAG_NAME NODE_VERSION"
  exit 1
fi

APP_VERSION="${1}"
NODE_VERSION="${2}"
OS="linux"
ARCH="x64"
APP_SUFFIX="${OS}-${ARCH}-${APP_VERSION}"
NEXE_TARGET="${OS}-${ARCH}-${NODE_VERSION}"

CURRENT_DIR=$(cd $(dirname $0);pwd)

APP_NAME="devcontainer"
BIN_PATH="../dist/devcontainer-${APP_SUFFIX}"

# compile devcontainers/cli
cd upstream
yarn
yarn compile-prod

# create single executable binary by nexe
npx -y nexe --loglevel="verbose" -i ./devcontainer.js --make="-j$(nproc)" -r="scripts/updateUID.Dockerfile" -t ${SUFFIX} -b -o ${BIN_PATH}

