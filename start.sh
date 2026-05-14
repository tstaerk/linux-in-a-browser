#!/bin/bash
set -e

# Cleanup any old locks
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix
touch /root/.Xauthority

echo "=== STARTING Xvnc ==="
# Start Xvnc directly without password
Xvnc :1 \
  -auth /root/.Xauthority \
  -geometry $VNC_RESOLUTION \
  -depth $VNC_COL_DEPTH \
  -SecurityTypes None \
  -rfbport 5901 \
  -localhost no &

# Wait for Xvnc to start
for i in {1..10}; do
  if [ -S /tmp/.X11-unix/X1 ]; then
    echo "Xvnc is ready."
    break
  fi
  echo "Waiting for Xvnc... $i"
  sleep 1
done

echo "=== STARTING XFCE DESKTOP ==="
# Run xstartup script manually
/root/.vnc/xstartup &

# Set scaling to local and autoconnect to true by default for noVNC
cat <<EOF > /usr/share/novnc/index.html
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="refresh" content="0; url=vnc.html?scaling=local&autoconnect=true">
</head>
<body>
    <p>Redirecting to <a href="vnc.html?scaling=local&autoconnect=true">vnc.html?scaling=local&autoconnect=true</a>...</p>
</body>
</html>
EOF

echo "=== STARTING NOVNC PROXY ==="
# Run noVNC proxy in the foreground to keep the container alive
/usr/share/novnc/utils/novnc_proxy \
  --vnc localhost:5901 \
  --listen $PORT
