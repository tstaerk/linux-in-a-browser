# noVNC with Chrome on Cloud Run

This repository contains a Dockerized noVNC environment running Ubuntu 24.04, XFCE4, and Google Chrome. It is designed to be deployed to Google Cloud Run.

## Files
- `Dockerfile`: Sets up Ubuntu, XFCE, noVNC, and Chrome.
- `start.sh`: Entrypoint script to start Xvnc, XFCE, and the noVNC proxy.
- `xstartup`: XFCE startup configuration.
- `setup.sh`: Deployment script using `gcloud`.

## Requirements
- [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)
- A Google Cloud project with billing enabled.

## Quick Start
1. Authenticate with Google Cloud:
   ```bash
   gcloud auth login
   gcloud config set project YOUR_PROJECT_ID
   ```
2. Run the setup script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
# linux-in-a-browser
