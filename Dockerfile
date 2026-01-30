FROM n8nio/n8n:latest

USER root
# Paketleri yükle
RUN apt-get update && apt-get install -y git openssh-client && rm -rf /var/lib/apt/lists/*

# Dosya izinlerini ve dizinleri ayarla (Örnek)
RUN mkdir -p /home/node/backups && chown -R node:node /home/node/backups

USER node
