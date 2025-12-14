#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting Buildroot build process..."

make -C buildroot radxa_zero3e_defconfig
make -C buildroot -j$(nproc)

echo "Buildroot compilation completed."
echo "Output images will be in output/images/"
