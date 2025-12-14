# Adding New Partitions to the SD Card Image

This guide explains how to add new partitions to the generated SD card image (`sdcard.img`) and configure the system to automatically mount them on boot.

## Overview

The process involves three main steps:
1.  **Modify the `genimage` configuration**: Define the new filesystem image and add it as a partition to the SD card image.
2.  **Create the mount point**: Create the directory where the new partition will be mounted in the root filesystem.
3.  **Configure `fstab`**: Add an entry to `/etc/fstab` to tell the kernel how and where to mount the partition.

## Step 1: Modify `genimage` Configuration

The SD card image layout is defined in `board/radxa/radxa_zero3e/genimage-radxa-zero3e.cfg`.

To add a new partition, you need to:
1.  Define a new image block for the partition's filesystem (e.g., `ext4`).
2.  Add a `partition` block within the `sdcard.img` image definition referencing the new image.

**Example: Adding a 64MB "data" partition**

Edit `board/radxa/radxa_zero3e/genimage-radxa-zero3e.cfg`:

```cfg
# ... existing configuration ...

image sdcard.img {
  hdimage {}

  # ... existing partitions ...

  partition rootfs {
    partition-type = 0x83
    image = "rootfs.ext4"
    offset = 144M
  }

  # Add the new partition here
  partition data {
    partition-type = 0x83
    image = "data.ext4"
  }
}

# Define the filesystem image for the new partition
image data.ext4 {
  ext4 {
    label = "data"  # Set a label for easy mounting
  }
  size = "64M"      # Set the desired size
}
```

## Step 2: Create the Mount Point

You need to create the directory where the partition will be mounted. This is done in the `rootfs_overlay` directory so it persists in the generated root filesystem.

**Example:**

Create the `/data` directory:

```bash
mkdir -p board/radxa/radxa_zero3e/rootfs_overlay/data
```

## Step 3: Configure Auto-mounting (fstab)

To mount the partition automatically at boot, create or edit the `/etc/fstab` file in the `rootfs_overlay`.

**File:** `board/radxa/radxa_zero3e/rootfs_overlay/etc/fstab`

Add an entry for the new partition. While labels (`LABEL=data`) are standard, using the direct device path (e.g., `/dev/mmcblk0p3`) is often more reliable in minimal embedded environments where `blkid` or udev rules might be limited.

**Example `fstab` content:**

```fstab
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
proc            /proc           proc    defaults        0       0
sysfs           /sys            sysfs   defaults        0       0
tmpfs           /tmp            tmpfs   defaults        0       0
devpts          /dev/pts        devpts  defaults,gid=5,mode=620 0       0

# Root filesystem
LABEL=rootfs    /               ext4    defaults,noatime 0      1

# New Data partition (using device path for reliability)
/dev/mmcblk0p3  /data           ext4    defaults,noatime 0      2
```

## Rebuild

After making these changes, rebuild the project to generate the new `sdcard.img`:

```bash
./scripts/build.sh
```

The new image will now include the extra partition, and the system will attempt to mount it to `/data` on boot.
