################################################################################
#
# libcaca
#
################################################################################

LIBCACA_VERSION = 0.99.beta20
LIBCACA_SITE = https://github.com/cacalabs/libcaca/releases/download/v$(LIBCACA_VERSION)
LIBCACA_SOURCE = libcaca-$(LIBCACA_VERSION).tar.gz
LIBCACA_LICENSE = WTFPLv2
LIBCACA_LICENSE_FILES = COPYING
LIBCACA_INSTALL_STAGING = YES

# libcaca is an autotools package
LIBCACA_AUTORECONF = YES
LIBCACA_DEPENDENCIES = ncurses

# Configure options:
# --enable-ncurses: Enable ncurses support
# --disable-doc: Disable building documentation
# --disable-python: Disable Python bindings
# --disable-ruby: Disable Ruby bindings
# --disable-java: Disable Java bindings
# --disable-cxx: Disable C++ bindings
# --disable-gl: Disable OpenGL support
# --disable-x11: Disable X11 support
# --disable-imlib2: Disable Imlib2 support
# --disable-network: Disable network support
# --disable-plugins: Disable plugins
LIBCACA_CONF_OPTS = \
	--enable-ncurses \
	--disable-doc \
	--disable-python \
	--disable-ruby \
	--disable-java \
	--disable-cxx \
	--disable-gl \
	--disable-x11 \
	--disable-imlib2 \
	--disable-network \
	--disable-plugins

$(eval $(autotools-package))

define CACA_REMOVE_BROKEN_BINARIES
	rm -f $(TARGET_DIR)/usr/bin/img2txt
	rm -f $(TARGET_DIR)/usr/bin/cacaview
endef

LIBCACA_POST_INSTALL_TARGET_HOOKS += CACA_REMOVE_BROKEN_BINARIES