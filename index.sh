#!/bin/bash

# Install RustDesk
echo "Installing RustDesk..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustdesk.com | sh

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
    RUSTDESK_ID="459 912 527"

    # Replace 'YOUR_PASSWORD_HERE' with your desired RustDesk password
    RUSTDESK_PASSWORD="Rabiu2004@"

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
