#!/usr/bin/env bash
set -e

NOM_IMAGE="monapp"
NOM_CONTENEUR="monapp"
PORT_HOTE=8090
PORT_CONTENEUR=7000

# Se placer dans le dossier du script (là où se trouve le Dockerfile)
cd "$(dirname "$0")"

echo "==> Suppression de l'ancien conteneur (s'il existe)..."
docker rm -f "$NOM_CONTENEUR" 2>/dev/null || true

echo "==> Build de l'image $NOM_IMAGE..."
docker build -t "$NOM_IMAGE" .

echo "==> Lancement du conteneur $NOM_CONTENEUR..."
docker run -d \
  --name "$NOM_CONTENEUR" \
  --restart unless-stopped \
  -p "$PORT_HOTE:$PORT_CONTENEUR" \
  "$NOM_IMAGE"

sleep 2

echo "==> Etat du conteneur :"
docker ps --filter "name=$NOM_CONTENEUR"

IP=$(hostname -I | awk '{print $1}')
echo
echo "Application disponible sur : http://$IP:$PORT_HOTE"
