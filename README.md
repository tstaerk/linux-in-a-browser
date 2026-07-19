# CloudStation

### Your Linux is just a URL away.

CloudStation is a graphical Linux desktop that runs in your browser.

<img width="634" height="400" alt="Screenshot 2026-07-15 195012" src="https://github.com/user-attachments/assets/579fa1f4-3592-4ae1-b3bd-74ea89a310d1" />
No installation. No virtual machine.
Deploy it to Google Cloud Run in minutes.

It combines Ubuntu 24.04, MATE, Google Chrome, TigerVNC and noVNC into a ready-to-deploy desktop that runs on Google Cloud Run.

## Five Reasons Why You Need a Linux Browser-Tab
- `Datacenter Speed`: My home fiber gets 44 Mbit/s. My cloud instance? 495 Mbit/s. It’s like having a supercomputer in a tab.
- `The Bastion Host`: It acts as a secure gateway aka jump server to reach private databases or internal APIs shielded from the public internet.
- `Geo-Flexibility`: Need US-only rental car rates while sitting in Europe? Spin up your container in us-central1 and you're a local.
- `Sharing is caring`: Want to show your colleague how to solve a problem? Just invite them to your Linux desktop and let them look over your shoulder. And even take over keyboard and mouse!
- `Seamless Continuity`: Start a task at the office, close your laptop, and pick up exactly where you left off at home.

## Quick Start
1. In Google Cloud Console, open the Cloud Shell
2. Clone this repository:
   ```
   git clone https://github.com/tstaerk/cloudstation
   cd cloudstation
   ```   
3. Run the setup script:
   ```
   bash setup.sh
   ```
4. Give the role IAP-secured Web App User to all users who shall be allowed to use this. Or allow public access: console.cloud.google.com -> Cloud Run -> Overview -> novnc-chrome -> security -> allow public access
5. Surf to the service URL, find it under console.cloud.google.com -> Cloud Run -> Overview -> novnc-chrome -> URL. It will be something like https://novnc-chrome-84257783069.us-central1.run.app

## Bastion Host
To use your container environment as a bastion host aka jump server, I recommend you use Direct VPC Egress. When your service is running, click on it -> Edit and Deploy new revision -> Networking -> Connect to a VPC for outbount traffic -> Send traffic directly to a VPC. Afterwards, you can set the respective firewall rules. Then, you will be able to ping the VMs in your project's VPC!!!
   
## Files
- `Dockerfile`: Sets up Ubuntu, MATE, noVNC, and Chrome.
- `start.sh`: Entrypoint script to start Xvnc, MATE, and the noVNC proxy.
- `xstartup`: MATE startup configuration.
- `setup.sh`: Deployment script using `gcloud`.

## Requirements
- [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)
- A Google Cloud project with billing enabled.

## See also
* https://medium.com/p/e883b5b65e02
