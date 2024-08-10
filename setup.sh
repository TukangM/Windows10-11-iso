#!/bin/bash
echo setup for uupdump and vnc for upload. !! only tukangm do this on gitpod :)

# Install dependencies
sudo apt update
sudo apt-get install cabextract wimtools chntpw genisoimage aria2 -y
sudo apt install xfce4 tightvncserver novnc python3-websockify python3-numpy -y

# Check and add configuration if not already present
if ! grep -q "xrdb \$HOME/.Xresources" ~/.vnc/xstartup; then
    echo "Adding 'xrdb \$HOME/.Xresources' to ~/.vnc/xstartup"
    echo "xrdb \$HOME/.Xresources" >> ~/.vnc/xstartup
fi

if ! grep -q "startxfce4 &" ~/.vnc/xstartup; then
    echo "Adding 'startxfce4 &' to ~/.vnc/xstartup"
    echo "startxfce4 &" >> ~/.vnc/xstartup
fi

# Generate SSL certificate for noVNC
# openssl req -x509 -nodes -newkey rsa:3072 -keyout novnc.pem -out novnc.pem -days 3650

# Start vncserver
vncserver
# Start websockify
# websockify -D --web=/usr/share/novnc/ --cert=/home/ubuntu/novnc.pem 6080 localhost:5901

# Echo
echo before connect. must change password to connect vnc

#internet install

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update && sudo apt-get install google-chrome-stable


echo done
