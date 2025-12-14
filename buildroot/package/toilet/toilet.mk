################################################################################
#
# toilet
#
################################################################################

TOILET_VERSION = 0.3
TOILET_SITE = http://caca.zoy.org/raw-attachment/wiki/toilet
TOILET_SOURCE = toilet-$(TOILET_VERSION).tar.gz
TOILET_LICENSE = WTFPLv2
TOILET_LICENSE_FILES = COPYING

# toilet is an autotools package
TOILET_AUTORECONF = YES
TOILET_DEPENDENCIES = libcaca

# toilet's configure script doesn't have many options,
# it mostly relies on libcaca's configuration.
TOILET_CONF_OPTS =

define TOILET_CREATE_MISSING_FILES
	touch $(@D)/AUTHORS
	touch $(@D)/NEWS
	touch $(@D)/README
	touch $(@D)/ChangeLog
endef
TOILET_POST_EXTRACT_HOOKS += TOILET_CREATE_MISSING_FILES

$(eval $(autotools-package))