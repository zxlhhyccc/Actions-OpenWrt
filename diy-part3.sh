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

# 添加5.10/5.15内核的QCA支持
rm -rf target/linux/qualcommax
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/qca-5.10-5.15/target/linux/qualcommax target/linux/qualcommax

wget -P target/linux/ipq40xx/files/arch/arm/boot/dts/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-c526a.dts

# boot-envtools添加ipq807x
rm -rf package/boot/uboot-envtools/files/qualcommax_ipq807x
wget -P package/boot/uboot-envtools/files/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca-5.10-5.15/package/boot/uboot-envtools/files/qualcommax_ipq807x

# firmware添加ax6等文件
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/qca-5.10-5.15/package/firmware/ath11k-board package/firmware/ath11k-board

# rm -f ./package/firmware/ath11k-firmware/Makefile
# wget -P package/firmware/ath11k-firmware/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca-5.10-5.15/package/firmware/ath11k-firmware/Makefile

rm -rf ./package/firmware/ipq-wifi
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/qca-5.10-5.15/package/firmware/ipq-wifi package/firmware/ipq-wifi

# kernel/linux替换修改后hwmon.mk、usb.mk
rm -f ./package/kernel/linux/modules/hwmon.mk
wget -P package/kernel/linux/modules/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca-5.10-5.15/package/kernel/linux/modules/hwmon.mk

rm -f ./package/kernel/linux/modules/usb.mk
wget -P package/kernel/linux/modules/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca-5.10-5.15/package/kernel/linux/modules/usb.mk

# MAC80211添加ipq807x支持
rm -rf package/kernel/mac80211
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/qca-5.10-5.15/package/kernel/mac80211 package/kernel/mac80211

# 添加NSS
rm -rf package/kernel/qca-nss-dp
rm -rf package/kernel/qca-ssdk

svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/package/nss-packages-12.4r1 package/nss-packages-12.4r1
