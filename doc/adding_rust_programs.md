# Adding a Rust Program to Buildroot

This guide explains how to add a custom Rust program to the Buildroot build system, based on the `helloworld_rust` example.

## Prerequisites

*   Rust source code (Cargo project).
*   Buildroot environment set up.

## Steps

### 1. Directory Structure

Create a directory for your package in `package/<your_package_name>`.
Place your source code in `examples/<your_package_name>`. This should be a standard Cargo project (with `Cargo.toml`).

**Example Structure:**
```
buildroot-root/
├── examples/
│   └── my_rust_app/
│       ├── Cargo.toml
│       └── src/
│           └── main.rs
├── package/
│   └── my_rust_app/
│       ├── Config.in
│       └── my_rust_app.mk
```

### 2. Create `Config.in`

Create `package/my_rust_app/Config.in`.

```kconfig
config BR2_PACKAGE_MY_RUST_APP
    bool "my_rust_app"
    depends on BR2_PACKAGE_HOST_RUSTC_TARGET_ARCH_SUPPORTS
    select BR2_PACKAGE_HOST_RUSTC
    help
      A description of your Rust application.
```

Add this file to `package/Config.in`.

### 3. Create `.mk` File

Create `package/my_rust_app/my_rust_app.mk`.

**Crucial:**
*   Depend on `host-rustc`.
*   Define the target architecture (`BR2_RUST_TARGET_ARCH`).
*   Set the `CARGO_TARGET_..._LINKER` environment variable to use the Buildroot cross-compiler (`$(TARGET_CROSS)gcc`).

```makefile
################################################################################
#
# my_rust_app
#
################################################################################

MY_RUST_APP_VERSION = 1.0
MY_RUST_APP_SITE = $(TOPDIR)/../examples/my_rust_app
MY_RUST_APP_SITE_METHOD = local
MY_RUST_APP_LICENSE = MIT

# Dependency on the host Rust toolchain is required
MY_RUST_APP_DEPENDENCIES = host-rustc

# Define the target triplet (e.g., aarch64-unknown-linux-gnu for ARM64)
BR2_RUST_TARGET_ARCH = aarch64-unknown-linux-gnu

# Convert triplet to uppercase/underscore for Cargo env var (e.g., AARCH64_UNKNOWN_LINUX_GNU)
RUST_TARGET_ENV_VAR = $(shell echo $(BR2_RUST_TARGET_ARCH) | tr a-z A-Z | sed 's/[.-]/_/g')

define MY_RUST_APP_BUILD_CMDS
    cd $(@D); \
    $(TARGET_MAKE_ENV) \
    CARGO_TARGET_$(RUST_TARGET_ENV_VAR)_LINKER=$(TARGET_CROSS)gcc \
    $(HOST_DIR)/bin/cargo build --release --target=$(BR2_RUST_TARGET_ARCH)
endef

define MY_RUST_APP_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/target/$(BR2_RUST_TARGET_ARCH)/release/my_rust_app $(TARGET_DIR)/usr/bin/my_rust_app
endef

$(eval $(generic-package))
```

### 4. Enable and Build

1.  Run `cd buildroot-2025.02.9`.
2.  Run `make menuconfig`.
3.  Navigate to **Target packages** and enable `my_rust_app`.
4.  Save and exit.
5.  Run `make`.

```