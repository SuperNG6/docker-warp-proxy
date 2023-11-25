FROM ubuntu:22.04

ENV PROXY_PORT=1080 \
    TZ=Asia/Shanghai \
    WARP_LICENSE= \
    FAMILIES_MODE=off \
    WARP_LICENSE=

ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 1080/tcp

RUN apt update && \
  apt install curl gpg socat tzdata -y && \
  curl https://pkg.cloudflareclient.com/pubkey.gpg | \
  gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg && \
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ jammy main" | \
  tee /etc/apt/sources.list.d/cloudflare-client.list && \
  apt update && \
  apt install cloudflare-warp -y && \
  rm -rf /var/lib/apt/lists/*

COPY --chmod=755 entrypoint.sh entrypoint.sh

VOLUME ["/var/lib/cloudflare-warp"]
CMD ["./entrypoint.sh"]