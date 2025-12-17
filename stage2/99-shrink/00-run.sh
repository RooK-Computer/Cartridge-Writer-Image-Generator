#!/bin/bash
set -e

echo "=== FINAL ROOTFS SHRINK ==="

on_chroot<<EOF
# APT-Reste löschen
apt-get clean
rm -rf /var/cache/apt/archives/*
rm -rf /var/lib/apt/lists/*

# Logs löschen
rm -rf /var/log/*
rm -rf /var/log/journal/*

# Docs, Manpages, Info
rm -rf /usr/share/doc/*
rm -rf /usr/share/man/*
rm -rf /usr/share/info/*
rm -rf /usr/share/locale/*

EOF

sync

