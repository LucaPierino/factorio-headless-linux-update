#!/bin/bash
# Script for updating a headless installation of Factorio on Linux
# Author: Luca Pierino
# Repository: https://github.com/LucaPierino/factorio-headless-linux-update
# Version: 0.3

# Factorio installation directory (use absolute path)
factorio_path="/path/to/your/factorio"
echo "Factorio directory: $factorio_path"

# Check current Factorio version
if [ -f "$factorio_path/current_version" ]; then
    current_version=$(cat $factorio_path/current_version)
    echo "Current version of Factorio: $current_version"
else
    echo "Unable to determine current version of Factorio."
    echo "Installing a new version."
fi

# Retrieve available Factorio versions from the official website
HTML=$(curl -s https://www.factorio.com/download/archive/)
VERSIONS=$(echo "$HTML" | grep -Eo 'href="/download/archive/[0-9.]*"' | sed -E 's/href="\/download\/archive\/([0-9.]*)"/\1/g')

# Check if we successfully retrieved versions
if [ -z "$VERSIONS" ]; then
    echo "Failed to retrieve available versions. Exiting."
    exit 1
fi

# Print available versions
echo "Available versions of Factorio:"
echo "$VERSIONS"

# Ask the user for the version to install
echo "Enter the Factorio version number to install or type \"list\" to show the available versions:"
read version_number

if [ "$version_number" == "list" ]; then
    echo "Available versions of Factorio:"
    echo "$VERSIONS"
    exit 0
fi

# Validate the selected version
if ! echo "$VERSIONS" | grep -q "^$version_number$"; then
    echo "Invalid version selected. Exiting."
    exit 1
fi

# Download the selected version
echo "Downloading Factorio version $version_number..."
archive_file="factorio_${version_number}_linux64.tar.xz"
wget -O "$archive_file" "https://www.factorio.com/get-download/$version_number/headless/linux64"

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download Factorio. Exiting."
    rm -f "$archive_file"
    exit 1
fi

# Extract and remove the archive file
echo "Extracting and removing archive file..."
tar -xf "$archive_file" --directory "$factorio_path"
if [ $? -ne 0 ]; then
    echo "Failed to extract Factorio. Exiting."
    rm -f "$archive_file"
    exit 1
fi

# Cleanup
rm -f "$archive_file"

# Update the current Factorio version
echo "Updating current version file..."
echo "$version_number" > "$factorio_path/current_version"

# Print completion message
echo "Update completed successfully."
