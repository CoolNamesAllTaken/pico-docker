#!/bin/bash

jlink_linux_url=https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb


mkdir temp

wget -O temp/jlink_linux.deb --post-data 'accept_license_agreement=accepted&non_emb_ctr=confirmed&submit=Download+software' $jlink_linux_url

# Remove the post-install script from the jlink package to avoid encountering an issue with udevadm not existing on the Docker container.
# Fix provided here: https://forum.segger.com/index.php/Thread/8953-SOLVED-J-Link-Linux-installer-fails-for-Docker-containers-Error-Failed-to-update/
dpkg --unpack temp/jlink_linux.deb
rm -f /var/lib/dpkg/info/jlink.postinst
dpkg --configure jlink
apt install -yf
# Note that dpkg installs stuff into opt/SEGGER.

rm -rf temp
