# build_windows.ps1
#
# 引数:
#     AppVersion: ビルドしたバイナリのふぃある名に付与するバージョン番号

Param(
    [string]$AppVersion,
    [string]$NodeVersion
)

# AppVersion が指定されていなかった場合即終了する
if ([String]::IsNullOrEmpty($AppVersion)) {
    Write-Error "'AppVersion' が設定されていません。"
    return 1
}
if ([String]::IsNullOrEmpty($NodeVersion)) {
    Write-Error "'NodeVersion' が設定されていません。"
    return 1
}

$OS="windows"
$ARCH="x64"
$APP_SUFFIX="${OS}-${ARCH}-${AppVersion}"
$NEXE_TARGET="${OS}-${ARCH}-${NodeVersion}"

$CURRENT_DIR = . Split-Path -Parent $MyInvocation.MyCommand.Path

$APP_NAME="devcontainer"
$BIN_PATH="../dist/devcontainer-${APP_SUFFIX}.exe"

cd upstream
npm i -g yarn
yarn
yarn compile-prod

npx -y nexe -i ./devcontainer.js -r="scripts/updateUID.Dockerfile" -t ${NEXE_TARGET} -b -o ${BIN_PATH}

