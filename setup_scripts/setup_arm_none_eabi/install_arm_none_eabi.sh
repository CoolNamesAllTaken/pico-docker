#!/bin/bash

latest_arm_none_eabi_version=14.2.rel1
latest_arm_none_eabi=gcc-arm-none-eabi-${latest_arm_none_eabi_version}
x86_url=https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
arm_url=https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-aarch64-arm-none-eabi.tar.xz

# Determine the appropriate download URL based on host architecture
if [ "$(uname -m)" = "aarch64" ]; then
    latest_arm_none_eabi_url=$arm_url
else
    latest_arm_none_eabi_url=$x86_url
fi

# Install dependencies.
# sudo apt -y install libncurses5
sudo apt-get -y update
sudo apt-get -y install libncurses5

# Janky way to do libncurses5 installation, doesn't work well.
# Requires libncurses5, which is not installed by default. Symlink to libncurses6.
# lib_platform=$(uname -m)-linux-gnu
# sudo ln -s /usr/lib/$lib_platform/libncurses.so.6 /usr/lib/$lib_platform/libncurses.so.5
# sudo ln -s /usr/lib/$lib_platform/libncursesw.so.6 /usr/lib/$lib_platform/libncursesw.so.5
# sudo ln -s /usr/lib/$lib_platform/libtinfo.so.6 /usr/lib/$lib_platform/libtinfo.so.5

sudo apt -y install python3
sudo apt -y install python3-pip

# arm-none-eabi-gdb requires Python 3.8 for some godforsaken reason.
sudo apt -y install software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt install -y python3.8

sudo apt install -y build-essential

# Remove existing (probably outdated) install.
sudo apt remove -y gcc-arm-none-eabi

mkdir temp
wget -O temp/${latest_arm_none_eabi}.tar.xz $latest_arm_none_eabi_url

# Explicitly create the destination directory.
sudo mkdir /usr/local/$latest_arm_none_eabi

# Un-tar the files into a versioned arm-none-eabi folder in /usr/local.
# --strip-components 1 option removes the top level directory
sudo tar xfv temp/${latest_arm_none_eabi}.tar.xz -C /usr/local/$latest_arm_none_eabi --strip-components 1

# Create symlinks in /usr/bin
for file in /usr/local/${latest_arm_none_eabi}/bin/*; do
    # Get just the filename (without the directory path)
    filename=$(basename "$file")
    # Check if it's a file (not a directory)
    if [ -f "$file" ]; then
        
        # Create the symlink in /usr/bin
        sudo ln -s "$file" "/usr/bin/$filename"
        echo "Created symlink for $filename."
    else
        echo "$filename is not a valid file."
    fi
done

rm -rf temp
