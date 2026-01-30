#!/bin/sh

# Wait for n8n to start and create necessary files
sleep 60

# One-time copy of initial workflows to the backup folder if it's empty
if [ -d "/home/node/initial-workflows" ] && [ ! -f "/home/node/.n8n/backups/initial_loaded.txt" ]; then
  echo "Loading initial workflows into backup folder..."
  mkdir -p /home/node/.n8n/backups
  cp /home/node/initial-workflows/* /home/node/.n8n/backups/
  touch /home/node/.n8n/backups/initial_loaded.txt
fi

while true; do
  echo "--- Starting Automated Backup to GitHub ---"

  if [ -z "$GITHUB_REPO_URL" ] || [ -z "$GITHUB_TOKEN" ] || [ -z "$GITHUB_EMAIL" ]; then
    echo "ERROR: Backup environment variables (GITHUB_REPO_URL, GITHUB_TOKEN, GITHUB_EMAIL) are not set."
    echo "Skipping backup for this cycle."
  else
    # Export workflows and credentials using n8n CLI
    # We use a temp directory to avoid git conflicts during export
    mkdir -p /home/node/.n8n/backups

    echo "Exporting workflows..."
    n8n export:workflow --all --output=/home/node/.n8n/backups/workflows.json

    # Credentials are NOT exported by default for security.
    # To include them, uncomment the lines below, but BE CAREFUL with your repository privacy.
    # echo "Exporting credentials..."
    # n8n export:credentials --all --output=/home/node/.n8n/backups/credentials.json

    cd /home/node/.n8n/backups

    if [ ! -d ".git" ]; then
      echo "Initializing git repository..."
      git init
      git config --global user.email "${GITHUB_EMAIL}"
      git config --global user.name "n8n-backup-bot"
      git branch -M main
    fi

    # Update origin with token if necessary
    # Extract domain and path from GITHUB_REPO_URL
    # Expected: https://github.com/user/repo.git
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

  echo "Next backup in 5 minutes..."
  sleep 300
done
