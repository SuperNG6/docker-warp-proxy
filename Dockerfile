FROM ubuntu:jammy
LABEL maintainer="SuperNG6"

WORKDIR /warp

RUN apt update && apt -y install --no-install-recommends haproxy curl ca-certificates && \
    curl -o warp.deb https://pkg.cloudflareclient.com/uploads/cloudflare_warp_2023_3_258_1_amd64_ce5bb06f9b.deb && \
    apt update && apt -y install --no-install-recommends ./warp.deb && \
    rm warp.deb && \
    echo "**** cleanup ****" && \
    apt-get clean && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

COPY root/ /
RUN chmod +x /warp/entrypoint.sh

EXPOSE 40000

ENTRYPOINT [ "/warp/entrypoint.sh"]
