# Run your graphical Linux Desktop in a browser
This repository allows you to export a Linux container's graphical desktop environment to a browser. It contains a Dockerized noVNC environment running Ubuntu 24.04, XFCE4, and Google Chrome. It is designed to be deployed to Google Cloud Run.

<img width=50% alt="Graphical Linux Desktop in a Browser" src="https://github.com/user-attachments/assets/de10d596-ec8c-4324-a9bd-c3c6f7d60c8a" />

## Files
- `Dockerfile`: Sets up Ubuntu, XFCE, noVNC, and Chrome.
- `start.sh`: Entrypoint script to start Xvnc, XFCE, and the noVNC proxy.
- `xstartup`: XFCE startup configuration.
- `setup.sh`: Deployment script using `gcloud`.

## Requirements
- [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)
- A Google Cloud project with billing enabled.

## Quick Start
1. In Google Cloud Console, open the Cloud Shell
2. Clone this repository:
   ```
   git clone https://github.com/tstaerk/linux-in-a-browser
   cd linux-in-a-browser
   ```   
4. Run the setup script:
   ```
   bash setup.sh
   ```
