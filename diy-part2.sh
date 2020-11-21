#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
# squashfs：使mkfs具有多CPU加速
sed -i 's/processors 1/processors $(shell nproc)/g' include/image.mk
# openssl：通过以下方式，使ARMv8设备适配ChaCha20-Poly1305而不是AES-GCM
sed -i 's/default y if !x86_64 && !aarch64/default y if !x86_64/g' package/libs/openssl/Config.in
