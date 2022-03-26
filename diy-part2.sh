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

# openssl：支持NSS-AES-GCM加速
wget -P ./package/libs/openssl/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/libs/openssl/001-NSS-Supports-AES-GCM-acceleration.patch
pushd package/libs/openssl
patch -p1 < 001-NSS-Supports-AES-GCM-acceleration.patch
rm -f 001-NSS-Supports-AES-GCM-acceleration.patch
popd

# k3screenctrl：修复 PHICOMM K3 屏幕显示关闭
wget -P ./target/linux/bcm53xx/patches-5.4/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/bcm53xx/patches-5.4/906-BCM5301x-uart1.patch
wget -P ./target/linux/bcm53xx/patches-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/bcm53xx/patches-5.10/906-BCM5301x-uart1.patch

# x86使用 BCM578xx绕过 HH3K 高达 2.5Gbps
wget -P ./target/linux/x86/patches-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.10/900-x86-Enable-fast-strings-on-Intel-if-BIOS-hasn-t-already.patch
wget -P ./target/linux/x86/patches-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.10/993-bnx2x_warpcore_8727_2_5g_sgmii_txfault.patch

# hostpad添加vendor_vht模块支持
wget -P ./package/network/services/hostapd/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/services/hostapd/001-add-vendor_vht.patch
pushd package/network/services/hostapd
patch -p1 < 001-add-vendor_vht.patch
rm -f 001-add-vendor_vht.patch
popd

# nginx添加njs模块支持
wget -P ./feeds/packages/net/nginx/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/nginx/001-nginx-add-njs-module.patch
pushd feeds/packages/net/nginx
patch -p1 < 001-nginx-add-njs-module.patch
rm -f 001-nginx-add-njs-module.patch
popd

# 添加uclibc++支持
wget -P ./ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/001-add-uclibc%2B%2B.patch
patch -p1 < 001-add-uclibc++.patch
rm -f 001-add-uclibc++.patch

# 添加gcc7.5、gcc9.3编译支持
# wget -P ./ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/001-rules.patch
# patch -p1 < 001-rules.patch
# rm -f 001-rules.patch
# wget -P ./ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/toolchain/001-add-gcc7-gcc9.3-support.patch
# patch -p1 < 001-add-gcc7-gcc9.3-support.patch
# rm -f 001-add-gcc7-gcc9.3-support.patch

# 暂回退mariadb源码用于openwrt-filerun的依赖
wget -P ./feeds/packages/utils/mariadb/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/utils/mariadb/001-add-mariadb-client-base.patch
pushd feeds/packages/utils/mariadb
patch -p1 < 001-add-mariadb-client-base.patch
rm -f 001-add-mariadb-client-base.patch
popd

# shadowsocks-libev更新源码
wget -P ./feeds/packages/net/shadowsocks-libev/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/shadowsocks-libev/002-update-makefile.patch
pushd feeds/packages/net/shadowsocks-libev
patch -p1 < 002-update-makefile.patch
rm -f 002-update-makefile.patch
popd

wget -P package/base-files/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/base-files/files/etc/init.d/patches/001-boot.patch
pushd package/base-files
patch -p1 < 001-boot.patch
rm -f 001-boot.patch
popd

wget -P ./package/base-files/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/base-files/files/bin/001-tweak-default-ntp-servers.patch
pushd package/base-files
patch -p1 < 001-tweak-default-ntp-servers.patch
rm -f 001-tweak-default-ntp-servers.patch
popd

# wget -P ./package/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/001-Makefile-force-overwrite.patch
# pushd package
# patch -p1 < 001-Makefile-force-overwrite.patch
# rm -f 001-Makefile-force-overwrite.patch
# popd

wget -P ./feeds/packages/libs/libsodium/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/libs/libsodium/001-latest.patch
pushd feeds/packages/libs/libsodium
patch -p1 < 001-latest.patch
rm -f 001-latest.patch
popd
# luci-app-nft-qos: simple
wget -P ./feeds/luci/applications/luci-app-nft-qos/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/applications/luci-app-nft-qos/001-luci-app-nft-qos-simple.patch
pushd feeds/luci/applications/luci-app-nft-qos
patch -p1 < 001-luci-app-nft-qos-simple.patch
rm -f 001-luci-app-nft-qos-simple.patch
popd
# luci-app-mwan3接口系列双堆栈（ipv4 + ipv6）支持
# wget -P ./feeds/luci/applications/luci-app-mwan3/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/applications/luci-app-mwan3/001-interface-family-dual-stack-ipv4oripv6-support.patch
# pushd feeds/luci/applications/luci-app-mwan3
# patch -p1 < 001-interface-family-dual-stack-ipv4oripv6-support.patch
# rm -f 001-interface-family-dual-stack-ipv4oripv6-support.patch
# popd
# 添加、修复iwinfo适配K2P闭源驱动补丁
wget -P ./package/network/utils/iwinfo/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/utils/iwinfo/patches/101-ralink-k2p.patch
pushd package/network/utils/iwinfo
patch -p1 < 101-ralink-k2p.patch
rm -f 101-ralink-k2p.patch
popd
# 添加mbedtls:AES-and-GCM-with-ARMv8-Crypto-Extensions.patch补丁
wget -P ./package/libs/mbedtls/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/libs/mbedtls/001-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch
pushd package/libs/mbedtls
patch -p1 < 001-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch
rm -f 001-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch
popd
# 添加默认编译包
rm -f ./include/target.mk
wget -P ./include/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/include/target.mk
rm -f ./include/netfilter.mk
wget -P ./include/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/include/netfilter.mk
# kernel支持及修改连接数
# 1.给kernel的crypto.mk、lib.mk、other.mk添加模块
wget -P ./package/kernel/linux/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/linux/001-compressed-memory.patch
pushd package/kernel/linux
patch -p1 < 001-compressed-memory.patch
rm -f 001-compressed-memory.patch
popd
# 2.给kernel的netdevices.mk、netfilter.mk添加模块
wget -P ./package/kernel/linux/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/linux/001-netdevices.mk-netfilter.mk.patch
pushd package/kernel/linux
patch -p1 < 001-netdevices.mk-netfilter.mk.patch
rm -f 001-netdevices.mk-netfilter.mk.patch
popd
# 3.给kernel的video.mk添加模块
wget -P ./package/kernel/linux/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/linux/001-video-add-multimedia-input.patch
pushd package/kernel/linux
patch -p1 < 001-video-add-multimedia-input.patch
rm -f 001-video-add-multimedia-input.patch
popd
# 4.给netsupport.mk 添加bbrplus、nanqinlang等模块
wget -P ./package/kernel/linux/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/linux/001-netsupport.mk-add-bbrplus.patch
pushd package/kernel/linux
patch -p1 < 001-netsupport.mk-add-bbrplus.patch
rm -f 001-netsupport.mk-add-bbrplus.patch
popd
# 5.给kernel(5.4)添加bbrplus、nanqinlang等模块补丁
wget -P ./target/linux/generic/backport-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.4/999-net-tcp-add-bbrplus.patch
wget -P ./target/linux/generic/backport-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.4/999-net-tcp-add-nanqinlang.patch
wget -P ./target/linux/generic/backport-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.4/999-net-tcp-add-tsunami.patch
wget -P ./target/linux/generic/backport-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.4/999-net-tcp-add-tsunamio.patch
# 6.给kernel(5.10)添加bbrplus、nanqinlang等模块补丁
# wget -P ./target/linux/generic/backport-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.10/350-v5.12-NFSv4_2-SSC-helper-should-use-its-own-config.patch
# wget -P ./target/linux/generic/backport-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.10/351-v5.13-NFSv4_2-Remove-ifdef-CONFIG_NFSD-from-client-SSC.patch
# wget -P ./target/linux/generic/backport-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.10/610-v5.13-54-net-ethernet-mtk_eth_soc-add-ipv6-flow-offloading-support.patch
rm -f ./target/linux/generic/backport-5.10/780-v5.11-net-usb-r8152-Provide-missing-documentation-for-some.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/780-v5.11-net-usb-r8152-Provide-missing-documentation-for-some.patch
rm -f ./target/linux/generic/backport-5.10/781-v5.11-net-usb-r8152-Fix-a-couple-of-spelling-errors-in-fw_.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/781-v5.11-net-usb-r8152-Fix-a-couple-of-spelling-errors-in-fw_.patch
rm -f ./target/linux/generic/backport-5.10/782-v5.11-net-usb-r8153_ecm-support-ECM-mode-for-RTL8153.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/782-v5.11-net-usb-r8153_ecm-support-ECM-mode-for-RTL8153.patch
rm -f ./target/linux/generic/backport-5.10/783-v5.12-net-usb-r8152-use-new-tasklet-API.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/783-v5.12-net-usb-r8152-use-new-tasklet-API.patch
rm -f ./target/linux/generic/backport-5.10/784-v5.12-r8152-replace-several-functions-about-phy-patch-requ.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/784-v5.12-r8152-replace-several-functions-about-phy-patch-requ.patch
rm -f ./target/linux/generic/backport-5.10/785-v5.12-r8152-adjust-the-flow-of-power-cut-for-RTL8153B.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/785-v5.12-r8152-adjust-the-flow-of-power-cut-for-RTL8153B.patch
rm -f ./target/linux/generic/backport-5.10/786-v5.12-r8152-enable-U1-U2-for-USB_SPEED_SUPER.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/786-v5.12-r8152-enable-U1-U2-for-USB_SPEED_SUPER.patch
rm -f ./target/linux/generic/backport-5.10/787-v5.12-r8152-check-if-the-pointer-of-the-function-exists.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/787-v5.12-r8152-check-if-the-pointer-of-the-function-exists.patch
rm -f ./target/linux/generic/backport-5.10/788-v5.12-r8152-replace-netif_err-with-dev_err.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/788-v5.12-r8152-replace-netif_err-with-dev_err.patch
rm -f ./target/linux/generic/backport-5.10/789-v5.12-r8152-spilt-rtl_set_eee_plus-and-r8153b_green_en.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/789-v5.12-r8152-spilt-rtl_set_eee_plus-and-r8153b_green_en.patch
rm -f ./target/linux/generic/backport-5.10/790-v5.13-r8152-set-inter-fram-gap-time-depending-on-speed.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/790-v5.13-r8152-set-inter-fram-gap-time-depending-on-speed.patch
rm -f ./target/linux/generic/backport-5.10/791-v5.13-r8152-adjust-rtl8152_check_firmware-function.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/791-v5.13-r8152-adjust-rtl8152_check_firmware-function.patch
rm -f ./target/linux/generic/backport-5.10/792-v5.13-r8152-add-help-function-to-change-mtu.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/792-v5.13-r8152-add-help-function-to-change-mtu.patch
rm -f ./target/linux/generic/backport-5.10/793-v5.13-r8152-support-new-chips.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/793-v5.13-r8152-support-new-chips.patch
rm -f ./target/linux/generic/backport-5.10/794-v5.13-r8152-support-PHY-firmware-for-RTL8156-series.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/794-v5.13-r8152-support-PHY-firmware-for-RTL8156-series.patch
rm -f ./target/linux/generic/backport-5.10/795-v5.13-r8152-search-the-configuration-of-vendor-mode.patch
wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/795-v5.13-r8152-search-the-configuration-of-vendor-mode.patch

wget -P ./target/linux/generic/backport-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.10/999-net-tcp-add-bbrplus.patch
wget -P ./target/linux/generic/backport-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.10/999-net-tcp-add-nanqinlang.patch
wget -P ./target/linux/generic/backport-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.10/999-net-tcp-add-tsunami.patch
# 7、kernel修改连接数
sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
sed -i 's/7440/7200/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
# 8、修改network中防火墙等源码包
wget -P ./package/network/config/firewall/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/config/firewall/001-add-fullconenat.patch
pushd package/network/config/firewall
patch -p1 < 001-add-fullconenat.patch
rm -f 001-add-fullconenat.patch
popd
# wget -P ./package/network/config/firewall/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/config/firewall/001-fix-firewall-flock.patch
# pushd package/network/config/firewall
# patch -p1 < 001-fix-firewall-flock.patch
# rm -f 001-fix-firewall-flock.patch
# popd
wget -P ./package/network/config/firewall/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/config/firewall/001-add-reload-config-for-triggers.patch
pushd package/network/config/firewall
patch -p1 < 001-add-reload-config-for-triggers.patch
rm -f 001-add-reload-config-for-triggers.patch
popd

wget -P ./package/network/utils/iptables/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/utils/iptables/001-IMQ-gargoyle-netfilter-match-modules.patch
pushd package/network/utils/iptables
patch -p1 < 001-IMQ-gargoyle-netfilter-match-modules.patch
rm -f 001-IMQ-gargoyle-netfilter-match-modules.patch
popd
wget -P ./package/network/utils/iproute2/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/utils/iproute2/001-add-qos-gargoyle.patch
pushd package/network/utils/iproute2
patch -p1 < 001-add-qos-gargoyle.patch
rm -f 001-add-qos-gargoyle.patch
popd

svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/package/network/services/shellsync package/network/services/shellsync

wget -P ./package/network/services/ppp/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/ppp/patches/001-ppp-add-shellsync-support.patch
pushd package/network/services/ppp
patch -p1 < 001-ppp-add-shellsync-support.patch
rm -f 001-ppp-add-shellsync-support.patch
popd
# MWAN3回退到2.8.16版本以适配多拨
# rm -rf ./feeds/packages/net/mwan3
# svn co https://github.com/openwrt/packages/branches/openwrt-19.07/net/mwan3 feeds/packages/net/mwan3
# rm -rf ./feeds/packages/net/mwan3/.svn
# 9、luci-app-aria2开放路径修复
wget -P ./feeds/luci/applications/luci-app-aria2/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/applications/luci-app-aria2/001-luci-app-aria2-fix-open-path.patch
pushd feeds/luci/applications/luci-app-aria2
patch -p1 < 001-luci-app-aria2-fix-open-path.patch
rm -f 001-luci-app-aria2-fix-open-path.patch
popd
# 10、关闭https-dns-proxy自启动
wget -P ./feeds/packages/net/https-dns-proxy/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/https-dns-proxy/patches/001-not-started.patch
pushd feeds/packages/net/https-dns-proxy
patch -p1 < 001-not-started.patch
rm -f 001-not-started.patch
popd
# 11、wget软链接到/usr/bin的二进制文件，以便与其他文件兼容
wget -P ./feeds/packages/net/wget/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/wget/patches/001-soft-link-binary-file-to-usr-bin.patch
pushd feeds/packages/net/wget
patch -p1 < 001-soft-link-binary-file-to-usr-bin.patch
rm -f 001-soft-link-binary-file-to-usr-bin.patch
popd
wget -P ./feeds/packages/net/wget/patches/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/wget/wget/patches/001-prefer_ipv4.patch

# 12、修改feeds里的luci-app-firewall加速开关等源码包
wget -P ./feeds/luci/applications/luci-app-firewall/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/applications/luci-app-firewall/patches/001-luci-app-firewall-Enable-FullCone-NAT.patch
pushd feeds/luci/applications/luci-app-firewall
patch -p1 < 001-luci-app-firewall-Enable-FullCone-NAT.patch
rm -f 001-luci-app-firewall-Enable-FullCone-NAT.patch
popd
# 13、添加wifi的MU-MIMO功能
wget -P ./feeds/luci/modules/luci-mod-network/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/modules/luci-mod-network/patches/001-wifi-add-MU-MIMO-option.patch
pushd feeds/luci/modules/luci-mod-network
patch -p1 < 001-wifi-add-MU-MIMO-option.patch
rm -f 001-wifi-add-MU-MIMO-option.patch
popd
# 更新htop、libyaml-cpp
# rm -rf ./feeds/packages/admin/htop
# svn co https://github.com/immortalwrt/packages/trunk/admin/htop feeds/packages/admin/htop
# rm -rf ./feeds/packages/admin/htop/.svn
# rm -rf ./feeds/packages/libs/libyaml-cpp
# svn co https://github.com/project-openwrt/packages/trunk/libs/libyaml-cpp feeds/packages/libs/libyaml-cpp
# 14、添加5.4内核ACC、shortcut-fe、bbrplus补丁
rm -f ./target/linux/generic/hack-5.4/204-module_strip.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/204-module_strip.patch
rm -f ./target/linux/generic/hack-5.4/250-netfilter_depends.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/250-netfilter_depends.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/601-netfilter-export-udp_get_timeouts-function.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch
rm -f ./target/linux/generic/hack-5.4/650-netfilter-add-xt_OFFLOAD-target.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/650-netfilter-add-xt_OFFLOAD-target.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/652-netfilter-flow_offload-add-check-ifindex.patch
rm -f ./target/linux/generic/hack-5.4/661-use_fq_codel_by_default.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/661-use_fq_codel_by_default.patch
rm -f ./target/linux/generic/hack-5.4/662-remove_pfifo_fast.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/662-remove_pfifo_fast.patch
rm -f ./target/linux/generic/hack-5.4/721-phy_packets.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/721-phy_packets.patch
wget -P target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch
wget -P target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
wget -P target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/998-add-ndo-do-ioctl.patch
wget -P target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/999-thermal-tristate.patch
# 15、修复及添加5.10内核ACC、shortcut-fe、bbrplus补丁
rm -f ./target/linux/generic/hack-5.10/250-netfilter_depends.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/250-netfilter_depends.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/601-netfilter-export-udp_get_timeouts-function.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch
rm -f ./target/linux/generic/hack-5.10/650-netfilter-add-xt_FLOWOFFLOAD-target.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/650-netfilter-add-xt_FLOWOFFLOAD-target.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/652-netfilter-flow_offload-add-check-ifindex.patch
rm -f ./target/linux/generic/hack-5.10/721-net-add-packet-mangeling.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/721-net-add-packet-mangeling.patch
rm -f ./target/linux/generic/hack-5.10/760-net-usb-r8152-add-LED-configuration-from-OF.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/760-net-usb-r8152-add-LED-configuration-from-OF.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/952-net-conntrack-events-support-multiple-registrant.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/993-usb-serial-option-add-u9300.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/998-add-ndo-do-ioctl.patch
wget -P ./target/linux/generic/hack-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.10/999-thermal-tristate.patch
# wget -P target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/9999-convert_official_linux-5.4.x_src_to_bbrplus.patch
# 16、修复及添加pending-5.4部分补丁及添加imq模块补丁
# wget -P target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch
wget -P target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/601-add-kernel-imq-support.patch
rm -f ./target/linux/generic/pending-5.4/655-increase_skb_pad.patch
wget -P ./target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/655-increase_skb_pad.patch
rm -f ./target/linux/generic/pending-5.4/680-NET-skip-GRO-for-foreign-MAC-addresses.patch
wget -P ./target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/680-NET-skip-GRO-for-foreign-MAC-addresses.patch
# rm -f ./target/linux/generic/pending-5.4/681-NET-add-mtd-mac-address-support-to-of_get_mac_addres.patch
# wget -P ./target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/681-NET-add-mtd-mac-address-support-to-of_get_mac_addres.patch
rm -f ./target/linux/generic/pending-5.4/682-of_net-add-mac-address-increment-support.patch
wget -P ./target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/682-of_net-add-mac-address-increment-support.patch
rm -f ./target/linux/generic/pending-5.4/683-of_net-add-mac-address-to-of-tree.patch
wget -P ./target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/683-of_net-add-mac-address-to-of-tree.patch

rm -f ./target/linux/generic/config-5.4
wget -P ./target/linux/generic/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/config-5.4
# 17、修复及添加pending-5.10部分补丁及添加imq模块补丁
wget -P target/linux/generic/pending-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.10/601-add-kernel-imq-support.patch
rm -f ./target/linux/generic/pending-5.10/655-increase_skb_pad.patch
wget -P ./target/linux/generic/pending-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.10/655-increase_skb_pad.patch
rm -f ./target/linux/generic/pending-5.10/680-NET-skip-GRO-for-foreign-MAC-addresses.patch
wget -P ./target/linux/generic/pending-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.10/680-NET-skip-GRO-for-foreign-MAC-addresses.patch
rm -f ./target/linux/generic/pending-5.10/682-of_net-add-mac-address-increment-support.patch
wget -P ./target/linux/generic/pending-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.10/682-of_net-add-mac-address-increment-support.patch
rm -f ./target/linux/generic/pending-5.10/683-of_net-add-mac-address-to-of-tree.patch
wget -P ./target/linux/generic/pending-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.10/683-of_net-add-mac-address-to-of-tree.patch
rm -f ./target/linux/generic/pending-5.10/700-net-ethernet-mtk_eth_soc-avoid-creating-duplicate-of.patch
wget -P ./target/linux/generic/pending-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.10/700-net-ethernet-mtk_eth_soc-avoid-creating-duplicate-of.patch
rm -f ./target/linux/generic/config-5.10
wget -P ./target/linux/generic/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/config-5.10
rm -f ./target/linux/x86/Makefile
wget -P ./target/linux/x86/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/Makefile
# 18、mwlwifi添加disable-amsdu补丁
wget -P package/kernel/mwlwifi/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/mwlwifi/patches/002-disable-AMSDU.patch
# 19、给luci-base添加无线图标及使用busybox设置passwd
wget -P feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons/wifi_big.png
wget -P ./feeds/luci/modules/luci-base/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/modules/luci-base/patches/001-let-passwd-using-busybox.patch
pushd feeds/luci/modules/luci-base
patch -p1 < 001-let-passwd-using-busybox.patch
rm -f 001-let-passwd-using-busybox.patch
popd
# wget -P ./feeds/luci/modules/luci-base/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/modules/luci-base/patches/001-use-dev-conntrackinfo-ctl-if-exist.patch
# pushd feeds/luci/modules/luci-base
# patch -p1 < 001-use-dev-conntrackinfo-ctl-if-exist.patch
# rm -f 001-use-dev-conntrackinfo-ctl-if-exist.patch
# popd
# 20、wireless-regdb：自定义更改txpower和dfs的补丁
wget -P package/firmware/wireless-regdb/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/firmware/wireless-regdb/patches/600-custom-change-txpower-and-dfs.patch
# 21、添加upx压缩源码
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/tools/ucl tools/ucl

svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/tools/upx tools/upx

rm -f ./tools/Makefile
wget -P ./tools/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/tools/Makefile
# 22、去除feeds中的material主题多余openwrt名
sed -i '66 s#boardinfo.hostname or "?"#""#g' feeds/luci/themes/luci-theme-material/luasrc/view/themes/material/header.htm
# 23、将tty、ksmd所在服务目录改到系统、网络存储目录
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-ksmbd/root/usr/share/luci/menu.d/luci-app-ksmbd.json
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
# 24、添加feeds里的依赖包
# svn co https://github.com/project-openwrt/packages/trunk/lang/node-yarn feeds/packages/lang/node-yarn
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/lang/python/Flask-RESTful feeds/packages/lang/python/Flask-RESTful

svn export https://github.com/project-openwrt/packages/trunk/libs/opencv feeds/packages/libs/opencv

svn export https://github.com/openwrt/packages/branches/openwrt-19.07/libs/fcgi feeds/packages/libs/fcgi

svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/libs/libdouble-conversion feeds/packages/libs/libdouble-conversion

# 25、添加dnamasq的IPV6展示
wget -P ./package/network/services/dnsmasq/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/0001-dnsmasq-add-filteraaaa-https-unknown-option.patch
pushd package/network/services/dnsmasq
patch -p1 < 0001-dnsmasq-add-filteraaaa-https-unknown-option.patch
rm -f 0001-dnsmasq-add-filteraaaa-https-unknown-option.patch
popd
wget -P ./feeds/luci/modules/luci-mod-network/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/0001-luci-add-filteraaaa-https-unknown-option.patch
pushd feeds/luci/modules/luci-mod-network
patch -p1 < 0001-luci-add-filteraaaa-https-unknown-option.patch
rm -f 0001-luci-add-filteraaaa-https-unknown-option.patch
popd
wget -P ./package/network/services/dnsmasq/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/0001-dnsmasq-conf.patch
pushd package/network/services/dnsmasq
patch -p1 < 0001-dnsmasq-conf.patch
rm -f 0001-dnsmasq-conf.patch
popd
wget -P ./package/network/services/dnsmasq/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/910-mini-ttl.patch
wget -P ./package/network/services/dnsmasq/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/911-dnsmasq-filteraaaa-https-unknown.patch
# 26、添加dnamasq的多核心dns负载均衡解析
# wget -P ./package/network/services/dnsmasq/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/001-auto-multiple-service-instances.patch
# pushd package/network/services/dnsmasq
# patch -p1 < 001-auto-multiple-service-instances.patch
# rm -f 001-auto-multiple-service-instances.patch
# popd
# 27、添加k2p的lan/wan
wget -P ./target/linux/ramips/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/ramips/patches/000-k2p-network.patch
pushd target/linux/ramips
patch -p1 < 000-k2p-network.patch
rm -f 000-k2p-network.patch
popd
wget -P ./target/linux/ramips/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/ramips/patches/0003-mt7621.dtsi-add-missing-pinctrl-to-ethernet-node.patch
pushd target/linux/ramips
patch -p1 < 0003-mt7621.dtsi-add-missing-pinctrl-to-ethernet-node.patch
rm -f 0003-mt7621.dtsi-add-missing-pinctrl-to-ethernet-node.patch
popd
# wget -P ./target/linux/ramips/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/ramips/patches/overclock-mt7621.patch
# pushd target/linux/ramips
# patch -p1 < overclock-mt7621.patch
# rm -f overclock-mt7621.patch
# popd
# rtl8812au-ac：更新无线5.8
# svn co https://github.com/project-openwrt/openwrt/branches/master/package/kernel/rtl8812au-ac package/kernel/rtl8812au-ac
# 28、修改transmission依赖
wget -P ./feeds/packages/net/transmission-web-control/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/transmission-web-control/patches/001-transmission-web-control-dbengine.patch
pushd feeds/packages/net/transmission-web-control
patch -p1 < 001-transmission-web-control-dbengine.patch
rm -f 001-transmission-web-control-dbengine.patch
popd
wget -P ./feeds/luci/applications/luci-app-transmission/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/applications/luci-app-transmission/patches/001-luci-app-transmission-with-dbengine.patch
pushd feeds/luci/applications/luci-app-transmission
patch -p1 < 001-luci-app-transmission-with-dbengine.patch
rm -f 001-luci-app-transmission-with-dbengine.patch
popd
# 29、修改sqm-scripts汉化help
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/net/sqm-scripts/patches feeds/packages/net/sqm-scripts/patches

# 30、修复新版luci的cpu等寄存器显示
wget -P ./feeds/luci/modules/luci-mod-status/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/modules/luci-mod-status/patches/001-luci-mod-status-fix-register-functions.patch
pushd feeds/luci/modules/luci-mod-status
patch -p1 < 001-luci-mod-status-fix-register-functions.patch
rm -f 001-luci-mod-status-fix-register-functions.patch
popd
wget -P ./feeds/luci/modules/luci-mod-status/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/modules/luci-mod-status/patches/002-luci-mod-status-drop-lluci.ver-display.patch
pushd feeds/luci/modules/luci-mod-status
patch -p1 < 002-luci-mod-status-drop-lluci.ver-display.patch
rm -f 002-luci-mod-status-drop-lluci.ver-display.patch
popd
wget -P ./feeds/luci/modules/luci-mod-status/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/modules/luci-mod-status/patches/003-luci-mod-status-fix-align-of-OnlineUsers.patch
pushd feeds/luci/modules/luci-mod-status
patch -p1 < 003-luci-mod-status-fix-align-of-OnlineUsers.patch
rm -f 003-luci-mod-status-fix-align-of-OnlineUsers.patch
popd
# 31、添加netdata显示中文日期补丁及升级到1.22.1
# sed -i 's/1.20.0/1.22.1/g' feeds/packages/admin/netdata/Makefile
# sed -i 's/c739e0fa8d6d7f433c0c7c8016b763e8f70519d67f0b5e7eca9ee5318f210d90/6efd785eab82f98892b4b4017cadfa4ce1688985915499bc75f2f888765a3446/g' feeds/packages/admin/netdata/Makefile
# wget -P ./feeds/packages/admin/netdata/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/admin/netdata/patches/002-netdata-with-dbengine.patch
# pushd feeds/packages/admin/netdata
# patch -p1 < 002-netdata-with-dbengine.patch
# popd
# wget -P ./feeds/packages/admin/netdata/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/admin/netdata/patches/003-netdata-init-with-TZ.patch
# pushd feeds/packages/admin/netdata
# patch -p1 < 003-netdata-init-with-TZ.patch
# popd
# wget -P ./feeds/packages/admin/netdata/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/admin/netdata/patches/004-netdata-with-config.patch
# pushd feeds/packages/admin/netdata
# patch -p1 < 004-netdata-with-config.patch
# popd
# wget -P ./feeds/packages/admin/netdata/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/admin/netdata/patches/000-netdata-delete-config.patch
# pushd feeds/packages/admin/netdata
# patch -p1 < 000-netdata-delete-config.patch
# rm -f 000-netdata-delete-config.patch
# popd
# wget -P ./feeds/packages/admin/netdata/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/admin/netdata/patches/005-netdata.patch
# pushd feeds/packages/admin/netdata
# patch -p1 < 005-netdata.patch
# rm -f 005-netdata.patch
# popd
wget -P ./feeds/packages/admin/netdata/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/admin/netdata/patches/006-netdata.patch
pushd feeds/packages/admin/netdata
patch -p1 < 006-netdata.patch
rm -f 006-netdata.patch
popd
# svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/libs/libJudy feeds/packages/libs/libJudy
# 32、luci-lib-jsoncs使用int64
wget -P ./feeds/luci/libs/luci-lib-jsonc/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/libs/luci-lib-jsonc/patches/0001-use_json_object_new_int64.patch
pushd feeds/luci/libs/luci-lib-jsonc
patch -p1 < 0001-use_json_object_new_int64.patch
rm -f 0001-use_json_object_new_int64.patch
popd
# 33、修正adblock.init
wget -P ./feeds/packages/net/adblock/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/adblock/patches/001-adblock.patch
pushd feeds/packages/net/adblock
patch -p1 < 001-adblock.patch
rm -f 001-adblock.patch
popd
# 34、屏蔽socat/openvpn的与luci冲突的config、init以编译luci
wget -P ./feeds/packages/net/socat/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/socat/patches/001-shield-socat-config-init.patch
pushd feeds/packages/net/socat
patch -p1 < 001-shield-socat-config-init.patch
rm -f 001-shield-socat-config-init.patch
popd
wget -P ./feeds/packages/net/openvpn/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/openvpn/patches/001-shield-config.patch
pushd feeds/packages/net/openvpn
patch -p1 < 001-shield-config.patch
rm -f 001-shield-config.patch
popd
# 添加samba36
# svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/package/network/services/samba36 package/network/services/samba36
# svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/luci/applications/luci-app-samba feeds/luci/applications/luci-app-samba
# 添加python2
# svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/lang/python/python2 feeds/packages/lang/python/python2
# wget -P ./feeds/packages/lang/python/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/lang/python/python2-host.mk
# wget -P ./feeds/packages/lang/python/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/lang/python/python2-package-install.sh
# wget -P ./feeds/packages/lang/python/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/lang/python/python2-package.mk
# wget -P ./feeds/packages/lang/python/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/lang/python/python2-version.mk
# 35、添加aria2补丁和修复 ujail mount
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/net/aria2/patches feeds/packages/net/aria2/patches
wget -P ./feeds/packages/net/aria2/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/aria2/001-fix-ujail-mount.patch
pushd feeds/packages/net/aria2
patch -p1 < 001-fix-ujail-mount.patch
rm -f 001-fix-ujail-mount.patch
popd

# ntfs-3g: fix automount
wget -P ./feeds/packages/utils/ntfs-3g/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/utils/ntfs-3g/001-fix-automount.patch
pushd feeds/packages/utils/ntfs-3g
patch -p1 < 001-fix-automount.patch
rm -f 001-fix-automount.patch
popd

# 36、删除feeds里的与自有包冲突插件
rm -rf ./feeds/packages/net/adguardhome
rm -rf ./feeds/packages/net/frp
rm -rf ./feeds/packages/net/kcptun
rm -rf ./feeds/packages/net/smartdns
rm -rf ./feeds/packages/multimedia/tvheadend
rm -rf ./feeds/packages/utils/syncthing
rm -rf ./feeds/packages/utils/coremark
rm -rf ./feeds/packages/libs/libtorrent-rasterbar
rm -rf ./feeds/luci/applications/luci-app-frpc
rm -rf ./feeds/luci/applications/luci-app-frps
rm -rf ./feeds/luci/applications/luci-app-smartdns
# rm -rf ./feeds/luci/applications/luci-app-ksmbd
rm -rf ./package/openwrt-package/lean/luci-app-nft-qos
rm -rf ./package/openwrt-package/lean/nft-qos
rm -rf ./feeds/packages/net/xray-core
# 37、ramips: mt7621 OC 1000 MHz
rm -f ./target/linux/ramips/patches-5.4/102-mt7621-fix-cpu-clk-add-clkdev.patch
wget -P ./target/linux/ramips/patches-5.4/ https://raw.githubusercontent.com/project-openwrt/openwrt/master/target/linux/ramips/patches-5.4/102-mt7621-fix-cpu-clk-add-clkdev.patch
# 替换acc
# rm -rf ./package/openwrt-package/lean/luci-app-flowoffload-master
# pushd package/openwrt-package/lean
# unzip luci-app-flowoffload-master-NAT.zip
# popd
# 38、打开wifi并设置区域为US
wget -P ./package/kernel/mac80211/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/mac80211/patches/001-wifi-auto.patch
pushd package/kernel/mac80211
patch -p1 < 001-wifi-auto.patch
rm -f 001-wifi-auto.patch
popd
# 39、mac80211：为ath / subsys：在2g上允许vht添加补丁
wget -P ./package/kernel/mac80211/patches/subsys/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/mac80211/patches/subsys/600-mac80211-allow-vht-on-2g.patch
wget -P ./package/kernel/mac80211/patches/ath10k/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/mac80211/patches/ath10k/983-ath10k-allow-vht-on-2g.patch
# 40、修正友善补丁(R2S/R4S)
rm -rf package/boot/uboot-rockchip
svn export https://github.com/immortalwrt/immortalwrt/branches/master/package/boot/uboot-rockchip package/boot/uboot-rockchip

rm -rf target/linux/rockchip
svn export https://github.com/immortalwrt/immortalwrt/branches/master/target/linux/rockchip target/linux/rockchip

svn export https://github.com/immortalwrt/immortalwrt/branches/master/package/boot/arm-trusted-firmware-rockchip-vendor package/boot/arm-trusted-firmware-rockchip-vendor

# 41、busybox：为docker top命令添加ps -ef选项的补丁
wget -P ./package/utils/busybox/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/utils/busybox/patches/900-add-e-f-option-for-docker.patch

# 42、mvebu 添加cpu显示
# rm -rf target/linux/mvebu/Makefile
# wget -P ./target/linux/mvebu/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/mvebu/Makefile

# 44、sqlite3：添加对qt5的列元数据支持
wget -P ./feeds/packages/libs/sqlite3/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/libs/sqlite3/patches/001-add-column-metadata-support-for-qt5.patch
pushd feeds/packages/libs/sqlite3
patch -p1 < 001-add-column-metadata-support-for-qt5.patch
rm -f 001-add-column-metadata-support-for-qt5.patch
popd
