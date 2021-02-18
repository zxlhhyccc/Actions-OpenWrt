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
# K3默认驱动替换
sed -i 's/brcmfmac-firmware-4366c0-pcie/brcmfmac-firmware-4366c0-pcie-vendor/g' target/linux/bcm53xx/image/Makefile
# autocore-arm：添加目标sunxi支持
sed -i 's/uboot-envtools/autocore-arm uboot-envtools/g' target/linux/sunxi/Makefile
# ncurses：修改缺失libncursesw6
sed -i 's/ABI_VERSION:=6/ABI_VERSION:=$(PKG_ABI_VERSION)/g' package/libs/ncurses/Makefile
# readline：修改架构错误
sed -i 's/ABI_VERSION:=8/ABI_VERSION:=$(PKG_ABI_VERSION)/g' package/libs/readline/Makefile
