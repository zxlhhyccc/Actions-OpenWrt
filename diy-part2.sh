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

# rc.common兼容新旧格式插件
# wget -P ./package/base-files/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/base-files/001-fix-rc.common.patch
# pushd package/base-files
# patch -p1 < 001-fix-rc.common.patch
# popd
# rm -f ./feeds/packages/lang/python/python3/files/python3-package-ctypes.mk
# wget -P ./feeds/packages/lang/python/python3/files/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/lang/python/python3/files/python3-package-ctypes.mk

wget -P ./package/base-files/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/base-files/files/etc/init.d/patches/001-boot.patch
pushd package/base-files
patch -p1 < 001-boot.patch
popd

wget -P ./package/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/001-Makefile-force-overwrite.patch
pushd package
patch -p1 < 001-Makefile-force-overwrite.patch
popd
# 添加、修复iwinfo适配K2P闭源驱动补丁
wget -P ./package/network/utils/iwinfo/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/utils/iwinfo/patches/001-ralink-k2p.patch
pushd package/network/utils/iwinfo
patch -p1 < 001-ralink-k2p.patch
popd
# 添加mbedtls补丁
wget -P ./package/libs/mbedtls/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/libs/mbedtls/patches/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch
# 添加默认编译包
rm -f ./include/target.mk
wget -P ./include/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/include/target.mk
rm -f ./include/netfilter.mk
wget -P ./include/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/include/netfilter.mk
# kernel支持及修改连接数
rm -f ./package/kernel/linux/modules/crypto.mk
wget -P ./package/kernel/linux/modules/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/linux/modules/crypto.mk
rm -f ./package/kernel/linux/modules/lib.mk
wget -P ./package/kernel/linux/modules/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/linux/modules/lib.mk
rm -f ./package/kernel/linux/modules/other.mk
wget -P ./package/kernel/linux/modules/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/linux/modules/other.mk

rm -f ./package/kernel/linux/modules/netdevices.mk
wget -P ./package/kernel/linux/modules/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/linux/modules/netdevices.mk
rm -f ./package/kernel/linux/modules/netfilter.mk
wget -P ./package/kernel/linux/modules/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/linux/modules/netfilter.mk
sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
sed -i 's/7440/7200/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
# 修改network中防火墙等源码包
wget -P ./package/network/config/firewall/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/config/firewall/001-add-fullconenat.patch
pushd package/network/config/firewall
patch -p1 < 001-add-fullconenat.patch
popd
wget -P ./package/network/utils/iptables/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/utils/iptables/001-IMQ-gargoyle-netfilter-match-modules.patch
pushd package/network/utils/iptables
patch -p1 < 001-IMQ-gargoyle-netfilter-match-modules.patch
popd
wget -P ./package/network/utils/iproute2/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/utils/iproute2/001-add-qos-gargoyle.patch
pushd package/network/utils/iproute2
patch -p1 < 001-add-qos-gargoyle.patch
popd

svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/package/network/services/shellsync package/network/services/shellsync

wget -P ./package/network/services/ppp/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/ppp/patches/001-ppp-add-shellsync-support.patch
pushd package/network/services/ppp
patch -p1 < 001-ppp-add-shellsync-support.patch
popd
# MWAN3回退到2.8.16版本以适配多拨
rm -rf ./feeds/packages/net/mwan3
svn co https://github.com/openwrt/packages/branches/openwrt-19.07/net/mwan3 feeds/packages/net/mwan3
# 关闭https-dns-proxy自启动
wget -P ./feeds/packages/net/https-dns-proxy/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/https-dns-proxy/patches/001-not-started.patch
pushd feeds/packages/net/https-dns-proxy
patch -p1 < 001-not-started.patch
popd
# wget软链接到/usr/bin的二进制文件，以便与其他文件兼容
wget -P ./feeds/packages/net/wget/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/wget/patches/001-soft-link-binary-file-to-usr-bin.patch
pushd feeds/packages/net/wget
patch -p1 < 001-soft-link-binary-file-to-usr-bin.patch
popd
svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/net/wget/wget/patches feeds/packages/net/wget/patches
# 修改feeds里的luci-app-firewall加速开关等源码包
wget -P ./feeds/luci/applications/luci-app-firewall/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/applications/luci-app-firewall/patches/001-luci-app-firewall-Enable-FullCone-NAT.patch
pushd feeds/luci/applications/luci-app-firewall
patch -p1 < 001-luci-app-firewall-Enable-FullCone-NAT.patch
popd
# 添加wifi的MU-MIMO功能
wget -P ./feeds/luci/modules/luci-mod-network/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/modules/luci-mod-network/patches/001-wifi-add-MU-MIMO-option.patch
pushd feeds/luci/modules/luci-mod-network
patch -p1 < 001-wifi-add-MU-MIMO-option.patch
popd
# 更新htop、libyaml-cpp
rm -rf ./feeds/packages/admin/htop
svn co https://github.com/project-openwrt/packages/trunk/admin/htop feeds/packages/admin/htop
# rm -rf ./feeds/packages/libs/libyaml-cpp
# svn co https://github.com/project-openwrt/packages/trunk/libs/libyaml-cpp feeds/packages/libs/libyaml-cpp
# 添加5.4内核ACC、shortcut-fe、bbrplus补丁
rm -f ./target/linux/generic/hack-5.4/250-netfilter_depends.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/250-netfilter_depends.patch
rm -f ./target/linux/generic/hack-5.4/650-netfilter-add-xt_OFFLOAD-target.patch
wget -P ./target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/650-netfilter-add-xt_OFFLOAD-target.patch
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
wget -P target/linux/generic/hack-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/hack-5.4/9999-convert_official_linux-5.4.x_src_to_bbrplus.patch
# 修复pending-5.4部分补丁及添加imq模块补丁
wget -P target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch
wget -P target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/601-add-kernel-imq-support.patch
rm -f ./target/linux/generic/pending-5.4/655-increase_skb_pad.patch
wget -P ./target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/655-increase_skb_pad.patch
rm -f ./target/linux/generic/pending-5.4/680-NET-skip-GRO-for-foreign-MAC-addresses.patch
wget -P ./target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/680-NET-skip-GRO-for-foreign-MAC-addresses.patch
rm -f ./target/linux/generic/pending-5.4/690-net-add-support-for-threaded-NAPI-polling.patch
wget -P ./target/linux/generic/pending-5.4/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/pending-5.4/690-net-add-support-for-threaded-NAPI-polling.patch
rm -f ./target/linux/generic/config-5.4
wget -P ./target/linux/generic/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/config-5.4
# mwlwifi添加disable-amsdu补丁
wget -P package/kernel/mwlwifi/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/mwlwifi/patches/002-disable-AMSDU.patch
# 给luci-base添加无线图标及使用busybox设置passwd
wget -P feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons/wifi_big.png
wget -P ./feeds/luci/modules/luci-base/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/modules/luci-base/patches/001-let-passwd-using-busybox.patch
pushd feeds/luci/modules/luci-base
patch -p1 < 001-let-passwd-using-busybox.patch
popd
# wireless-regdb：自定义更改txpower和dfs的补丁
wget -P package/firmware/wireless-regdb/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/firmware/wireless-regdb/patches/600-custom-change-txpower-and-dfs.patch
# 添加upx压缩源码
svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/tools/ucl tools/ucl
svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/tools/upx tools/upx
rm -f ./tools/Makefile
wget -P ./tools/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/tools/Makefile
# 去除feeds中的material主题多余openwrt名
sed -i 's#boardinfo.hostname or "?"#""#g' feeds/luci/themes/luci-theme-material/luasrc/view/themes/material/header.htm
# 将tty、ksmd所在服务目录改到系统、网络存储目录
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-ksmbd/root/usr/share/luci/menu.d/luci-app-ksmbd.json
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
# 添加feeds里的依赖包
# svn co https://github.com/project-openwrt/packages/trunk/lang/node-yarn feeds/packages/lang/node-yarn
svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/lang/python/Flask-RESTful feeds/packages/lang/python/Flask-RESTful
svn co https://github.com/project-openwrt/packages/trunk/libs/opencv feeds/packages/libs/opencv
svn co https://github.com/openwrt/packages/branches/openwrt-19.07/libs/fcgi feeds/packages/libs/fcgi
svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/libs/libdouble-conversion feeds/packages/libs/libdouble-conversion
# 添加dnamasq的IPV6展示
wget -P ./package/network/services/dnsmasq/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/0001-dnsmasq-add-filter-aaaa-option.patch
pushd package/network/services/dnsmasq
patch -p1 < 0001-dnsmasq-add-filter-aaaa-option.patch
popd
wget -P ./feeds/luci/modules/luci-mod-network/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/0001-luci-add-filter-aaaa-option.patch
pushd feeds/luci/modules/luci-mod-network
patch -p1 < 0001-luci-add-filter-aaaa-option.patch
popd
wget -P ./package/network/services/dnsmasq/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/910-mini-ttl.patch
wget -P ./package/network/services/dnsmasq/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/911-add-filter-aaaa-option.patch
# 添加dnamasq的多核心dns负载均衡解析
wget -P ./package/network/services/dnsmasq/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/001-auto-multiple-service-instances.patch
pushd package/network/services/dnsmasq
patch -p1 < 001-auto-multiple-service-instances.patch
popd
# 添加k2p的lan/wan
wget -P ./target/linux/ramips/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/ramips/patches/000-k2p-network.patch
pushd target/linux/ramips
patch -p1 < 000-k2p-network.patch
popd
wget -P ./target/linux/ramips/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/ramips/patches/0003-mt7621.dtsi-add-missing-pinctrl-to-ethernet-node.patch
pushd target/linux/ramips
patch -p1 < 0003-mt7621.dtsi-add-missing-pinctrl-to-ethernet-node.patch
popd
wget -P ./target/linux/ramips/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/ramips/patches/overclock-mt7621.patch
pushd target/linux/ramips
patch -p1 < overclock-mt7621.patch
popd
# rtl8812au-ac：更新无线5.8
# svn co https://github.com/project-openwrt/openwrt/branches/master/package/kernel/rtl8812au-ac package/kernel/rtl8812au-ac
# 修改transmission依赖
wget -P ./feeds/packages/net/transmission-web-control/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/transmission-web-control/patches/001-transmission-web-control-dbengine.patch
pushd feeds/packages/net/transmission-web-control
patch -p1 < 001-transmission-web-control-dbengine.patch
popd
wget -P ./feeds/luci/applications/luci-app-transmission/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/applications/luci-app-transmission/patches/001-luci-app-transmission-with-dbengine.patch
pushd feeds/luci/applications/luci-app-transmission
patch -p1 < 001-luci-app-transmission-with-dbengine.patch
popd
# 修改sqm-scripts汉化help
svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/net/sqm-scripts/patches feeds/packages/net/sqm-scripts/patches
rm -rf ./feeds/packages/net/sqm-scripts/patches/.svn
# 修复新版luci的cpu等寄存器显示
wget -P ./feeds/luci/modules/luci-mod-status/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/modules/luci-mod-status/patches/001-luci-mod-status-fix-register-functions.patch
pushd feeds/luci/modules/luci-mod-status
patch -p1 < 001-luci-mod-status-fix-register-functions.patch
popd
wget -P ./feeds/luci/modules/luci-mod-status/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/modules/luci-mod-status/patches/002-luci-mod-status-drop-lluci.ver-display.patch
pushd feeds/luci/modules/luci-mod-status
patch -p1 < 002-luci-mod-status-drop-lluci.ver-display.patch
popd
# 添加netdata显示中文日期补丁及升级到1.22.1
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
wget -P ./feeds/packages/admin/netdata/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/admin/netdata/patches/000-netdata-delete-config.patch
pushd feeds/packages/admin/netdata
patch -p1 < 000-netdata-delete-config.patch
popd
wget -P ./feeds/packages/admin/netdata/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/admin/netdata/patches/005-netdata.patch
pushd feeds/packages/admin/netdata
patch -p1 < 005-netdata.patch
popd
# svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/libs/libJudy feeds/packages/libs/libJudy
# luci-lib-jsoncs使用int64
wget -P ./feeds/luci/libs/luci-lib-jsonc/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/libs/luci-lib-jsonc/patches/0001-use_json_object_new_int64.patch
pushd feeds/luci/libs/luci-lib-jsonc
patch -p1 < 0001-use_json_object_new_int64.patch
popd
# 修正adblock.init
wget -P ./feeds/packages/net/adblock/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/adblock/patches/001-adblock.patch
pushd feeds/packages/net/adblock
patch -p1 < 001-adblock.patch
popd
# 屏蔽socat/openvpn的与luci冲突的config、init以编译luci
wget -P ./feeds/packages/net/socat/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/socat/patches/001-shield-socat-config-init.patch
pushd feeds/packages/net/socat
patch -p1 < 001-shield-socat-config-init.patch
popd
wget -P ./feeds/packages/net/openvpn/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/openvpn/patches/001-shield-config.patch
pushd feeds/packages/net/openvpn
patch -p1 < 001-shield-config.patch
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
# 添加aria2补丁
svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/net/aria2/patches feeds/packages/net/aria2/patches

# 删除feeds里的与自有包冲突插件
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
# ramips: mt7621 OC 1000 MHz
rm -f ./target/linux/ramips/patches-5.4/102-mt7621-fix-cpu-clk-add-clkdev.patch
wget -P ./target/linux/ramips/patches-5.4/ https://raw.githubusercontent.com/project-openwrt/openwrt/master/target/linux/ramips/patches-5.4/102-mt7621-fix-cpu-clk-add-clkdev.patch
# 替换acc
# rm -rf ./package/openwrt-package/lean/luci-app-flowoffload-master
# pushd package/openwrt-package/lean
# unzip luci-app-flowoffload-master-NAT.zip
# popd
# 打开wifi并设置区域为US
wget -P ./package/kernel/mac80211/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/mac80211/patches/001-wifi-auto.patch
pushd package/kernel/mac80211
patch -p1 < 001-wifi-auto.patch
popd
# mac80211：为ath / subsys：在2g上允许vht添加补丁
wget -P ./package/kernel/mac80211/patches/subsys/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/mac80211/patches/subsys/600-mac80211-allow-vht-on-2g.patch
wget -P ./package/kernel/mac80211/patches/ath/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/kernel/mac80211/patches/ath/983-ath10k-allow-vht-on-2g.patch
# 修正友善补丁(R2S/R4S)
rm -rf package/boot/uboot-rockchip
svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/boot/uboot-rockchip package/boot/uboot-rockchip
rm -rf target/linux/rockchip
svn co https://github.com/immortalwrt/immortalwrt/branches/master/target/linux/rockchip target/linux/rockchip
svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/boot/arm-trusted-firmware-rk3328 package/boot/arm-trusted-firmware-rk3328

# busybox：为docker top命令添加ps -ef选项的补丁
wget -P ./package/utils/busybox/patches/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/utils/busybox/patches/900-add-e-f-option-for-docker.patch

# mvebu 添加cpu显示
rm -rf target/linux/mvebu/Makefile
wget -P ./target/linux/mvebu/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/mvebu/Makefile
