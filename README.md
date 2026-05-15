# Run your graphical Linux Desktop in a browser
This repository allows you to export a Linux container's graphical desktop environment to a browser. It contains a Dockerized noVNC environment running Ubuntu 24.04, XFCE4, and Google Chrome. It is designed to be deployed to Google Cloud Run.

<img width=50% alt="Graphical Linux Desktop in a Browser" src="https://github.com/user-attachments/assets/de10d596-ec8c-4324-a9bd-c3c6f7d60c8a" />

## Quick Start
1. In Google Cloud Console, open the Cloud Shell
2. Clone this repository:
   ```
   git clone https://github.com/tstaerk/linux-in-a-browser
   cd linux-in-a-browser
   ```   
3. Run the setup script:
   ```
   bash setup.sh
   ```
4. Give the role IAP-secured Web App User to all users who shall be allowed to use this. Or allow public access: console.cloud.google.com -> Cloud Run -> Overview -> novnc-chrome -> security -> allow public access
5. Surf to the service URL, find it under console.cloud.google.com -> Cloud Run -> Overview -> novnc-chrome -> URL. It will be something like https://novnc-chrome-84257783069.us-central1.run.app

## Five Reasons Why You Need a Linux Browser-Tab
- `Seamless Continuity`: Start a task at the office, close your laptop, and pick up exactly where you left off at home.
- `Datacenter Speed`: My home fiber gets 44 Mbit/s. My cloud instance? 495 Mbit/s. It’s like having a supercomputer in a tab.
- `The Bastion Host`: It acts as a secure gateway aka jump server to reach private databases or internal APIs shielded from the public internet.
- `Geo-Flexibility`: Need US-only rental car rates while sitting in Europe? Spin up your container in us-central1 and you're a local.
- `Sharing is caring`: Want to show your colleague how to solve a problem? Just invite them to your Linux desktop and let them look over your shoulder. And even take over keyboard and mouse!
   
## Files
- `Dockerfile`: Sets up Ubuntu, XFCE, noVNC, and Chrome.
- `start.sh`: Entrypoint script to start Xvnc, XFCE, and the noVNC proxy.
- `xstartup`: XFCE startup configuration.
- `setup.sh`: Deployment script using `gcloud`.

## Requirements
- [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)
- A Google Cloud project with billing enabled.

## See also
* https://medium.com/p/e883b5b65e02
