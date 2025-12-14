#!/bin/sh

IMAGE_DIR="${BINARIES_DIR}"
IMG_FILE="${IMAGE_DIR}/sdcard.img"

if [ -f "${IMG_FILE}" ]; then
    echo "Compressing ${IMG_FILE} to ${IMG_FILE}.gz..."
    gzip -f "${IMG_FILE}"
    echo "Compression complete."
else
    echo "Error: ${IMG_FILE} not found."
    exit 1
fi
