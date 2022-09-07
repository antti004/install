#!/bin/bash
curl -fsSL get.docker.com -o /tmp/get-docker.sh && sh /tmp/get-docker.sh
sudo usermod -aG docker ${USER}
su - ${USER}
apt install -y docker-compose
