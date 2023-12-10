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

# x86(5.15-6.1)：改进英特尔第 11/12 代 GPU i915 和 GVT-g 功能
rm -rf ./target/linux/x86
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/target/linux/x86 target/linux/x86

# 以下注释为相关功能优化情况
# wget -P ./target/linux/x86/patches-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-6.1/800-add-rts5139.patch

# wget -P ./target/linux/x86/patches-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-6.1/900-dg1-guc-and-huc-support.patch

# wget -P ./target/linux/x86/patches-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-6.1/992-enable-intel-guc.patch

# wget -P ./target/linux/x86/patches-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-6.1/993-bnx2x_warpcore_8727_2_5g_sgmii_txfault.patch

# wget -P ./target/linux/x86/patches-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-6.1/996-intel-igc-i225-i226-disable-eee.patch

# wget -P ./target/linux/x86/patches-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-6.1/998-add-a-sysctl-to-enable-disable-tcp_collapse-logic.patch

# wget -P ./target/linux/x86/patches-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-6.1/999-Add-xtsproxy-Crypto-API-module.patch

# rm -f ./target/linux/x86/64/config-6.1
# wget -P ./target/linux/x86/64/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/64/config-6.1

# rm -f ./target/linux/x86/config-6.1
# wget -P ./target/linux/x86/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/config-6.1

# 给kernel(6.1)添加 bcm fullconenat补丁
wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/982-add-bcm-fullconenat-support.patch

# 内核：添加6.1内核ACC、shortcut-fe补丁
rm -f ./target/linux/generic/config-6.1
wget -P ./target/linux/generic/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/config-6.1

wget -P ./target/linux/generic/backport-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-6.1/999-1-convert_official_linux-6.1.x_src_to_bbrplus.patch

wget -P ./target/linux/generic/backport-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-6.1/999-2-convert_official_linux-6.1.x_src_to_nanqinlang.patch

wget -P ./target/linux/generic/backport-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-6.1/999-3-convert_official_linux-6.1.x_src_to_tsunami.patch

wget -P ./target/linux/generic/pending-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-6.1/613-netfilter_optional_tcp_window_check.patch

wget -P ./target/linux/generic/pending-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-6.1/901-usb-add-more-modem-support.patch

wget -P ./target/linux/generic/pending-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-6.1/994-add-quectel-rm500u-support.patch

rm -f ./target/linux/generic/hack-6.1/901-debloat_sock_diag.patch
wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/901-debloat_sock_diag.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/952-add-net-conntrack-events-support-multiple-registrant.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/953-net-patch-linux-kernel-to-support-shortcut-fe.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/954-net-patch-linux-kernel-to-support-qca-nss-sfe.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/970-export-efivarfs-function.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/992-add-ndo-do-ioctl.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/999-add-fibocom-id-and-zeropacket.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch

wget -P ./target/linux/generic/pending-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-6.1/709-Revert-net-mlx4_en-Update-reported-link-modes-for-1-.patch
