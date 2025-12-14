# Building Firmware

This document provides a high-level overview of the firmware build process and how to customize it.

## Build Process Overview

The `scripts/build.sh` script orchestrates the entire firmware build process. Here's a breakdown of the steps:

1.  **Configuration:** The script starts by ensuring the Buildroot configuration is up-to-date by running `make olddefconfig`.

2.  **Build:** It then invokes the main Buildroot `make` process, which performs the following:
    *   **Toolchain:** Builds the cross-compilation toolchain.
    *   **Host Tools:** Builds various host tools required for the build process.
    *   **Target Packages:** Builds all the target packages selected in the configuration, including the kernel, bootloader, and root filesystem components.
    *   **Filesystem Image:** Creates the root filesystem image (`rootfs.ext4`).
    *   **SD Card Image:** Creates the final SD card image (`sdcard.img`) by combining the bootloader, kernel, and root filesystem using `genimage`.

## Customization

### Buildroot Configuration

The main Buildroot configuration is stored in the `.config` file in the `buildroot-2025.02.9` directory. You can modify this file directly, but it's recommended to use the `make menuconfig` interface:

```bash
cd buildroot-2025.02.9
make menuconfig
```

This will open a menu-driven interface that allows you to customize all aspects of the build, including:

*   Target architecture
*   Toolchain settings
*   Kernel and bootloader versions
*   Target packages
*   Filesystem image type and size

### Kernel Configuration

To customize the Linux kernel configuration, run the following command:

```bash
cd buildroot-2025.02.9
make linux-menuconfig
```

This will open the kernel's configuration interface. It's recommended to save your changes to a configuration fragment file and add it to the `BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES` option in the Buildroot `.config` file.

### U-Boot Configuration

To customize the U-Boot bootloader configuration, run the following command:

```bash
cd buildroot-2025.02.9
make uboot-menuconfig
```

This will open the U-Boot configuration interface. Similar to the kernel, it's recommended to save your changes to a configuration fragment file and add it to the `BR2_TARGET_UBOOT_CONFIG_FRAGMENT_FILES` option in the Buildroot `.config` file.

## Build Configurations

The project supports two main build configurations: **Debug (Development)** and **Release (Production)**. The primary difference is the inclusion of the `dev-tools-bundle` package.

### 1. Debug Build (Development)

This configuration includes the `dev-tools-bundle`, which provides tools like GDB, Strace, Valgrind, Perf, Htop, and LTTng. This is the default configuration.

**To enable Debug mode:**
Ensure `BR2_PACKAGE_DEV_TOOLS_BUNDLE=y` is present in `buildroot/configs/radxa_zero3e_defconfig`.

```makefile
BR2_PACKAGE_DEV_TOOLS_BUNDLE=y
```

### 2. Release Build (Production)

This configuration excludes the development tools to produce a smaller, cleaner image suitable for deployment.

**To enable Release mode:**
Comment out or remove the `BR2_PACKAGE_DEV_TOOLS_BUNDLE` line in `buildroot/configs/radxa_zero3e_defconfig`.

```makefile
# BR2_PACKAGE_DEV_TOOLS_BUNDLE is not set
```

### Applying Changes

After changing the configuration, perform a clean build to ensure all changes take effect:

```bash
cd buildroot
make clean
make radxa_zero3e_defconfig
cd ..
./scripts/build.sh
```

## Enabling Development Tools (Legacy Method)

A suite of development and debugging tools can be easily enabled or disabled using the `dev-tools-bundle` package. This bundle includes common tools such as GDB (debugger and server), Strace, Valgrind, Perf (Linux Tools), Htop, and Memstat.

**Using `make menuconfig`:**

1.  Navigate to the Buildroot directory:
    ```bash
    cd buildroot
    ```
2.  Launch the menu configuration:
    ```bash
    make menuconfig
    ```
3.  Go to "Target packages" -> "Debugging, profiling and benchmark".
4.  Select `dev-tools-bundle` to enable all included development tools.
5.  Ensure "Toolchain" -> "Enable C++ support" is also selected, as it is a dependency for some debugging tools like GDB.
6.  Save your configuration and exit.

**Manually editing the defconfig:**

To enable the development tools, add the following lines to `buildroot/configs/radxa_zero3e_defconfig`:

```
BR2_TOOLCHAIN_BUILDROOT_CXX=y
BR2_PACKAGE_DEV_TOOLS_BUNDLE=y
```

After enabling or disabling the development tools, remember to clean and rebuild your firmware:

```bash
cd buildroot
make clean
make radxa_zero3e_defconfig # to apply the updated configuration
make -j$(nproc)
```
