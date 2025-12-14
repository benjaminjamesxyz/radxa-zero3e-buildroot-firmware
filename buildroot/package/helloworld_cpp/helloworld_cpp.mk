################################################################################
#
# helloworld_cpp
#
################################################################################

HELLOWORLD_CPP_VERSION = 1.0
HELLOWORLD_CPP_SITE = $(TOPDIR)/../examples/cpp
HELLOWORLD_CPP_SITE_METHOD = local

define HELLOWORLD_CPP_BUILD_CMDS
	$(TARGET_CXX) $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS) $(@D)/hello.cpp -o $(@D)/helloworld_cpp
endef

define HELLOWORLD_CPP_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/helloworld_cpp $(TARGET_DIR)/usr/bin/helloworld_cpp
endef

$(eval $(generic-package))
