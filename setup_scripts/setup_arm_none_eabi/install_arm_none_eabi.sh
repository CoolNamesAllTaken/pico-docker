#!/bin/bash

latest_arm_none_eabi=gcc-arm-none-eabi-13.2
latest_arm_none_eabi_url="https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz?rev=e434b9ea4afc4ed7998329566b764309&hash=CA590209F5774EE1C96E6450E14A3E26"

# Install dependencies.
sudo apt -y install libncurses5
sudo apt -y install python3
sudo apt install -y build-essential

# Remove existing (probably outdated) install.
sudo apt remove gcc-arm-none-eabi

mkdir temp
wget -O temp/${latest_arm_none_eabi}.tar.xz $latest_arm_none_eabi_url

# Explicitly create the destination directory.
sudo mkdir /usr/local/$latest_arm_none_eabi

# Un-tar the files into a versioned arm-none-eabi folder in /usr/local.
# --strip-components 1 option removes the top level directory
sudo tar xfv temp/${latest_arm_none_eabi}.tar.xz -C /usr/local/$latest_arm_none_eabi --strip-components 1

# Creat symlinks in /usr/bin
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-gdb /usr/bin/arm-none-eabi-gdb
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-objdump /usr/bin/arm-none-eabi-objdump
# Add other required commands here!

rm -rf temp
