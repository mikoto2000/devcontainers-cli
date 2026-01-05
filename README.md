# devcontainers-cli

Distributing a single executable binary for [devcontainer/cli](https://github.com/devcontainers/cli).


## build

### Upstream パッチ適用

clone 直後の `upstream` に修正を適用する。

```sh
git clone --depth 1 -b v0.68.0 https://github.com/devcontainers/cli.git upstream
git -C upstream apply ../upstream-bun.patch
```

### Windows

[dockerfile/build-env](./dockerfile/build-env) の Docker イメージを利用してビルドする。

```sh
git clone --depth 1 -b v0.68.0 https://github.com/devcontainers/cli.git upstream
docker run -it --rm -v "$(pwd):C:/work" --workdir /work mikoto2000/node-buildkit:21.7.1-windows powershell -c .\build_windows.ps1 ${TAG_NAME}
```

### Windows (Bun)

`updateUID.Dockerfile` はビルド時にバンドルへ埋め込まれるため、実行時に外部ファイルは不要。

```sh
git clone --depth 1 -b v0.68.0 https://github.com/devcontainers/cli.git upstream
powershell -c .\\build_windows_by_bun.ps1 ${TAG_NAME}
```

### macOS (Bun)

```sh
git clone --depth 1 -b v0.68.0 https://github.com/devcontainers/cli.git upstream
./build_darwin_by_bun.bash ${TAG_NAME}
```


### Linux

```sh
git clone --depth 1 -b v0.68.0 https://github.com/devcontainers/cli.git upstream
docker run -it --rm -v "$(pwd):/work" --workdir /work node:21.7.1-bookworm ./build_linux.bash ${TAG_NAME}
```

### Linux (Bun)

`updateUID.Dockerfile` はビルド時にバンドルへ埋め込まれるため、実行時に外部ファイルは不要。

```sh
git clone --depth 1 -b v0.68.0 https://github.com/devcontainers/cli.git upstream
./build_linux_by_bun.bash ${TAG_NAME}
```
