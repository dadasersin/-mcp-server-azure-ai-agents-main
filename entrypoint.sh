#!/bin/sh

# Start the backup script in the background
/usr/local/bin/backup.sh &

# Start n8n
exec n8n start
