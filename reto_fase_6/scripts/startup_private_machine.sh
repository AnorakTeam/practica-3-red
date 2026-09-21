#!/bin/bash
apt-get update -y
apt-get install -y python3
mkdir -p /srv/data
echo "Mensaje confidencial desde el backend privado: $(hostname), y acá algo random: $RANDOM" > /srv/data/index.html
cd /srv/data
nohup python3 -m http.server 8080 > /srv/data/server.log 2>&1 &