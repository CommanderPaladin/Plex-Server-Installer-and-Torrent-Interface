#!/bin/bash

#Variables
PLEX_DOWNLOAD_LINK="https://downloads.plex.tv/plex-media-server-new/1.32.5.7349-8f4248874/debian/plexmediaserver_1.32.5.7349-8f4248874_amd64.deb"
PLEX_FILE_NAME="plexmediaserver_1.32.5.7349-8f4248874_amd64.deb"

MEDIA_FOLDER_PATH="/var/opt/plexmediaserver/Movies"
#End Variables

sudo apt update -y && sudo apt upgrade -y
wget $PLEX_DOWNLOAD_LINK
sudo dpkg -i $PLEX_FILE_NAME || sudo apt-get install -f -y  # This will fix potential missing dependencies
# echo 'libssl1.0.0 libraries/restart-without-asking boolean true' | sudo debconf-set-selections
sudo apt install -y deluge deluged deluge-web 
deluge-web &  # Run in background

# Setup UFW firewall rules for Plex
sudo ufw allow 32400/tcp
sudo ufw reload

# Create the Movies folder and assign plex user permissions
sudo mkdir -p $MEDIA_FOLDER_PATH
sudo chown plex:plex $MEDIA_FOLDER_PATH
sudo chmod 755 $MEDIA_FOLDER_PATH

echo "All done and ready sir!"
