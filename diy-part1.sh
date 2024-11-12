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

git clone --depth 1 https://github.com/zxlhhyccc/acc-imq-bbr.git

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
# fix bios boot partition is under 1 MiB
sed -i 's/256/1024/g' target/linux/x86/image/Makefile

# squashfs：使mkfs具有多CPU加速和添加固件日期形式的编号
# sed -i 's/processors 1/processors $(shell nproc)/g' include/image.mk
# sed -i中特殊符号‘单引号的处理，sed中’'之间的’单引号特殊处理需要'"'"' (两个单引号中两个双引号再最里面是目标一个单引号)
sed -i '35i BUILD_DATE_PREFIX := $(shell TZ=UTC-8 date +'"'"'%Y%m%d%H%M'"'"')' include/image.mk
# 或所用以下命令添加（去掉前面的#）
# sed -i '35i BUILD_DATE_PREFIX := $(shell TZ=UTC-8 date +'%Y%m%d%H%M')' include/image.mk
# sed -i "s/%Y%m%d%H%M/\'%Y%m%d%H%M\'/g" include/image.mk
sed -i 's/$(VERSION_DIST_SANITIZED)/$(BUILD_DATE_PREFIX)-$(VERSION_DIST_SANITIZED)/g' include/image.mk
# 内核：为 BPF_STREAM_PARSER 和 XDP_SOCKETS_DIAG 添加选项
wget -P ./config/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/config/001-add-NMODULE_ALLOW_BTF_MISMATCH-and-XDP_SOCKETS_DIAG-option.patch
pushd config
patch -p1 < 001-add-NMODULE_ALLOW_BTF_MISMATCH-and-XDP_SOCKETS_DIAG-option.patch
rm -f 001-add-NMODULE_ALLOW_BTF_MISMATCH-and-XDP_SOCKETS_DIAG-option.patch
popd
# openssl：通过以下方式，使ARMv8设备适配ChaCha20-Poly1305而不是AES-GCM
# sed -i 's/default y if !x86_64 && !aarch64/default y if !x86_64/g' package/libs/openssl/Config.in
# K3默认驱动替换
wget -P ./target/linux/bcm53xx/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/bcm53xx/001-fix-dependency.patch
pushd target/linux/bcm53xx
patch -p1 < 001-fix-dependency.patch
rm -f 001-fix-dependency.patch
popd
# K3默认驱动还原
# sed -i 's/brcmfmac-firmware-4366c0-pcie-vendor/brcmfmac-firmware-4366c0-pcie/g' target/linux/bcm53xx/image/Makefile
# 只编译K3固件
# sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
# 还原编译k3的同架构所有固件
# sed -i 's|^# TARGET_|TARGET_|g' target/linux/bcm53xx/image/Makefile
# autocore-arm：添加目标sunxi支持
sed -i 's/uboot-envtools/autocore-arm uboot-envtools/g' target/linux/sunxi/Makefile
sed -i 's/kmod-input-core/kmod-multimedia-input/g' target/linux/sunxi/modules.mk
# 调整luci-app-nlbwmon显示菜单
wget -P ./feeds/luci/applications/luci-app-nlbwmon/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/applications/luci-app-nlbwmon/patches/001-change-to-separate-menu.patch
pushd feeds/luci/applications/luci-app-nlbwmon
patch -p1 < 001-change-to-separate-menu.patch
rm -f 001-change-to-separate-menu.patch
popd

# 将mac80211 的 wifi 脚本移动到 wifi-scripts
wget -P ./package/network/config/wifi-scripts/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/config/wifi-scripts/patches/001-add-vendor_vht.patch
pushd package/network/config/wifi-scripts
patch -p1 < 001-add-vendor_vht.patch
rm -f 001-add-vendor_vht.patch
popd

# 修改上移下移翻译
sed -i -e 's/value="<%:Up%>"/value="<%:Move up%>"/g' \
	-e 's/title="<%:Move up%>"/title="<%:Up%>"/g' \
	-e 's/value="<%:Down%>"/value="<%:Move down%>"/g' \
	-e 's/title="<%:Move down%>"/title="<%:Down%>"/g' \
	feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm

# musl：向后兼容 64 位定义
# wget -P ./ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/toolchain/musl/12667-backward-compatibility-with-64-bit-definitions.patch
# patch -p1 < 12667-backward-compatibility-with-64-bit-definitions.patch
# rm -f 12667-backward-compatibility-with-64-bit-definitions.patch

# sed -i "s#/services##g" feeds/luci/applications/luci-app-nlbwmon/root/usr/share/luci/menu.d/luci-app-nlbwmon.json
# sed -i "s#/services##g" feeds/luci/applications/luci-app-nlbwmon/htdocs/luci-static/resources/view/nlbw/config.js
# 开启无线及添加区域和禁用iw_qos_map_set
# sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# sed -i '179i set wireless.radio${devidx}.country=US' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# sed -i '/set wireless.radio${devidx}.country=US/c\                        set wireless.radio${devidx}.country=US' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# sed -i '180i set wireless.default_radio${devidx}.iw_qos_map_set=none' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# sed -i '/set wireless.default_radio${devidx}.iw_qos_map_set=none/c\                        set wireless.default_radio${devidx}.iw_qos_map_set=none' package/kernel/mac80211/files/lib/wifi/mac80211.sh

