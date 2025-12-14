################################################################################
#
# helloworld_c
#
################################################################################

HELLOWORLD_C_VERSION = 1.0
HELLOWORLD_C_SITE = $(TOPDIR)/../examples/c
HELLOWORLD_C_SITE_METHOD = local

define HELLOWORLD_C_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) $(@D)/hello.c -o $(@D)/helloworld_c
endef

define HELLOWORLD_C_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/helloworld_c $(TARGET_DIR)/usr/bin/helloworld_c
endef

$(eval $(generic-package))
