# Adding a C Program to Buildroot

This guide explains how to add a custom C program to the Buildroot build system, based on the `helloworld_c` example.

## Prerequisites

*   A C source file (e.g., `hello.c`).
*   Buildroot environment set up.

## Steps

### 1. Directory Structure

Create a directory for your package in `package/<your_package_name>`.
Place your source code in `examples/<your_package_name>` (or any location accessible to Buildroot).

**Example Structure:**
```
buildroot-root/
├── examples/
│   └── my_c_app/
│       └── main.c
├── package/
│   └── my_c_app/
│       ├── Config.in
│       └── my_c_app.mk
```

### 2. Create `Config.in`

Create `package/my_c_app/Config.in` to define the package in the menu.

```kconfig
config BR2_PACKAGE_MY_C_APP
    bool "my_c_app"
    help
      A description of your C application.
```

Add this file to `package/Config.in` so it appears in `make menuconfig`:
```kconfig
menu "My Custom Packages"
    source "package/my_c_app/Config.in"
endmenu
```

### 3. Create `.mk` File

Create `package/my_c_app/my_c_app.mk` to define how to build and install the package.

```makefile
################################################################################
#
# my_c_app
#
################################################################################

MY_C_APP_VERSION = 1.0
# Point to your source directory. 
# $(TOPDIR) is the buildroot directory (buildroot-2025.02.9).
# Adjust the path to match where you put your source.
MY_C_APP_SITE = $(TOPDIR)/../examples/my_c_app
MY_C_APP_SITE_METHOD = local

# Build Commands
define MY_C_APP_BUILD_CMDS
    $(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) $(@D)/main.c -o $(@D)/my_c_app
endef

# Install Commands
define MY_C_APP_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/my_c_app $(TARGET_DIR)/usr/bin/my_c_app
endef

$(eval $(generic-package))
```

### 4. Enable and Build

1.  Run `cd buildroot-2025.02.9`.
2.  Run `make menuconfig`.
3.  Navigate to **Target packages** (or your custom menu) and enable `my_c_app`.
4.  Save and exit.
5.  Run `make`.

The binary will be installed to `/usr/bin/my_c_app` in the target filesystem.
