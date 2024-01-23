# Dockerの中でryeをうごかしたいんじゃぁ^～

## 使い方

### Docker

```shell
docker build --no-cache -t sio-rye:latest -f ./docker/Dockerfile .
docker run -it --rm -v .:/app -p 8000:8000 sio-rye:latest bash
```

### docker compose

```shell
docker compose build
docker compose up -d
```
