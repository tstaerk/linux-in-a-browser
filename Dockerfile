FROM ubuntu:24.04

ENV HOSTNAME=cloudstation
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV VNC_RESOLUTION=1280x800
ENV VNC_COL_DEPTH=24
ENV PORT=8080

RUN apt-get update && apt-get install -y \
    mate-desktop-environment-core \
    mate-applets \
    mate-indicator-applet \
    mate-applet-brisk-menu \
    caja \
    mate-terminal \
    tigervnc-standalone-server \
    novnc \
    websockify \
    dbus \
    dbus-x11 \
    mesa-utils \
    x11-xserver-utils \
    xauth \
    xfonts-base \
    xfonts-75dpi \
    xfonts-100dpi \
    wget \
    curl \
    openssh-client \
    iputils-ping \
    gnupg \
    feh \
    procps \
    vim \
    papirus-icon-theme \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

#
# Install Google Chrome
#
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub \
 | gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg \
 && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
 > /etc/apt/sources.list.d/google-chrome.list \
 && apt-get update \
 && apt-get install -y google-chrome-stable \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

#
# Chrome wrapper (Chrome läuft als root im Container)
#
RUN printf '#!/bin/bash\nexec /usr/bin/google-chrome-stable --no-sandbox "$@"\n' \
 > /usr/local/bin/google-chrome \
 && chmod +x /usr/local/bin/google-chrome

#
# VNC
#
RUN mkdir -p /root/.vnc

#
# Scripts
#
RUN mkdir -p /opt/scripts

COPY xstartup /root/.vnc/xstartup
COPY start.sh /opt/scripts/start.sh
COPY prieros.jpg /usr/share/backgrounds/prieros.jpg
COPY cloudstation-background.png /usr/share/backgrounds/
COPY cloudstation-wallpaper.png /usr/share/backgrounds/
COPY chrome.desktop terminal.desktop /root/Desktop/

RUN chmod +x /root/.vnc/xstartup \
 && chmod +x /opt/scripts/start.sh \
 && chmod +x /root/Desktop/chrome.desktop /root/Desktop/terminal.desktop

EXPOSE 8080

CMD ["/bin/bash", "/opt/scripts/start.sh"]
