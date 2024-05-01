#!/bin/bash

# Check if wget is installed
if ! command -v wget &> /dev/null; then
    echo "wget is not installed. Installing wget..."
    brew install wget
fi

# Define the download URL
download_url="https://updates.cdn-apple.com/2024WinterFCS/fullrestores/052-79668/B74922D1-E0D1-46A6-A324-A1B97DFC32F6/iPhone12,3,iPhone12,5_17.4.1_21E237_Restore.ipsw"

# Define the destination directory where the IPSW will be downloaded
download_dir="$HOME/Downloads"

# Define the destination directory where the extracted IPSW will be stored
extracted_dir="$HOME/Desktop"

# Download the IPSW firmware file using wget
echo "Downloading IPSW firmware file..."
wget -O "$download_dir/firmware.ipsw" "$download_url"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "IPSW firmware file downloaded successfully."

    # Rename the downloaded file extension to .zip
    mv "$download_dir/firmware.ipsw" "$download_dir/firmware.zip"

    # Extract the IPSW firmware file
    echo "Extracting IPSW firmware file..."
    unzip "$download_dir/firmware.zip" -d "$extracted_dir"

    # Check if extraction was successful
    if [ $? -eq 0 ]; then
        echo "IPSW firmware file extracted successfully."
    else
        echo "Error: Failed to extract IPSW firmware file."
    fi
else
    echo "Error: Failed to download IPSW firmware file."
fi
