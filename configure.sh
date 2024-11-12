#!/bin/bash
# Disable Spotlight indexing
sudo mdutil -i off -a

# Create a new user account
USERNAME="rhsalisu"
REALNAME="Rabiu Hadi Salisu"
PASSWORD="root"
HOMEDIR="/Users/$USERNAME"

# Set up user account
sudo dscl . -create /Users/$USERNAME
sudo dscl . -create /Users/$USERNAME UserShell /bin/bash
sudo dscl . -create /Users/$USERNAME RealName "$REALNAME"
sudo dscl . -create /Users/$USERNAME UniqueID 1001
sudo dscl . -create /Users/$USERNAME PrimaryGroupID 80
sudo dscl . -create /Users/$USERNAME NFSHomeDirectory $HOMEDIR
echo "$PASSWORD" | sudo dscl . -passwd /Users/$USERNAME
sudo createhomedir -c -u $USERNAME > /dev/null

# Grant the new user permissions to root-owned directories needed for Brew and other installations
sudo chown -R $USERNAME:admin /usr/local
sudo chmod -R 755 /usr/local
sudo chown -R $USERNAME:admin /Library/Caches/Homebrew

# Enable VNC for all users with all privileges
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes 

# Set VNC password (using a known hash method for security)
echo "$PASSWORD" | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt

# Start VNC and reset changes
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

# Install and configure ngrok
sudo -u $USERNAME brew install --cask ngrok

# Configure and start ngrok with authorization token
ngrok authtoken 2jjqJ8mTlps4zo2wDNnREY5Xups_5BJT4C1zFSDQcyGQYqg1b
ngrok tcp 5900 &
ngrok tcp 22 &
