#!/bin/bash -e

install -m 755 files/pv "${ROOTFS_DIR}/etc/initramfs-tools/hooks/"
install -m 755 files/ramdisk-copy "${ROOTFS_DIR}/etc/initramfs-tools/scripts/local-premount/ramdisk-copy"

