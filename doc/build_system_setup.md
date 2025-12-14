# Build System Setup

This document outlines the steps to set up the build system and compile the custom Linux OS for the Radxa Zero 3E.

## Prerequisites

The build system is designed to run on a modern Linux distribution. The following tools are required:

*   `git`
*   `wget`
*   `unzip`
*   `python`
*   `make`
*   `gcc`
*   `g++`
*   `ncurses-dev`
*   `bc`

## Setup

1.  **Clone the repository:**

    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2.  **Run the setup script:**

    The `setup.sh` script will download the Buildroot tarball and extract it.

    ```bash
    ./scripts/setup.sh
    ```

## Building the OS

The `build.sh` script automates the entire build process. It will:

1.  Configure Buildroot with the `radxa_zero3e_defconfig`.
2.  Build the toolchain, kernel, bootloader, and root filesystem.
3.  Generate the final SD card image.

To start the build, run the following command:

```bash
./scripts/build.sh
```

The build process will take a significant amount of time, depending on the performance of your build machine.

## Output

The build output will be located in the `buildroot-2025.02.9/output/images` directory. The most important file is `sdcard.img`, which is the final image to be flashed to an SD card.