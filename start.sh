#!/bin/bash
set -euo pipefail

vnc_pid=""
mate_pid=""

cleanup() {
  [ -z "$mate_pid" ] || kill "$mate_pid" 2>/dev/null || true
  [ -z "$vnc_pid" ] || kill "$vnc_pid" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

# Cleanup any old locks
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix
touch /root/.Xauthority

# MATE expects a system bus even though the container does not run systemd.
mkdir -p /run/dbus
if [ ! -S /run/dbus/system_bus_socket ]; then
  dbus-daemon --system --fork
fi

echo "=== STARTING Xvnc ==="
# Start Xvnc directly without password
Xvnc :1 \
  -desktop "CloudStation" \
  -auth /root/.Xauthority \
  -geometry $VNC_RESOLUTION \
  -depth $VNC_COL_DEPTH \
  -SecurityTypes None \
  -rfbport 5901 \
  -localhost yes &
vnc_pid=$!

# Wait for Xvnc to start
for i in {1..30}; do
  if ! kill -0 "$vnc_pid" 2>/dev/null; then
    echo "Xvnc exited before it became ready." >&2
    wait "$vnc_pid"
  fi
  if [ -S /tmp/.X11-unix/X1 ]; then
    echo "Xvnc is ready."
    break
  fi
  echo "Waiting for Xvnc... $i"
  sleep 1
done

if [ ! -S /tmp/.X11-unix/X1 ]; then
  echo "Timed out waiting for Xvnc." >&2
  exit 1
fi

echo "=== STARTING MATE DESKTOP ==="
# MATE 1.26 declares a dock as required but leaves its provider empty.
gsettings set org.mate.session required-components-list \
  "['windowmanager', 'panel', 'filemanager']"

gsettings set org.mate.background draw-background true
gsettings set org.mate.background picture-filename "/usr/share/backgrounds/cloudstation-wallpaper.png"
gsettings set org.mate.background picture-options "zoom"
gsettings set org.mate.background color-shading-type "solid"
gsettings set org.mate.background primary-color "#000000"

gsettings set org.mate.interface icon-theme 'Papirus'
gsettings set org.mate.interface gtk-theme 'Arc'

gsettings set org.mate.Marco.general compositing-manager false
# Run xstartup script manually
/root/.vnc/xstartup &
mate_pid=$!

sleep 2
if ! kill -0 "$mate_pid" 2>/dev/null; then
  echo "MATE exited during startup." >&2
  wait "$mate_pid"
fi

# Set scaling to local and autoconnect to true by default for noVNC
cat <<EOF > /usr/share/novnc/index.html
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="refresh" content="0; url=vnc.html?resize=remote&autoconnect=true">
</head>
<body>
    <p>Redirecting to <a href="vnc.html?resize=scale&autoconnect=true">vnc.html?resize=remote&autoconnect=true</a>...</p>
</body>
</html>
EOF

echo "=== STARTING NOVNC PROXY ==="
# Run noVNC proxy in the foreground to keep the container alive
exec /usr/share/novnc/utils/novnc_proxy \
  --vnc localhost:5901 \
  --listen "$PORT"
