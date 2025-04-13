# IoT Holter BLE Firmware

## A Modern Approach to Cardiac Monitoring

This repository contains the firmware source code for an IoT-based Holter monitoring device that utilizes Bluetooth Low Energy (BLE) technology. Designed specifically for ARM-based embedded hardware, this solution builds upon an established SDKs for reliable BLE development and medical data transmission.

## Repository Structure

- **`build.sh`**: Build script that handles firmware compilation
- **`Dockerfile`**: Configuration for consistent development environments
- **`HRZ_IoT_Holter_BLE/`**: Core source code for the Holter monitoring firmware
- **`nRF5_SDK_13.0.0_04a0bfd/`**: The BLE development SDK that powers our communication

## Technical Requirements

To work with this firmware, you'll need:

- ARM GCC Toolchain
- Docker (optional, for environment consistency)
- BLE development SDK version 13.0.0
- Compatible ARM-based hardware, such as nRF52 series devices

## Building the Firmware

To compile the firmware, simply run:

```bash
chmod +x build.sh
./build.sh
```

## Deploying to Hardware

After successful compilation, the firmware is deployed to the target hardware using appropriate flashing tools (e.g., J-Link).

## License

This project is licensed under the BSD 3-Clause License. Refer to the [LICENSE](LICENSE) file for details.