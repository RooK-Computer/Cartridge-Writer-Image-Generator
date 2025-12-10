#!/bin/bash -e

on_chroot<<EOF
mkdir -p /etc/systemd/system/getty@tty1.service.d
EOF
install -m 644 files/autologin.conf "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/"

