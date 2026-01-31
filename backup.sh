#!/bin/sh

# Wait for n8n to start
echo "Waiting for n8n to start before importing workflows..."
sleep 60

# One-time import of initial workflows into n8n database
if [ -d "/home/node/initial-workflows" ] && [ ! -f "/home/node/.n8n/initial_imported.txt" ]; then
  echo "Importing initial workflows into n8n..."
  for f in /home/node/initial-workflows/*.json; do
    echo "Importing $f..."
    n8n import:workflow --input="$f"
  done
  touch /home/node/.n8n/initial_imported.txt
fi

# One-time copy to backup folder for git tracking
if [ -d "/home/node/initial-workflows" ] && [ ! -f "/home/node/.n8n/backups/initial_loaded.txt" ]; then
  echo "Copying initial workflows to backup folder..."
  mkdir -p /home/node/.n8n/backups
  cp /home/node/initial-workflows/*.json /home/node/.n8n/backups/
  touch /home/node/.n8n/backups/initial_loaded.txt
fi

while true; do
  echo "--- Starting Automated Backup to GitHub ---"

  if [ -z "$GITHUB_REPO_URL" ] || [ -z "$GITHUB_TOKEN" ] || [ -z "$GITHUB_EMAIL" ]; then
    echo "NOTICE: Backup environment variables (GITHUB_REPO_URL, GITHUB_TOKEN, GITHUB_EMAIL) are not set."
    echo "To enable GitHub backups, please set these variables in your Render dashboard."
  else
    mkdir -p /home/node/.n8n/backups

    echo "Exporting workflows..."
    n8n export:workflow --all --output=/home/node/.n8n/backups/workflows.json

    cd /home/node/.n8n/backups

    if [ ! -d ".git" ]; then
      echo "Initializing git repository..."
      git init
      git config --global user.email "${GITHUB_EMAIL}"
      git config --global user.name "n8n-backup-bot"
      git branch -M main
    fi

    CLEAN_URL=$(echo $GITHUB_REPO_URL | sed 's|https://||')
    AUTH_URL="https://${GITHUB_TOKEN}@${CLEAN_URL}"

    git remote remove origin 2>/dev/null
    git remote add origin "${AUTH_URL}"

    git add .
    git commit -m "Automated backup: $(date)" || echo "Nothing to commit"

    echo "Pushing to GitHub..."
    git push -u origin main

    if [ $? -eq 0 ]; then
      echo "Backup successful!"
    else
      echo "Backup failed. Check your token and repository permissions."
    fi
  fi

  echo "Next backup cycle in 5 minutes..."
  sleep 300
done
