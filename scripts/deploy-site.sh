#!/bin/bash
# Deploy launch.mushroom.cv site to Cloudflare Pages (production)
# Usage: bash scripts/deploy-site.sh

set -euo pipefail

PROJECT_NAME="launch-mushroom-box"
DEPLOY_DIR="site"

echo "=== Deploying $DEPLOY_DIR → $PROJECT_NAME (production) ==="
echo ""

# Check deploy dir exists
if [ ! -d "$DEPLOY_DIR" ]; then
    echo "ERROR: $DEPLOY_DIR directory not found. Run from repo root."
    exit 1
fi

# Show what will be deployed
echo "Files to deploy:"
ls -la "$DEPLOY_DIR"/*.html
echo ""

# Deploy
wrangler pages deploy "$DEPLOY_DIR" \
    --project-name "$PROJECT_NAME" \
    --branch production \
    --commit-dirty=true

echo ""
echo "=== Deployment complete ==="
echo "Production: https://launch.mushroom.cv"
echo ""

# Quick smoke test
echo "Smoke test (HTTP status):"
STATUS=$(curl -sI -o /dev/null -w "%{http_code}" "https://launch.mushroom.cv/" 2>/dev/null || echo "FAILED")
echo "  https://launch.mushroom.cv/ → $STATUS"
