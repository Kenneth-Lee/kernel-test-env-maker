#!/bin/sh

#if use drive which if=ide, set root to /dev/sda1
#if use drive which if=virtio, set root to /dev/vda1

qemu-system-aarch64 -cpu cortex-a57 -machine virt \
	-nographic -smp 1 -m 1024m -kernel arch/arm64/boot/Image \
	-device virtio-net-pci,netdev=net0 -netdev type=user,id=net0,hostfwd=tcp::5555-:22 \
	-fsdev local,id=p9fs,path=p9root,security_model=mapped \
	-device virtio-9p-pci,fsdev=p9fs,mount_tag=p9 \
	-append "console=ttyAMA0"

#These are tested:
# with external image
#qemu-system-aarch64 -cpu cortex-a57 -machine virt \
#	-S -s \
#	-drive if=none,file=ubuntu-14.04-server-cloudimg-arm64-uefi1.img,id=hd0 \
#	-device virtio-blk-device,drive=hd0 \
#	-nographic -smp 1 -m 1024m -kernel arch/arm64/boot/Image \
#	-append "console=ttyAMA0 root=/dev/vda1 init=/bin/sh"
#
# with buildroot as initramfs
#qemu-system-aarch64 -cpu cortex-a57 -machine virt \
#	-nographic -smp 1 -m 1024m -kernel arch/arm64/boot/Image \
#	-device virtio-net-pci,netdev=net0 -netdev type=user,id=net0,hostfwd=tcp::5555-:22 \
#	-fsdev local,id=p9fs,path=p9root,security_model=mapped \
#	-device virtio-9p-pci,fsdev=p9fs,mount_tag=p9 \
#	-append "console=ttyAMA0"
#
# with a user net:
#	the dhcp address of the guest is 10.0.2.15,
#	proxy is 100.0.2.2
#	dhcp server is 10.0.2.3
# with hostfwd:
#	ssh to local port will be redirect to guest port
# with plan 9 filesystem, mount in guest by:
#	mount -t 9p -o trans=virtio p9 /mnt

