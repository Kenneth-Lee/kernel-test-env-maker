#!/bin/sh

/usr/bin/qemu-system-x86_64 -nographic \
	-kernel arch/x86_64/boot/bzImage \
	-m 512 \
	-net nic,model=ne2k_pci -net user,tftp=. \
	-drive file=rootfs.img,index=0,media=disk \
	-append "rw console=ttyS0 root=/dev/sda1"
