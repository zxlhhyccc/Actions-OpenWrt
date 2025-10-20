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

# x86(5.15-6.6)：改进英特尔第 11/12 代 GPU i915 和 GVT-g 功能
rm -rf ./target/linux/x86
cp -rf ./acc-imq-bbr/master/target/linux/x86 ./target/linux/

# 内核：添加6.1内核ACC、shortcut-fe补丁
rm -f ./target/linux/generic/config-6.6
wget -P ./target/linux/generic/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/config-6.6

wget -P ./target/linux/generic/backport-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-6.6/999-convert_official_linux-6.6.x_src_to_bbrplus.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch

wget -P ./target/linux/generic/hack-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.6/763-net-phy-motorcomm-add-LED-configuration-for-yt85xx.patch

wget -P ./target/linux/generic/hack-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.6/952-add-net-conntrack-events-support-multiple-registrant.patch

wget -P ./target/linux/generic/hack-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.6/953-net-patch-linux-kernel-to-support-shortcut-fe.patch

wget -P ./target/linux/generic/hack-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.6/954-net-patch-linux-kernel-to-support-qca-nss-sfe.patch

# 给kernel(6.6)添加 bcm fullconenat补丁
wget -P ./target/linux/generic/hack-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.6/982-add-bcm-fullconenat-support.patch

wget -P ./target/linux/generic/hack-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.6/983-bcm-fullconenat-mod-nft-masq

wget -P ./target/linux/generic/hack-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.6/992-add-ndo-do-ioctl.patch

wget -P ./target/linux/generic/hack-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.6/998-revert-genetlink-remove-userhdr-from-struct-genl_inf.patch

wget -P ./target/linux/generic/hack-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.6/999-revert-6.5-deprecated-API.patch

wget -P ./target/linux/generic/hack-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.6/9999-902-net-core-prevent-BPF-pull-GROed-skb-fraglist.patch

wget -P ./target/linux/generic/pending-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-6.6/613-netfilter_optional_tcp_window_check.patch

wget -P ./target/linux/generic/pending-6.6/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-6.6/901-usb-add-more-modem-support.patch

rm -rf acc-imq-bbr

