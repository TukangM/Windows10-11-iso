#/bin/bash
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
sudo apt update
sudo apt install --install-recommends winehq-stable

echo done...
echo installing noVNC and environtment

sudo apt -y install novnc python3-websockify python3-numpy tightvncserver tigervnc-tools websockify build-essential net-tools curl git software-properties-common
sudo apt -y install xfce4 gnome-software
echo '#!/bin/bash' > ~/.vnc/xstartup && echo 'xrdb $HOME/.Xresources' >> ~/.vnc/xstartup && echo 'startxfce4 &' >> ~/.vnc/xstartup

echo create vnc password
vncserver

echo start noVNC
