FROM n8nio/n8n:latest-alpine

ENV N8N_PORT=5678
EXPOSE 5678

USER root

# Install git for backups
RUN apk add --no-cache git openssh-client

# Create directory for backups and set permissions
RUN mkdir -p /home/node/.n8n/backups /home/node/initial-workflows && \
    chown -R node:node /home/node/.n8n /home/node/initial-workflows

COPY initial-workflows /home/node/initial-workflows

COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

USER node

# Setup n8n and backup script to run together
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# USER root again to make entrypoint executable then back to node
USER root
RUN chmod +x /usr/local/bin/entrypoint.sh
USER node

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
