# build_windows_by_bun.ps1
#
# 引数:
#     Version: ビルドしたバイナリのふぃある名に付与するバージョン番号
#     Arch: 出力する CPU アーキテクチャ

Param(
    [string]$Version,
    [string]$Arch = "x64"
)

# Version が指定されていなかった場合即終了する
if ([String]::IsNullOrEmpty($Version)) {
    Write-Error "'Version' が設定されていません。"
    return 1
}
$OS="windows"
$ARCH=$Arch
if ([String]::IsNullOrEmpty($env:BUN_TARGET)) {
    $env:BUN_TARGET="bun-windows-$ARCH"
}
$SUFFIX="${OS}-${ARCH}-${Version}"

$CURRENT_DIR = . Split-Path -Parent $MyInvocation.MyCommand.Path

$BIN_PATH="./dist/devcontainer-${SUFFIX}.exe"

cd upstream
npm i -g yarn
yarn
yarn compile-prod

cd $CURRENT_DIR

bun build --compile --target=$env:BUN_TARGET `
    --outfile ${BIN_PATH} `
    ./upstream/dist/spec-node/devContainersSpecCLI.js
