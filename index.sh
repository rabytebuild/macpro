#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Error: Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# Install RustDesk using Homebrew
echo "Installing RustDesk..."
if brew install --cask rustdesk; then
    echo "RustDesk installed successfully."
else
    echo "Error: Unable to install RustDesk. Please check for errors during the installation."
    exit 1
fi

# Start RustDesk
echo "Starting RustDesk..."
open -a RustDesk

# Wait for RustDesk to start
sleep 5

# Set RustDesk ID and Password
echo "Setting RustDesk ID and Password..."
RUSTDESK_PID=$(pgrep -f RustDesk)

if [ -n "$RUSTDESK_PID" ]; then
    # Replace 'YOUR_ID_HERE' with your desired RustDesk ID
    RUSTDESK_ID="1 879 998 413"

    # Replace 'YOUR_PASSWORD_HERE' with your desired RustDesk password
    RUSTDESK_PASSWORD="root"

    osascript -e "tell application \"RustDesk\" to activate"
    osascript -e "tell application \"System Events\" to keystroke \"$RUSTDESK_ID\""
    osascript -e "tell application \"System Events\" to keystroke return"
    osascript -e "tell application \"System Events\" to keystroke \"$RUSTDESK_PASSWORD\""
    osascript -e "tell application \"System Events\" to keystroke return"

    echo "RustDesk ID and Password set successfully."
else
    echo "Error: RustDesk not running."
fi

echo "Installation and configuration completed."
