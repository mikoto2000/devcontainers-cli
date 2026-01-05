#!/bin/bash
#
# build_darwin_by_bun.bash
#
# Usage:
#     build_darwin_by_bun.bash TAG_NAME
#

# 引数チェック
if [ "${1}" = '' ]; then
  echo "Usage: build_darwin_by_bun.bash TAG_NAME"
  exit 1
fi

VERSION="${1}"
OS="darwin"
ARCH="$(uname -m)"
if [ "${ARCH}" = "arm64" ]; then
  BUN_TARGET="bun-darwin-arm64"
else
  ARCH="x64"
  BUN_TARGET="bun-darwin-x64"
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
