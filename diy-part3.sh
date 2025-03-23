#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 添加内核的 NSS 支持
rm -rf target/linux/qualcommax
cp -rf ./acc-imq-bbr/master/qca-5.10-5.15/target/linux/qualcommax ./target/linux/

wget -P target/linux/ipq40xx/files/arch/arm/boot/dts/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-c526a.dts

# boot-envtools添加ipq807x
rm -rf package/boot/uboot-tools/uboot-envtools/files/qualcommax_ipq807x
wget -P package/boot/uboot-tools/uboot-envtools/files/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca-5.10-5.15/package/boot/uboot-tools/uboot-envtools/files/qualcommax_ipq807x

# firmware添加ax6等文件
cp -rf ./acc-imq-bbr/master/qca-5.10-5.15/package/firmware/ath11k-board ./package/firmware/

# rm -f ./package/firmware/ath11k-firmware/Makefile
# wget -P package/firmware/ath11k-firmware/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca-5.10-5.15/package/firmware/ath11k-firmware/Makefile

rm -rf ./package/firmware/ipq-wifi
cp -rf ./acc-imq-bbr/master/qca-5.10-5.15/package/firmware/ipq-wifi ./package/firmware/

# kernel/linux替换修改后usb.mk
rm -f ./package/kernel/linux/modules/usb.mk
wget -P package/kernel/linux/modules/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca-5.10-5.15/package/kernel/linux/modules/usb.mk

# MAC80211添加ipq807x支持
rm -rf package/kernel/mac80211
cp -rf ./acc-imq-bbr/master/qca-5.10-5.15/package/kernel/mac80211 ./package/kernel/

# cryptodev-linux：为 QCA NSS 添加挂钩
wget -P package/kernel/cryptodev-linux/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/cryptodev-linux/001-add-hooks-for-QCA-NSS.patch
pushd package/kernel/cryptodev-linux
patch -p1 < 001-add-hooks-for-QCA-NSS.patch
rm -f 001-add-hooks-for-QCA-NSS.patch
popd

# qualcommax：为 IPQ 设置添加新菜单项
# 选项包括：
# 1) 启用或禁用构建 `skbuff_recycle`
# 2）启用或禁用抢占
# 3）选择IPQ内存配置文件
wget -P ./ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/001-qualcommax-add-new-menu-item-for-IPQ-settings.patch
patch -p1 < 001-qualcommax-add-new-menu-item-for-IPQ-settings.patch
rm -f 001-qualcommax-add-new-menu-item-for-IPQ-settings.patch

# 添加NSS
rm -rf package/kernel/qca-nss-dp
rm -rf package/kernel/qca-ssdk

cp -rf ./acc-imq-bbr/master/package/NSS-12.5-K6.x ./package/

