# GNU arm toolchain requires a rather old version of Ubuntu to get its preferred libncurses5 and python3 version.
# GNU arm toolchain wants Ubuntu 18.04, but VSCode dev container only works with Ubuntu 20.04 or later.
FROM ubuntu:20.04
ADD setup_scripts /usr/setup
WORKDIR /usr/setup

# NOTE: don't run this before updating all git submodules, e.g. tinyusb for the pico SDK!

# Install sudo to allow the use of scripts meant for use in non-root environment.
RUN ["bash", "-c", "apt update && apt -y install sudo"]
RUN ["bash", "-c", "apt -y install wget"]
RUN ["bash", "-c", "chmod -R +x /usr/setup"]

# Set timezone to UTC and try turning off interactive prompts.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install ARM toolchain and dependencies.
RUN ["bash", "-c", "/usr/setup/setup_arm_none_eabi/install_arm_none_eabi.sh"]

# Install JLink toolchain and dependencies.
RUN ["bash", "-c", "/usr/setup/setup_jlink/install_jlink.sh"]

# Install Pico SDK
ADD pico-sdk /usr/local/pico-sdk
ENV PICO_SDK_PATH=/usr/local/pico-sdk
RUN ["bash", "-c", "/usr/setup/setup_pico_sdk/install_dependencies.sh"]

# Install GDB for local debugging
RUN ["bash", "-c", "apt -y install gdb"]

# Update cmake to the latest version.
RUN ["bash", "-c", "/usr/setup/update_cmake.bash"]
RUN ["bash", "-c", "/usr/setup/update_build_essentials.bash"]