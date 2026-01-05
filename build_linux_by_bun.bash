#!/bin/bash
#
# build_linux_by_bun.bash
#
# Usage:
#     build_linux_by_bun.bash TAG_NAME [ARCH]
#

# 引数チェック
if [ "${1}" = '' ]; then
  echo "Usage: build_linux_by_bun.bash TAG_NAME"
  exit 1
fi

VERSION="${1}"
OS="linux"
ARCH="${2:-x64}"
if [ -z "${BUN_TARGET}" ]; then
  BUN_TARGET="bun-linux-${ARCH}"
fi
SUFFIX="${OS}-${ARCH}-${VERSION}"

CURRENT_DIR=$(cd $(dirname $0);pwd)

BIN_PATH="${CURRENT_DIR}/dist/devcontainer-${SUFFIX}"

# compile devcontainers/cli
cd "${CURRENT_DIR}/upstream"
yarn
yarn compile-prod

# create single executable binary by bun
cd "${CURRENT_DIR}"
bun build --compile --target="${BUN_TARGET}" \
  --outfile "${BIN_PATH}" \
  ./upstream/dist/spec-node/devContainersSpecCLI.js
