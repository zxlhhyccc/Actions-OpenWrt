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

# 添加5.10内核的QCA支持
rm -rf target/linux/ipq807x
svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/qca/target/linux/ipq807x target/linux/ipq807x
rm -rf ./target/linux/ipq807x/.svn

# boot-envtools添加ipq807x
wget -P package/boot/uboot-envtools/files/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/boot/uboot-envtools/files/ipq807x

# firmware添加ax6等文件
svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/qca/package/firmware/ath11k-firmware package/firmware/ath11k-firmware
rm -rf ./package/firmware/ath11k-firmware/.svn

rm -f ./package/firmware/ipq-wifi/Makefile
wget -P package/firmware/ipq-wifi/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/firmware/ipq-wifi/Makefile

wget -P package/firmware/ipq-wifi/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/firmware/ipq-wifi/board-hiwifi_c526a.qca4019

wget -P package/firmware/ipq-wifi/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/firmware/ipq-wifi/board-netgear_sxr80.ipq8074

wget -P package/firmware/ipq-wifi/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/firmware/ipq-wifi/board-p2w_r619ac.qca4019

wget -P package/firmware/ipq-wifi/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/firmware/ipq-wifi/board-redmi_ax6.ipq8074

wget -P package/firmware/ipq-wifi/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/firmware/ipq-wifi/board-xiaomi_ax3600.ipq8074

wget -P package/firmware/ipq-wifi/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/firmware/ipq-wifi/board-xiaomi_ax3600.qca9889

wget -P package/firmware/ipq-wifi/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/firmware/ipq-wifi/board-xiaomi_ax9000.ipq8074

wget -P package/firmware/ipq-wifi/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/firmware/ipq-wifi/board-xiaomi_ax9000.qca9889

wget -P package/firmware/ipq-wifi/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/firmware/ipq-wifi/board-zte_mf269.ipq8074

# kernel/linux替换修改后hwmon.mk、usb.mk
rm -f ./package/kernel/linux/modules/hwmon.mk
wget -P package/kernel/linux/modules/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/kernel/linux/modules/hwmon.mk

rm -f ./package/kernel/linux/modules/usb.mk
wget -P package/kernel/linux/modules/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/qca/package/kernel/linux/modules/usb.mk

# MAC80211添加ipq807x支持
rm -rf package/kernel/mac80211
svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/qca/package/kernel/mac80211 package/kernel/mac80211
rm -rf ./package/kernel/mac80211/.svn
