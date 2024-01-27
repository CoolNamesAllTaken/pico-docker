#!/bin/bash

jlink_linux_url=https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb


mkdir temp

wget -O temp/jlink_linux.deb --post-data 'accept_license_agreement=accepted&non_emb_ctr=confirmed&submit=Download+software' $jlink_linux_url

# Create a fake udevadm so the postinstall doesn't fail (Docker image doesn't have udev).
# Fix provided here: https://forum.segger.com/index.php/Thread/8953-SOLVED-J-Link-Linux-installer-fails-for-Docker-containers-Error-Failed-to-update/
RUN echo '#!/bin/bash\necho not running udevadm "$@"' > /usr/bin/udevadm && chmod +x /usr/bin/udevadm \
    && [...] && dpkg -i temp/jlink_linux.deb

# Note that dpkg installs stuff into opt/SEGGER.

rm -rf temp
