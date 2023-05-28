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

# 内核：为 BPF_STREAM_PARSER 和 XDP_SOCKETS_DIAG 添加选项
wget -P ./config/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/config/001-add-NMODULE_ALLOW_BTF_MISMATCH-and-XDP_SOCKETS_DIAG-option.patch
pushd config
patch -p1 < 001-add-NMODULE_ALLOW_BTF_MISMATCH-and-XDP_SOCKETS_DIAG-option.patch
rm -f 001-add-NMODULE_ALLOW_BTF_MISMATCH-and-XDP_SOCKETS_DIAG-option.patch
popd

# 给kernel(6.1)添加 bcm fullconenat补丁
wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/982-add-bcm-fullconenat-support.patch

# 内核：添加6.1内核ACC、shortcut-fe补丁
rm -f ./target/linux/generic/config-6.1
wget -P ./target/linux/generic/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/config-6.1

rm -f ./target/linux/generic/hack-6.1/901-debloat_sock_diag.patch
wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/901-debloat_sock_diag.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/WYC-2020-952-add-net-conntrack-events-support-multiple-registrant.patch
mv target/linux/generic/hack-6.1/WYC-2020-952-add-net-conntrack-events-support-multiple-registrant.patch target/linux/generic/hack-6.1/952-add-net-conntrack-events-support-multiple-registrant

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/953-net-patch-linux-kernel-to-support-shortcut-fe.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/970-export-efivarfs-function.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-6.1/992-add-ndo-do-ioctl.patch

wget -P ./target/linux/generic/hack-6.1/ https://github.com/zxlhhyccc/acc-imq-bbr/blob/master/master/target/linux/generic/hack-6.1/999-add-fibocom-id-and-zeropacket.patch
