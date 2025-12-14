# Adding Kernel Modules

This document explains how to add custom kernel modules to the Buildroot build.

## Building Out-of-Tree Kernel Modules

Buildroot provides a convenient infrastructure for building out-of-tree kernel modules.

1.  **Create a package directory:**

    Create a new directory for your kernel module package in the `package` directory of the Buildroot source tree. For example, `package/my-kernel-module`.

2.  **Create `Config.in`:**

    Create a `Config.in` file in your package directory.

    ```
    config BR2_PACKAGE_MY_KERNEL_MODULE
        bool "my-kernel-module"
        help
          This is my custom kernel module.
    ```

3.  **Create `<package-name>.mk`:**

    Create a makefile for your package, named `<package-name>.mk`. This file uses the `kernel-module` infrastructure.

    ```makefile
    ################################################################################
    #
    # my-kernel-module
    #
    ################################################################################

    MY_KERNEL_MODULE_VERSION = 1.0
    MY_KERNEL_MODULE_SOURCE = my-kernel-module-$(MY_KERNEL_MODULE_VERSION).tar.gz
    MY_KERNEL_MODULE_SITE = http://www.example.com/sources

    $(eval $(kernel-module))
    ```

4.  **Add to `package/Config.in`:**

    Add a `source` line to `package/Config.in` to include your package's `Config.in` file.

    ```
    source "package/my_kernel_module/Config.in"
    ```

5.  **Enable the package in the configuration:**

    Run `make menuconfig` and enable your new package in the "Target packages" -> "Kernel modules" menu.

## In-Tree Kernel Modules

If you have patched the kernel source to include your module, you can enable it through the kernel configuration.

1.  **Run `make linux-menuconfig`:**

    This will open the kernel's configuration interface.

2.  **Enable your module:**

    Find your module in the appropriate menu (e.g., "Device Drivers") and enable it.

3.  **Save the kernel configuration:**

    Save your changes to the kernel configuration. It's recommended to save the configuration to a fragment file in `board/radxa/radxa_zero3e/` and add it to `BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES` in the `.config` file.