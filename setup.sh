#!/bin/bash
# setup.sh - Build and deploy to Cloud Run with requested specs

SERVICE_NAME="novnc-chrome"
REGION="us-central1"
MEMORY="2Gi"
TIMEOUT="3600"

echo "Deploying '$SERVICE_NAME' to Cloud Run..."
echo "Specs: RAM=$MEMORY, Timeout=${TIMEOUT}s"

# Deploy using source-to-container (Cloud Build)
gcloud run deploy "$SERVICE_NAME" \
    --source . \
    --region "$REGION" \
    --memory "$MEMORY" \
    --timeout "$TIMEOUT" \
    --no-allow-unauthenticated --iap && echo "Done! Your noVNC instance should be available at the URL provided above."
