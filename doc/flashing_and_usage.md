# Flashing and Usage

This document describes how to flash the generated SD card image to a microSD card and how to use the custom Linux OS.

## Flashing the SD Card Image

### Prerequisites

*   A microSD card (at least 2GB).
*   A microSD card reader/writer.
*   A tool for writing images to SD cards, such as `dd` or Balena Etcher.

### Flashing with `dd`

1.  **Identify your microSD card device:**

    Use the `lsblk` or `dmesg` command to identify the device name of your microSD card (e.g., `/dev/sdX`).

    **Warning:** Be very careful to select the correct device, as this process will overwrite all data on the selected device.

2.  **Unmount the microSD card:**

    If any partitions on the microSD card are automatically mounted, unmount them before writing the image.

    ```bash
    umount /dev/sdX*
    ```

3.  **Write the image to the microSD card:**

    Use the `dd` command to write the `sdcard.img` file to your microSD card.

    ```bash
    sudo dd if=buildroot-2025.02.9/output/images/sdcard.img of=/dev/sdX bs=4M conv=fsync
    ```

    Replace `/dev/sdX` with the correct device name for your microSD card.

### Flashing with Balena Etcher

1.  Download and install Balena Etcher from [https://www.balena.io/etcher/](https://www.balena.io/etcher/).
2.  Open Balena Etcher.
3.  Select the `sdcard.img` file.
4.  Select your microSD card device.
5.  Click "Flash!".

## Usage

1.  **Insert the microSD card:**

    Insert the flashed microSD card into the microSD card slot on your Radxa Zero 3E.

2.  **Connect peripherals:**

    *   Connect a display via the mini-HDMI port.
    *   Connect a keyboard via a USB-C OTG adapter.
    *   Connect power via the USB-C power port.

3.  **Boot the OS:**

    The Radxa Zero 3E will automatically boot from the microSD card. You will see the custom boot banner and then a login prompt.

4.  **Login:**

    The default username is `root` and the password is `root`.

5.  **Networking:**

    The system is configured to obtain an IP address via DHCP on the Ethernet port. You can also configure WiFi using the appropriate Linux commands.

6.  **SSH:**

    An SSH server (Dropbear) is running by default. You can connect to the board via SSH using the IP address assigned to the Ethernet or WiFi interface.