#!/bin/bash

latest_arm_none_eabi=gcc-arm-none-eabi-10.3-2021.10
latest_arm_none_eabi_url=https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2

sudo apt remove gcc-arm-none-eabi

mkdir temp
wget -O temp/${latest_arm_none_eabi}.tar.bz2 $latest_arm_none_eabi_url

# Explicitly create the destination directory.
sudo mkdir /usr/local/$latest_arm_none_eabi

# Make sure bzip2 exists so that tar doesn't crash!
sudo apt install -y bzip2

# Un-tar the files into a versioned arm-none-eabi folder in /usr/local.
# --strip-components 1 option removes the top level directory
sudo tar xjfv temp/${latest_arm_none_eabi}.tar.bz2 -C /usr/local/$latest_arm_none_eabi --strip-components 1

# Creat symlinks in /usr/bin
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-gdb /usr/bin/arm-none-eabi-gdb
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy
sudo ln -s /usr/local/${latest_arm_none_eabi}/bin/arm-none-eabi-objdump /usr/bin/arm-none-eabi-objdump
# Add other required commands here!

rm -rf temp
