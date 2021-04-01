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
# squashfs：使mkfs具有多CPU加速和添加固件日期形式的编号
sed -i 's/processors 1/processors $(shell nproc)/g' include/image.mk
sed -i '35i BUILD_DATE_PREFIX := $(shell date +'%Y%m%d%H%M')' include/image.mk
sed -i "s/%Y%m%d%H%M/\'%Y%m%d%H%M\'/g" include/image.mk
sed -i 's/$(VERSION_DIST_SANITIZED)/$(BUILD_DATE_PREFIX)-$(VERSION_DIST_SANITIZED)/g' include/image.mk
# openssl：通过以下方式，使ARMv8设备适配ChaCha20-Poly1305而不是AES-GCM
sed -i 's/default y if !x86_64 && !aarch64/default y if !x86_64/g' package/libs/openssl/Config.in
# K3默认驱动替换
sed -i 's/brcmfmac-firmware-4366c0-pcie/brcmfmac-firmware-4366c0-pcie-vendor/g' target/linux/bcm53xx/image/Makefile
# K3默认驱动还原
# sed -i 's/brcmfmac-firmware-4366c0-pcie-vendor/brcmfmac-firmware-4366c0-pcie/g' target/linux/bcm53xx/image/Makefile
# 只编译K3固件
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
# 还原编译k3的同架构所有固件
# sed -i 's|^# TARGET_|TARGET_|g' target/linux/bcm53xx/image/Makefile
# autocore-arm：添加目标sunxi支持
sed -i 's/uboot-envtools/autocore-arm uboot-envtools/g' target/linux/sunxi/Makefile
