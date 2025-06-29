#!/bin/bash

# Script to install latest GCC, G++, and make on Ubuntu 20.04
# Run with: sudo ./install-latest-gcc.sh

set -e  # Exit on any error

echo "Installing latest GCC, G++, and make on Ubuntu 20.04..."

# Update package list
echo "Updating package list..."
apt update

# Add the Ubuntu Toolchain PPA for latest GCC versions
echo "Adding Ubuntu Toolchain PPA..."
apt install -y software-properties-common
add-apt-repository -y ppa:ubuntu-toolchain-r/test
apt update

# Install the latest GCC and G++ (GCC 13 is the latest stable as of 2025)
echo "Installing GCC-13 and G++-13..."
apt install -y gcc-13 g++-13

# Install build-essential which includes make and other build tools
echo "Installing build-essential (includes make)..."
apt install -y build-essential

# Set up alternatives to make GCC-13 and G++-13 the default
echo "Setting up alternatives for GCC and G++..."

# Remove any existing alternatives
update-alternatives --remove-all gcc 2>/dev/null || true
update-alternatives --remove-all g++ 2>/dev/null || true

# Install alternatives with high priority for GCC-13
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 100
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 100

# Also install alternatives for older versions if they exist
if [ -f /usr/bin/gcc-11 ]; then
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 90
fi

if [ -f /usr/bin/g++-11 ]; then
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 90
fi

if [ -f /usr/bin/gcc-9 ]; then
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 80
fi

if [ -f /usr/bin/g++-9 ]; then
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 80
fi

# Set GCC-13 as the automatic choice
update-alternatives --auto gcc
update-alternatives --auto g++

# Verify installations
echo ""
echo "Installation complete! Verifying versions:"
echo "GCC version:"
gcc --version | head -1

echo ""
echo "G++ version:"
g++ --version | head -1

echo ""
echo "Make version:"
make --version | head -1

echo ""
echo "All tools have been installed and set as defaults."
echo "You can change compiler versions using: sudo update-alternatives --config gcc"
echo "Or: sudo update-alternatives --config g++"