################################################################################
#
# helloworld_rust
#
################################################################################

HELLOWORLD_RUST_VERSION = 1.0
HELLOWORLD_RUST_SITE = $(TOPDIR)/../examples/rust
HELLOWORLD_RUST_SITE_METHOD = local
HELLOWORLD_RUST_LICENSE = MIT
HELLOWORLD_RUST_DEPENDENCIES = host-rustc

# Manually define BR2_RUST_TARGET_ARCH for generic-package
BR2_RUST_TARGET_ARCH = aarch64-unknown-linux-gnu

# Convert target triplet to uppercase with underscores for CARGO environment variable
RUST_TARGET_ENV_VAR = $(shell echo $(BR2_RUST_TARGET_ARCH) | tr a-z A-Z | sed 's/[.-]/_/g')

define HELLOWORLD_RUST_BUILD_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) \
	CARGO_TARGET_$(RUST_TARGET_ENV_VAR)_LINKER=$(TARGET_CROSS)gcc \
	$(HOST_DIR)/bin/cargo build --release --target=$(BR2_RUST_TARGET_ARCH)
endef

define HELLOWORLD_RUST_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/target/$(BR2_RUST_TARGET_ARCH)/release/helloworld_rust $(TARGET_DIR)/usr/bin/helloworld_rust
endef

$(eval $(generic-package))