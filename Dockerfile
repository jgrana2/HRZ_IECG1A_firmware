FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    libusb-1.0-0-dev \
    udev \
    libxrender1 \
    libxcb-render0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-randr0 \
    libxcb-xfixes0 \
    libxcb-sync1 \
    libxcb-shm0 \
    libxcb-icccm4 \
    libxcb-keysyms1 \
    libxcb-image0 \
    libxkbcommon0 \
    libxkbcommon-x11-0 \
    libx11-xcb1 \
    libsm6 \
    libice6 \
    libglib2.0-0

# Install ARM GCC 6-2017-q2-update
RUN wget -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/6-2017q2/gcc-arm-none-eabi-6-2017-q2-update-linux.tar.bz2 && \
    tar -xjf gcc-arm-none-eabi-6-2017-q2-update-linux.tar.bz2 -C /opt && \
    rm gcc-arm-none-eabi-6-2017-q2-update-linux.tar.bz2

# Install nRF Command Line Tools
RUN wget https://nsscprodmedia.blob.core.windows.net/prod/software-and-other-downloads/desktop-software/nrf-command-line-tools/sw/versions-10-x-x/10-24-2/nrf-command-line-tools-10.24.2_linux-amd64.tar.gz
RUN tar -xzf nrf-command-line-tools-10.24.2_linux-amd64.tar.gz -C /opt && \
    rm nrf-command-line-tools-10.24.2_linux-amd64.tar.gz && \
    cp -r /opt/nrf-command-line-tools/* /usr/local/ && \
    chmod +x /usr/local/bin/nrfjprog

# Install JLink
RUN wget --post-data="accept_license_agreement=accepted&submit=Download+software" \
    --header="Content-Type: application/x-www-form-urlencoded" \
    https://www.segger.com/downloads/jlink/JLink_Linux_V788c_x86_64.deb -O jlink.deb
RUN dpkg --unpack jlink.deb && \
    rm jlink.deb && \
    cp /opt/SEGGER/JLink/libjlinkarm.so* /usr/lib/x86_64-linux-gnu/

# Set environment variables
ENV PATH="/opt/gcc-arm-none-eabi-6-2017-q2-update/bin:$PATH"
ENV NRF5_SDK_ROOT="/opt/nRF5_SDK_13.0.0"

# Copy SDK and project
COPY nRF5_SDK_13.0.0_04a0bfd $NRF5_SDK_ROOT
COPY HRZ_IoT_Holter_BLE /workspace

WORKDIR /workspace/armgcc
