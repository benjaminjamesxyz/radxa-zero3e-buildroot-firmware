# Adding a Python Program to Buildroot

This guide explains how to add a custom Python program to the Buildroot build system, based on the `helloworld_python` example.

## Prerequisites

*   Python source code (with `setup.py` or `pyproject.toml` preferably).
*   Buildroot environment set up.

## Steps

### 1. Directory Structure

Create a directory for your package in `package/<your_package_name>`.
Place your source code in `examples/<your_package_name>`.

**Example Structure:**
```
buildroot-root/
├── examples/
│   └── my_python_app/
│       ├── setup.py
│       └── my_app/
│           └── __init__.py
├── package/
│   └── my_python_app/
│       ├── Config.in
│       └── my_python_app.mk
```

### 2. Create `Config.in`

Create `package/my_python_app/Config.in`.

```kconfig
config BR2_PACKAGE_MY_PYTHON_APP
    bool "my_python_app"
    depends on BR2_PACKAGE_PYTHON3
    help
      A description of your Python application.
```

Add this file to `package/Config.in`.

### 3. Create `.mk` File

Create `package/my_python_app/my_python_app.mk`.

Use the `python-package` infrastructure.

```makefile
################################################################################
#
# my_python_app
#
################################################################################

MY_PYTHON_APP_VERSION = 1.0
MY_PYTHON_APP_SITE = $(TOPDIR)/../examples/my_python_app
MY_PYTHON_APP_SITE_METHOD = local
MY_PYTHON_APP_LICENSE = MIT
# Use 'setuptools', 'pep517', or 'flit' depending on your project structure.
MY_PYTHON_APP_SETUP_TYPE = setuptools

$(eval $(python-package))
```

### 4. Enable and Build

1.  Run `cd buildroot-2025.02.9`.
2.  Run `make menuconfig`.
3.  Ensure `python3` is enabled in **Target packages** -> **Interpreter languages and scripting**.
4.  Navigate to **Target packages** and enable `my_python_app`.
5.  Save and exit.
6.  Run `make`.
