setenv boot_targets "mmc1"
setenv kernel_addr 0x02000000
setenv fdt_addr 0x04000000
setenv bootargs "console=ttyS0,1500000 earlycon=uart8250,mmio32,0xfe660000 root=/dev/mmcblk0p2 rootwait rw rootfstype=ext4"
load mmc 1:1 ${kernel_addr} Image
load mmc 1:1 ${fdt_addr} rk3566-radxa-zero-3e.dtb
fdt addr ${fdt_addr}
fdt resize 65536
booti ${kernel_addr} - ${fdt_addr}
