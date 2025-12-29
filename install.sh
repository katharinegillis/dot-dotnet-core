#!/usr/bin/env bash

PKG_PATH=$2

# Get Ubuntu version
declare repo_version=$(if command -v lsb_release &> /dev/null; then lsb_release -r -s; else grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"'; fi)

# Download Microsoft signing key and repository
wget https://packages.microsoft.com/config/ubuntu/$repo_version/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

# Install Microsoft signing key and repository
sudo dpkg -i packages-microsoft-prod.deb

# Clean up
rm packages-microsoft-prod.deb

# Update packages
sudo apt update

# Set Microsoft repo as preferred
sudo cp "$PKG_PATH/config/dotnet.pref" /etc/apt/preferences.d/dotnet.pref

# Install .NET Core SDK
sudo apt install dotnet-sdk-10.0 -y
sudo apt-get -y autoremove

# Install EF tool
dotnet tool install --global dotnet-ef --version 10.*
