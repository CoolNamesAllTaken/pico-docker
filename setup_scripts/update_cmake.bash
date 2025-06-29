#!/bin/bash

# CMake Installation Script for Ubuntu 20.04
# This script installs the latest version of CMake

set -e  # Exit on any error

echo "Installing the latest CMake on Ubuntu 20.04..."

# Update package list
echo "Updating package list..."
sudo apt update

# Remove any existing CMake installation
echo "Removing existing CMake installation..."
sudo apt remove --purge cmake -y 2>/dev/null || true

# Install dependencies
echo "Installing dependencies..."
sudo apt install -y wget software-properties-common build-essential

# Add Kitware's APT repository (official CMake maintainers)
echo "Adding Kitware APT repository..."
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null

# Add the repository
sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ focal main" -y

# Update package list again
sudo apt update

# Install the latest CMake
echo "Installing latest CMake..."
sudo apt install -y cmake

# Verify installation
echo "Verifying CMake installation..."
cmake_version=$(cmake --version | head -n1)
echo "Successfully installed: $cmake_version"

echo "CMake installation completed!"
echo "You can verify the installation by running: cmake --version"