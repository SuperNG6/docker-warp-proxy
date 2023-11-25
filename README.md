# warp-svc
将 Cloudflare WARP 客户端作为 docker 中的 socks5 服务器

这个 dockerfile 会创建一个带有适用于 Linux 的 Cloudflare WARP 官方客户端的 docker 镜像，并提供一个 socks5 代理服务器，以便在本地计算机或 docker compose 或 Kubernetes 中的其他 docker 容器中的其他兼容应用程序中使用。

适用于 Linux 的 Cloudflare WARP 官方客户端只在 localhost 上侦听 socks 代理，因此无法在需要绑定到 0.0.0.0 的 docker 容器中使用。

## Features
* 注册新的 Cloudflare WARP 账户
* 可配置的 "家庭模式
* 订阅 Cloudflare WARP+

## How to use
socks 代理的端口为 `1080`。

你可以使用这些环境变量：

* `families_mode`：使用`off`、`malware`和`full`值之一。(默认值：`off）

* `warp_license`：放置您的 WARP+ 许可证。(你可以从这个电报机器人获取免费的 WARP+ 许可证：https://t.me/generatewarpplusbot）

应将容器中的 `/var/lib/cloudflare-warp`目录挂载到主机上，以确保 WARP 账户的持久性。请注意，每个 WARP+ 许可证只能在 4 台设备上运行，因此持久化配置非常重要！

### Using as a local proxy with Docker
```
docker run -d --name=warp -e FAMILIES_MODE=full -e WARP_LICENSE=xxxxxxxx-xxxxxxxx-xxxxxxxx -p 127.0.0.1:1080:1080 -v ${PWD}/warp:/var/lib/cloudflare-warp aleskxyz/warp-svc:latest
```
You can verify warp by visiting this url:
```
curl -x socks5h://127.0.0.1:1080 -sL https://cloudflare.com/cdn-cgi/trace | grep warp

warp=on
```
You can also use `warp-cli` command to control your connection:
```
docker exec warp warp-cli --accept-tos status

Status update: Connected
Success
```
### Using as a proxy for other containers with docker-compose

```
version: "3"
services:
  warp:
    image: aleskxyz/warp-svc:latest
    expose:
    - 1080
    restart: always
    environment:
      WARP_LICENSE: xxxxxxxx-xxxxxxxx-xxxxxxxx
      FAMILIES_MODE: off
    volumes:
    - ./warp:/var/lib/cloudflare-warp
  app:
    image: <app-image>
    depends_on:
    - warp
    environment:
      proxy: warp:1080
```

