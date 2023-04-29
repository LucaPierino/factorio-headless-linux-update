#!/bin/bash
# Script for updating a headless installation of Factorio on Linux
# Author: Luca Pierino
# Repository: https://github.com/LucaPierino/factorio-headless-linux-update
# Version: 0.2

# Factorio installation directory
factorio_path=/home/factorio
echo "Factorio directory: $factorio_path"

# Check current Factorio version
if [ -f "$factorio_path/current_version" ]; then
    current_version=$(cat $factorio_path/current_version)
    echo "Current version of Factorio: $current_version"
else
    echo "Unable to determine current version of Factorio."
fi

# Retrieve available Factorio versions from the official website
HTML=$(curl -s https://www.factorio.com/download/archive/)
VERSIONS=$(echo "$HTML" | grep -Eo 'href="/download/archive/[0-9.]*"' | sed -E 's/href="\/download\/archive\/([0-9.]*)"/\1/g')

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

# Download the selected version
echo "Downloading Factorio version $version_number..."
wget https://www.factorio.com/get-download/$version_number/headless/linux64

# Extract and remove the archive file
echo "Extracting and removing archive file..."
mkdir $factorio_path/factorio-$version_number/
tar -xf linux64 --directory $factorio_path/factorio-$version_number/
rm linux64

# Copy the downloaded files to the installation directory
echo "Copying downloaded files..."
cp -R $factorio_path/factorio-$version_number/factorio/* $factorio_path

# Remove the temporary download folder
echo "Cleaning up temporary files..."
rm -rf $factorio_path/factorio-$version_number

# Update the current Factorio version
echo "Updating current version file..."
echo "$version_number" > $factorio_path/current_version

# Print completion message
echo "Update completed."
