# 说明：
cloudflare warp linux 官方客户端，开启socks模式，开箱即用


GitHub：https://github.com/SuperNG6/docker-warp-proxy

DockerHub：https://hub.docker.com/r/superng6/warp-proxy

```shell
docker run -d \
  --name warp-proxy \
  -p 40000:40000 \
  --restart unless-stopped \
  --memory 100m \
  --log-driver json-file \
  --log-opt max-size=2m \
  --log-opt max-file=1 \
  superng6/warp-proxy:latest
```  

```yml
version: '2'
services:
  warp-proxy:
    image: superng6/warp-proxy:latest
    ports:
      - 40000:40000
    restart: unless-stopped
    mem_limit: 100m
    logging:
      driver: "json-file"
      options:
        max-size: "2m"
        max-file: "1"    
```
