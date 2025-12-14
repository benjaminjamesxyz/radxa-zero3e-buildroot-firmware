# Adding Userspace Programs

This document explains how to add custom userspace programs to the Buildroot build.

## Using the Root Filesystem Overlay

The easiest way to add custom files and scripts to the root filesystem is by using the root filesystem overlay.

1.  **Locate the overlay directory:**

    The root filesystem overlay is located at `board/radxa/radxa_zero3e/rootfs_overlay`.

2.  **Add your files:**

    Any files and directories you place in this overlay directory will be copied to the root filesystem of the target image, preserving the directory structure.

    For example, to add a custom script to `/usr/bin`, you would create the file `board/radxa/radxa_zero3e/rootfs_overlay/usr/bin/my_script.sh`.

## Adding a Custom Buildroot Package

For more complex programs that require compilation, it is recommended to create a custom Buildroot package.

1.  **Create a package directory:**

    Create a new directory for your package in the `package` directory of the Buildroot source tree. For example, `package/my_package`.

2.  **Create `Config.in`:**

    Create a `Config.in` file in your package directory. This file defines the menu entry for your package in the Buildroot configuration interface.

    ```
    config BR2_PACKAGE_MY_PACKAGE
        bool "my-package"
        help
          This is my custom package.
    ```

3.  **Create `<package-name>.mk`:**

    Create a makefile for your package, named `<package-name>.mk`. This file contains the instructions for building and installing your package.

    ```makefile
    ################################################################################
    #
    # my-package
    #
    ################################################################################

    MY_PACKAGE_VERSION = 1.0
    MY_PACKAGE_SOURCE = my-package-$(MY_PACKAGE_VERSION).tar.gz
    MY_PACKAGE_SITE = http://www.example.com/sources

    define MY_PACKAGE_BUILD_CMDS
        $(MAKE) -C $(@D)
    endef

    define MY_PACKAGE_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/my_program $(TARGET_DIR)/usr/bin/my_program
    endef

    $(eval $(generic-package))
    ```

4.  **Add to `package/Config.in`:**

    Add a `source` line to `package/Config.in` to include your package's `Config.in` file.

    ```
    source "package/my_package/Config.in"
    ```

5.  **Enable the package in the configuration:**

    Run `make menuconfig` and enable your new package in the "Target packages" menu.

For more information on creating custom packages, refer to the Buildroot manual.