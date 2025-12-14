# Radxa Zero 3E: Custom Embedded Linux Firmware Build System

Welcome! This repository provides a complete, "batteries-included" environment for building a custom, highly optimized Linux **firmware** specifically for the **Radxa Zero 3E** (Rockchip RK3566) single-board computer.

This is a dedicated **build system** tailored for **embedded applications**, focusing on minimal footprint and efficient resource usage. We've leveraged **Buildroot 2025.02** to set up a modern kernel (v6.18.1) and toolchain, freeing you to concentrate on your embedded application logic without wrestling with complex cross-compilation setups. This system is also pre-configured with various debug and development tools to aid your embedded journey.

It comes pre-configured with robust support for **Python, C, C++, Go, and Rust**, alongside handy helper scripts to make building and flashing your custom firmware a seamless experience.

## 🌟 What's Inside?

*   **Target Hardware:** Radxa Zero 3E (Cortex-A55, AArch64).
*   **Modern Core:** Produces firmware running Linux 6.18.1 and U-Boot 2025.10.
*   **Developer Friendly:** Build tools configured for Python 3, C/C++, Go, and Rust development.
*   **Smart Partitioning:**
    *   **Rootfs:** 500MB Ext4 (optimized for embedded use).
    *   **Data:** 64MB Ext4 partition that **auto-mounts** at `/data`.
*   **Streamlined Workflow:** Includes scripts to handle the boring stuff: setting up dependencies, cleaning builds, and flashing SD cards safely.
*   **Fun Extras:** `toilet` and `figlet` are pre-installed in the generated firmware (because even embedded systems need cool banners).

## 🚀 Getting Started

You'll need a Linux machine (Ubuntu/Debian recommended) to use this build system.

### 1. Prerequisite Setup
First, clone this repo and run the setup script. It grabs all the necessary packages (`build-essential`, `python3`, etc.) so you don't have to hunt them down.

```bash
git clone https://github.com/yourusername/radxa-zero3e-buildroot.git
cd radxa-zero3e-buildroot
./scripts/setup.sh
```

### 2. Build the System
Now, compile everything. This builds the toolchain, kernel, and the entire root filesystem.
*Heads up: This will take a while (30+ mins) depending on your CPU.*

```bash
./scripts/build.sh
```
When it's done, your shiny new image will be waiting in `buildroot/output/images/sdcard.img`.

### 3. Flash It
**⚠️ Warning:** This operation destroys all data on the target device.

Plug in your SD card and find its device name (like `/dev/sdb`) using `lsblk`. Then use our helper script:

```bash
sudo ./scripts/flash.sh /dev/sdX
```
*(Just replace `/dev/sdX` with your actual device path)*

### 4. Boot Up
Pop the SD card into your Radxa Zero 3E, power it on, and log in:
*   **User:** `root`
*   **Password:** `root`

## 🛠️ Handy Scripts

We've included a few scripts in the `scripts/` directory to save you time:

*   **`./scripts/setup.sh`**: One-time setup for host dependencies.
*   **`./scripts/build.sh`**: The main build command. Re-run this after making changes.
*   **`./scripts/clean.sh`**: Wipes build artifacts. Pass `dist` (e.g., `./scripts/clean.sh dist`) for a full factory reset.
*   **`./scripts/flash.sh`**: A safer wrapper around `dd` to write your image.

## 📖 Documentation

Dive deeper into specific topics with our detailed guides in the `doc/` directory:

*   [**Build System Setup**](doc/build_system_setup.md): How to get your host environment ready.
*   [**Building the Firmware**](doc/building_firmware.md): A comprehensive guide to the compilation process.
*   [**Flashing and Usage**](doc/flashing_and_usage.md): Detailed steps for deploying and using the firmware.
*   [**Adding Userspace Programs**](doc/adding_userspace_programs.md): Learn how to integrate your own applications.
*   [**Managing Users and Groups**](doc/managing_users.md): How to add users and set passwords.
*   **Language-Specific Guides:**
    *   [Adding C Programs](doc/adding_c_programs.md)
    *   [Adding C++ Programs](doc/adding_cpp_programs.md)
    *   [Adding Go Programs](doc/adding_go_programs.md)
    *   [Adding Rust Programs](doc/adding_rust_programs.md)
    *   [Adding Python Programs](doc/adding_python_programs.md)
*   [**Adding Kernel Modules**](doc/adding_kernel_modules.md): Extend the kernel with your custom modules.
*   [**Adding New Partitions**](doc/adding_new_partitions.md): Customize the storage layout on your SD card.

## 🎨 Customizing

Want to add packages or tweak the kernel?

1.  Jump into the buildroot dir: `cd buildroot`
2.  Open the menu: `make menuconfig`
3.  **Crucial:** When you're done, save your changes back to the repo:
    ```bash
    make savedefconfig
    ```

## License

This project is open source under the **GPLv2** license. Feel free to fork, modify, and share!