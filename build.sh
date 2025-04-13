#!/bin/bash

# Define the output directory on the host (now called _build)
BUILD_OUTPUT_DIR="$(pwd)/_build"

# Create the _build directory if it doesn't exist
if [ ! -d "$BUILD_OUTPUT_DIR" ]; then
  echo "Creating output directory at $BUILD_OUTPUT_DIR..."
  mkdir -p "$BUILD_OUTPUT_DIR"
fi

# Build the Docker image.
# The --platform linux/amd64 flag ensures compatibility on ARM-based systems.
echo "Building Docker image..."
docker build --platform linux/amd64 -t nrf52832-firmware .

# Run the container to compile the project and copy .bin and .hex files into the _build folder.
# The volume mount maps the host _build folder to /workspace/armgcc/_build inside the container.
echo "Building firmware and copying output files..."
docker run --platform linux/amd64 --rm \
  -v "$BUILD_OUTPUT_DIR":/workspace/armgcc/_build \
  nrf52832-firmware \
  sh -c "make && find /workspace/armgcc/_build -type f -not \( -name \"*.bin\" -o -name \"*.hex\" \) -delete"

echo "Build complete. Check the _build directory for the .bin and .hex files."

JLinkExe -device nrf52 -if swd -speed 4000 -autoconnect 1 -CommanderScript flash.jlink