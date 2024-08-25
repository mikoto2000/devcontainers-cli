# devcontainers-cli

Distributing a single executable binary for [devcontainer/cli](https://github.com/devcontainers/cli).


## build

### Windows

[dockerfile/build-env](./dockerfile/build-env) の Docker イメージを利用してビルドする。

```sh
git clone --depth 1 -b v0.68.0 https://github.com/devcontainers/cli.git upstream
docker run -it --rm -v "$(pwd):C:/work" --workdir /work mikoto2000/node-buildkit:21.7.1-windows powershell -c .\build_windows.ps1 ${TAG_NAME}
```


### Linux

```sh
git clone --depth 1 -b v0.68.0 https://github.com/devcontainers/cli.git upstream
docker run -it --rm -v "$(pwd):/work" --workdir /work node:21.7.1-bookworm ./build_linux.bash ${TAG_NAME}
```


