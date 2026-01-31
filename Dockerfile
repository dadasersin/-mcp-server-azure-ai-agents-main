FROM n8nio/n8n:latest-alpine

ENV N8N_PORT=5678
EXPOSE 5678

USER root

# Install git, openssh, and su-exec for backup and permission management
RUN apk add --no-cache git openssh-client su-exec

# Create directory for backups and set permissions
RUN mkdir -p /home/node/.n8n/backups /home/node/initial-workflows && \
    chown -R node:node /home/node/.n8n /home/node/initial-workflows

COPY initial-workflows /home/node/initial-workflows

COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

# Setup n8n and backup script to run together
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Run as root to allow chown in entrypoint, then entrypoint will switch to node user
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
