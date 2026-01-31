#!/bin/sh

# Ensure proper permissions on the data directory
# Render mounts disks as root by default sometimes
if [ -d "/home/node/.n8n" ]; then
  echo "Setting permissions on /home/node/.n8n..."
  chown -R node:node /home/node/.n8n
fi

# Start the backup script in the background as the node user
su-exec node /usr/local/bin/backup.sh &

# Start n8n as the node user
echo "Starting n8n..."
exec su-exec node n8n start
