# Adding a Go Program to Buildroot

This guide explains how to add a custom Go program to the Buildroot build system, based on the `helloworld_go` example.

## Prerequisites

*   Go source code (e.g., `main.go`, `go.mod`).
*   Buildroot environment set up.

## Steps

### 1. Directory Structure

Create a directory for your package in `package/<your_package_name>`.
Place your source code in `examples/<your_package_name>`.

**Example Structure:**
```
buildroot-root/
├── examples/
│   └── my_go_app/
│       ├── go.mod
│       └── main.go
├── package/
│   └── my_go_app/
│       ├── Config.in
│       └── my_go_app.mk
```

### 2. Create `Config.in`

Create `package/my_go_app/Config.in`.

```kconfig
config BR2_PACKAGE_MY_GO_APP
    bool "my_go_app"
    depends on BR2_PACKAGE_HOST_GO_TARGET_ARCH_SUPPORTS
    depends on BR2_PACKAGE_HOST_GO_TARGET_CGO_LINKING_SUPPORTS
    depends on BR2_TOOLCHAIN_HAS_THREADS
    help
      A description of your Go application.
```

Add this file to `package/Config.in`.

### 3. Create `.mk` File

Create `package/my_go_app/my_go_app.mk`.

**Crucial:** You must depend on `host-go` and set the correct environment variables (`GOOS`, `GOARCH`, `CGO_ENABLED`) for cross-compilation.

```makefile
################################################################################
#
# my_go_app
#
################################################################################

MY_GO_APP_VERSION = 1.0
MY_GO_APP_SITE = $(TOPDIR)/../examples/my_go_app
MY_GO_APP_SITE_METHOD = local
MY_GO_APP_LICENSE = MIT

# Dependency on the host Go toolchain is required
MY_GO_APP_DEPENDENCIES = host-go

define MY_GO_APP_BUILD_CMDS
    cd $(@D); \
    export GOOS=linux; \
    export GOARCH=arm64; \
    export CGO_ENABLED=0; \
    $(HOST_DIR)/bin/go build -o my_go_app .
endef

define MY_GO_APP_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/my_go_app $(TARGET_DIR)/usr/bin/my_go_app
endef

$(eval $(generic-package))
```

### 4. Enable and Build

1.  Run `cd buildroot-2025.02.9`.
2.  Run `make menuconfig`.
3.  Navigate to **Target packages** and enable `my_go_app`.
4.  Save and exit.
5.  Run `make`.

```
