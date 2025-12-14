#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Updating package lists..."
sudo apt update

echo "Installing essential Buildroot dependencies..."
sudo apt install -y \
    build-essential \
    libncurses-dev \
    unzip \
    bc \
    bzip2 \
    libelf-dev \
    libssl-dev \
    dialog \
    which \
    sed \
    git \
    wget \
    cpio \
    python3 \
    locales

echo "Buildroot dependencies installed successfully."

# Configure locales to prevent Buildroot build errors
echo "Configuring locales to prevent Buildroot build errors..."
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8

echo "Locales configured."

echo "Setup script completed."
