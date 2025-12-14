#!/bin/bash
set -e

if [ "$1" == "dist" ]; then
    echo "Running distclean (removing all build artifacts, downloads, and configuration)..."
    echo "WARNING: This will require a full re-download and re-build next time."
    read -p "Are you sure? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
    make -C buildroot distclean
else
    echo "Running clean (removing build artifacts, keeping config and dl)..."
    make -C buildroot clean
fi
