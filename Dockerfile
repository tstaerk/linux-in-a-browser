FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV VNC_RESOLUTION=1280x800
ENV VNC_COL_DEPTH=24
ENV PORT=8080

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-session \
    xterm \
    xfce4-goodies \
    tigervnc-standalone-server \
    novnc \
    websockify \
    dbus-x11 \
    x11-xserver-utils \
    xauth \
    xfonts-base \
    xfonts-75dpi \
    xfonts-100dpi \
    wget \
    iputils-ping \
    gnupg \
    feh \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Wrap Chrome to run as root
RUN echo '#!/bin/bash\n/usr/bin/google-chrome-stable --no-sandbox "$@"' > /usr/local/bin/google-chrome \
    && chmod +x /usr/local/bin/google-chrome

RUN mkdir -p /root/.vnc
RUN mkdir -p /opt/scripts
RUN mkdir -p /root/.config/xfce4/xfconf/xfce-perchannel-xml

COPY xstartup /root/.vnc/xstartup
COPY start.sh /opt/scripts/start.sh
COPY prieros.jpg /usr/share/backgrounds/prieros.jpg
COPY xfce4-desktop.xml /root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

RUN chmod +x /root/.vnc/xstartup
RUN chmod +x /opt/scripts/start.sh

EXPOSE 8080

CMD ["/bin/bash", "/opt/scripts/start.sh"]
