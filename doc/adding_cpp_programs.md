# Adding a C++ Program to Buildroot

This guide explains how to add a custom C++ program to the Buildroot build system, based on the `helloworld_cpp` example.

## Prerequisites

*   A C++ source file (e.g., `hello.cpp`).
*   Buildroot environment set up.
*   **Important:** C++ support must be enabled in your toolchain configuration (`BR2_TOOLCHAIN_BUILDROOT_CXX=y`).

## Steps

### 1. Directory Structure

Create a directory for your package in `package/<your_package_name>`.
Place your source code in `examples/<your_package_name>`.

**Example Structure:**
```
buildroot-root/
├── examples/
│   └── my_cpp_app/
│       └── main.cpp
├── package/
│   └── my_cpp_app/
│       ├── Config.in
│       └── my_cpp_app.mk
```

### 2. Create `Config.in`

Create `package/my_cpp_app/Config.in`.

```kconfig
config BR2_PACKAGE_MY_CPP_APP
    bool "my_cpp_app"
    depends on BR2_INSTALL_LIBSTDCPP
    help
      A description of your C++ application.

comment "my_cpp_app needs a toolchain w/ C++"
    depends on !BR2_INSTALL_LIBSTDCPP
```

Add this file to `package/Config.in`.

### 3. Create `.mk` File

Create `package/my_cpp_app/my_cpp_app.mk`.

```makefile
################################################################################
#
# my_cpp_app
#
################################################################################

MY_CPP_APP_VERSION = 1.0
MY_CPP_APP_SITE = $(TOPDIR)/../examples/my_cpp_app
MY_CPP_APP_SITE_METHOD = local

# Build Commands
# Use $(TARGET_CXX) for the C++ compiler.
# Use $(TARGET_CXXFLAGS) for C++ flags.
define MY_CPP_APP_BUILD_CMDS
    $(TARGET_CXX) $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS) $(@D)/main.cpp -o $(@D)/my_cpp_app
endef

# Install Commands
define MY_CPP_APP_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/my_cpp_app $(TARGET_DIR)/usr/bin/my_cpp_app
endef

$(eval $(generic-package))
```

### 4. Enable and Build

1.  Run `cd buildroot-2025.02.9`.
2.  Run `make menuconfig`.
3.  Ensure C++ support is enabled in **Toolchain**.
4.  Navigate to **Target packages** and enable `my_cpp_app`.
5.  Save and exit.
6.  Run `make`.
