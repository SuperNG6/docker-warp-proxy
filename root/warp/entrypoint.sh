#!/bin/bash

(
while ! warp-cli --accept-tos register; do
	sleep 1
	>&2 echo "Awaiting warp-svc become online..."
done
warp-cli --accept-tos set-mode proxy
warp-cli --accept-tos set-proxy-port 40001
warp-cli --accept-tos connect
haproxy -f /etc/haproxy/haproxy.cfg
) &

exec warp-svc 2>&1 >/dev/null

