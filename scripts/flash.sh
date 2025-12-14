#!/bin/bash
set -e

IMAGE="buildroot/output/images/sdcard.img"

if [ -z "$1" ]; then
    echo "Usage: $0 <device>"
    echo "Example: $0 /dev/sdX  (or /dev/mmcblkX)"
    echo
    echo "Available block devices:"
    lsblk -d -o NAME,SIZE,MODEL | grep -v "loop"
    exit 1
fi

DEVICE=$1

if [ ! -b "$DEVICE" ]; then
    echo "Error: Device $DEVICE not found or not a block device."
    exit 1
fi

if [ ! -f "$IMAGE" ]; then
    echo "Error: Image file $IMAGE not found."
    echo "Please run ./build.sh first."
    exit 1
fi

echo "========================================================"
echo "WARNING: DATA DESTRUCTION IMMINENT"
echo "========================================================"
echo "You are about to flash: $IMAGE"
echo "Target Device:          $DEVICE"
echo
echo "ALL DATA on $DEVICE will be PERMANENTLY ERASED."
echo "========================================================"

read -p "Are you absolutely sure? (type 'yes' to continue): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo "Unmounting partitions on $DEVICE (if any)..."
sudo umount ${DEVICE}* 2>/dev/null || true

echo "Flashing image... (this may take a while)"
sudo dd if="$IMAGE" of="$DEVICE" bs=4M status=progress oflag=sync

echo ""
echo "Flashing completed successfully."
echo "You can now remove the SD card."
