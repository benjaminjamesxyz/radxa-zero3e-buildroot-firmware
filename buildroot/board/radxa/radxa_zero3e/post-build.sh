#!/bin/sh
echo "Current working directory: $(pwd)"
echo "BOARD_DIR: ${BOARD_DIR}"
echo "BINARIES_DIR: ${BINARIES_DIR}"
echo "TARGET_DIR: $1"

# This script is executed after the root filesystem is built.
# It can be used to add custom files or perform other modifications.

TARGET_DIR="$1"
OVERLAY_DIR="${BOARD_DIR}/rootfs_overlay"

# Export Buildroot version (from the Buildroot version itself)
# This is a bit tricky to get dynamically, so for now, we'll use the known LTS version
BUILDROOT_VERSION="2025.02.9"
UBOOT_VERSION="2025.10"
LINUX_VERSION="6.17.11"

echo "${BUILDROOT_VERSION}" >"${TARGET_DIR}/etc/firmware-version"
echo "${UBOOT_VERSION}" >"${TARGET_DIR}/etc/uboot-version"

# Ensure the custom boot script is executable
chmod +x "${TARGET_DIR}/etc/init.d/S99custom_boot_info"

# Create boot.scr
${HOST_DIR}/bin/mkimage -C none -A arm64 -T script -d board/radxa/radxa_zero3e/boot.cmd ${BINARIES_DIR}/boot.scr

# Copy genimage config file
cp "board/radxa/radxa_zero3e/genimage-radxa-zero3e.cfg" "${BINARIES_DIR}/genimage.cfg"

# Fix toilet fonts being zipped
for f in "${TARGET_DIR}/usr/share/figlet/"*.tlf; do
    if [ -f "$f" ] && file "$f" | grep -q "Zip archive"; then
        echo "Unzipping font $f"
        unzip -p "$f" > "$f.tmp"
        mv "$f.tmp" "$f"
    fi
done

echo "Custom post-build script executed."
