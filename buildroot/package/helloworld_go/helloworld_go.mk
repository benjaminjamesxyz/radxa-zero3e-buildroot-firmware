################################################################################
#
# helloworld_go
#
################################################################################

HELLOWORLD_GO_VERSION = 1.0
HELLOWORLD_GO_SITE = $(TOPDIR)/../examples/go
HELLOWORLD_GO_SITE_METHOD = local
HELLOWORLD_GO_LICENSE = MIT
HELLOWORLD_GO_DEPENDENCIES = host-go

define HELLOWORLD_GO_BUILD_CMDS
	cd $(@D); \
	export GOOS=linux; \
	export GOARCH=arm64; \
	export CGO_ENABLED=0; \
	$(HOST_DIR)/bin/go build -o helloworld_go .
endef

define HELLOWORLD_GO_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/helloworld_go $(TARGET_DIR)/usr/bin/helloworld_go
endef

$(eval $(generic-package))