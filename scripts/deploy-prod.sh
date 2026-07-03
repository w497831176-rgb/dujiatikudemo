#!/bin/bash
set -e

PROD_DIR="/volume3/docker/dujia-tiku"
REPO_URL="https://github.com/w497831176-rgb/dujiatikudemo.git"

echo ">>> Deploying production environment"
cd "$PROD_DIR"

# Backup database before deployment
BACKUP_NAME="data/dujia-tiku.db.backup.$(date +%Y%m%d%H%M%S)"
cp data/dujia-tiku.db "$BACKUP_NAME"
echo ">>> Database backed up to $BACKUP_NAME"

# Pull latest code
git pull origin main

# Rebuild and restart
docker compose down
docker compose up -d --build

echo ">>> Production deployment complete at http://<nas-ip>:18081"
