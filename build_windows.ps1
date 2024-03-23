# build_windows.ps1
#
# 引数:
#     Version: ビルドしたバイナリのふぃある名に付与するバージョン番号

Param(
    [string]$Version
)

# Version が指定されていなかった場合即終了する
if ([String]::IsNullOrEmpty($Version)) {
    Write-Error "'Version' が設定されていません。"
    return 1
}
$OS="windows"
$ARCH="x64"
$SUFFIX="${OS}-${ARCH}-${Version}"

$CURRENT_DIR = . Split-Path -Parent $MyInvocation.MyCommand.Path

$APP_NAME="devcontainer"
$BIN_PATH="./dist/devcontainer-${SUFFIX}.exe"
$CONFIG="./tmp/sea-config-windows.json"
$BLOB="./tmp/sea-prep-windows.blob"

cd upstream
npm i -g yarn
yarn
yarn compile-prod

cd $CURRENT_DIR
New-Item -ItemType Directory -ErrorAction SilentlyContinue dist
New-Item -ItemType Directory -ErrorAction SilentlyContinue tmp

Copy-Item "C:/Program Files/nodejs/node.exe" ${BIN_PATH}

$configJsonStr = '{"main": "./upstream/dist/spec-node/devContainersSpecCLI.js", "output": "' + ${BLOB} + '", "disableExperimentalSEAWarning": true}'
Write-Output $configJsonStr | Out-File -Encoding ascii ${CONFIG}
node --experimental-sea-config ${CONFIG}

npx -y postject ${BIN_PATH} NODE_SEA_BLOB ${BLOB} `
    --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2
