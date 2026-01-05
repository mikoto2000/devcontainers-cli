# build_windows_by_bun.ps1
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

$BIN_PATH="./dist/devcontainer-${SUFFIX}.exe"

cd upstream
npm i -g yarn
yarn
yarn compile-prod

cd $CURRENT_DIR

bun build --compile --target=bun-windows-x64 `
    --outfile ${BIN_PATH} `
    ./upstream/dist/spec-node/devContainersSpecCLI.js
