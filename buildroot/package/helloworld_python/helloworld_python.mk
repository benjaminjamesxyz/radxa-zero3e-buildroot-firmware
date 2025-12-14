################################################################################
#
# helloworld_python
#
################################################################################

HELLOWORLD_PYTHON_VERSION = 1.0
HELLOWORLD_PYTHON_SITE = $(TOPDIR)/../examples/python
HELLOWORLD_PYTHON_SITE_METHOD = local
HELLOWORLD_PYTHON_LICENSE = MIT
HELLOWORLD_PYTHON_SETUP_TYPE = setuptools

$(eval $(python-package))
