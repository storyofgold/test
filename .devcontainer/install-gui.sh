#!/bin/bash

# Matikan interaksi user saat instalasi
export DEBIAN_FRONTEND=noninteractive

echo "--- Updating package list ---"
sudo apt-get update

echo "--- Installing MATE Desktop, VNC Server, and Firefox ---"
# Kita install 'mate-core' agar lebih ringan, tanpa aplikasi office dll.
# 'tightvncserver' adalah server VNC-nya.
# 'firefox-esr' sebagai browser.
sudo apt-get install -y mate-core tightvncserver firefox-esr

echo "--- Cleaning up apt cache ---"
sudo apt-get clean

echo "--- Setup VNC startup file ---"
# Buat direktori .vnc jika belum ada
mkdir -p ~/.vnc

# Buat file xstartup agar MATE bisa dijalankan oleh VNC
# File ini akan otomatis dieksekusi saat VNC server start
cat <<EOT > ~/.vnc/xstartup
#!/bin/sh
export XDG_CURRENT_DESKTOP="MATE"
export XDG_SESSION_TYPE="x11"
exec mate-session
EOT

# Berikan izin eksekusi pada file startup
chmod +x ~/.vnc/xstartup

echo "--- GUI Setup Complete ---"
echo "To start the VNC server, run the following command in the terminal:"
echo "tightvncserver -geometry 1920x1080"
