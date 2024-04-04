# Windows build environment

## Build image

```sh
$Env:DOCKER_BUILDKIT=0
docker build -t mikoto2000/node-buildkit:21.7.1-windows -f .\Dockerfile_windows .
```

