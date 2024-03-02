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

# odhcpd：符合 RFC9096并允许配置首选有效生命周期的上限。
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/package/network/services/odhcpd/patches package/network/services/odhcpd/patches

# luci-app-ddns：修复启动/停止服务
wget -P ./feeds/luci/applications/luci-app-ddns/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/applications/luci-app-ddns/001-fix-start-stop-service.patch
pushd feeds/luci/applications/luci-app-ddns
patch -p1 < 001-fix-start-stop-service.patch
rm -f 001-fix-start-stop-service.patch
popd

# Zerotier：修复错误
# 1. 修复 config_path：创建并持久
# 2. 修复 Secret：支持identity.secret 
# 3. 修复 stop_instance：删除现有网络
wget -P ./feeds/packages/net/zerotier/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/zerotier/patches/0001-create-and-persist.patch
pushd feeds/packages/net/zerotier
patch -p1 < 0001-create-and-persist.patch
rm -f 0001-create-and-persist.patch
popd

# ddns 脚本：解决 ddns 启动问题
wget -P ./feeds/packages/net/ddns-scripts/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/ddns-scripts/001-workaround-ddns-boot-issue.patch
pushd feeds/packages/net/ddns-scripts
patch -p1 < 001-workaround-ddns-boot-issue.patch
rm -f 001-workaround-ddns-boot-issue.patch
popd

# fstools：启用任何具有非 MTD rootfs_data 卷的设备
wget -P ./package/system/fstools/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/system/fstools/001-enable-any-device-with-non-MTD-rootfs_data-volume.patch
pushd package/system/fstools
patch -p1 < 001-enable-any-device-with-non-MTD-rootfs_data-volume.patch
rm -f 001-enable-any-device-with-non-MTD-rootfs_data-volume.patch
popd

# mt76允许2.4GHz的VHT速率
wget -P ./package/kernel/mt76/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/mt76/patches/0001-mt76-allow-VHT-rate-on-2.4GHz.patch
pushd package/kernel/mt76
patch -p1 < 0001-mt76-allow-VHT-rate-on-2.4GHz.patch
rm -f 0001-mt76-allow-VHT-rate-on-2.4GHz.patch
popd

wget -P ./package/kernel/mt76/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/mt76/patches/0001-enable-wed-wireless-acc-filogic-target.patch
pushd package/kernel/mt76
patch -p1 < 0001-enable-wed-wireless-acc-filogic-target.patch
rm -f 0001-enable-wed-wireless-acc-filogic-target.patch
popd
# nat46：QCA NSS ECM 补丁
rm -rf package/kernel/nat46
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/package/kernel/nat46 package/kernel/nat46

# procd 修复服务参数处理
# wget -P ./package/system/procd/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/system/procd/patches/001-fix-service-arguments-processing.patch
# pushd package/system/procd
# patch -p1 < 001-fix-service-arguments-processing.patch
# rm -f 001-fix-service-arguments-processing.patch
# popd

# opkg 修复包冲突
wget -P ./package/system/opkg/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/system/opkg/patches/001-fix-package-conflicts.patch
pushd package/system/opkg
patch -p1 < 001-fix-package-conflicts.patch
rm -f 001-fix-package-conflicts.patch
popd

# nftables、libnftnl添加fullcone表达式支持
wget -P ./package/libs/libnftnl/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/libs/libnftnl/patches/001-libnftnl-add-fullcone-expression-support.patch
pushd package/libs/libnftnl
patch -p1 < 001-libnftnl-add-fullcone-expression-support.patch
rm -f 001-libnftnl-add-fullcone-expression-support.patch
popd

wget -P ./package/network/utils/nftables/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/utils/nftables/patches/0001-nftables-add-fullcone-expression-support.patch
pushd package/network/utils/nftables
patch -p1 < 0001-nftables-add-fullcone-expression-support.patch
rm -f 0001-nftables-add-fullcone-expression-support.patch
popd

# firewall4：在 ipv6 上禁用 fullcone nat
wget -P ./package/network/config/firewall4/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/config/firewall4/patches/001-firewall4-add-support-for-fullcone-nat.patch
pushd package/network/config/firewall4
patch -p1 < 001-firewall4-add-support-for-fullcone-nat.patch
rm -f 001-firewall4-add-support-for-fullcone-nat.patch
popd
# softethervpn添加150-disable-restriction.patch
wget -P ./feeds/packages/net/softethervpn/patches/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/softethervpn/patches/150-disable-restriction.patch

# 修复nlbwmon内存不足
wget -P ./feeds/packages/net/nlbwmon/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/nlbwmon/001-fix-out-of-memory.patch
pushd feeds/packages/net/nlbwmon
patch -p1 < 001-fix-out-of-memory.patch
rm -f 001-fix-out-of-memory.patch
popd

# openssl：支持NSS-AES-GCM加速
wget -P ./package/libs/openssl/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/libs/openssl/001-nss-aes-gcm-supports.patch
pushd package/libs/openssl
patch -p1 < 001-nss-aes-gcm-supports.patch
rm -f 001-nss-aes-gcm-supports.patch
popd

# k3screenctrl：修复 PHICOMM K3 屏幕显示关闭
# wget -P ./target/linux/bcm53xx/patches-5.4/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/bcm53xx/patches-5.4/906-BCM5301x-uart1.patch
# wget -P ./target/linux/bcm53xx/patches-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/bcm53xx/patches-5.10/906-BCM5301x-uart1.patch

# x86使用 BCM578xx绕过 HH3K 高达 2.5Gbps、kernle-5.15启用Straight-Line-Speculation（SLS）
# x86：从 Cloudflare 和 CRYPTO_XTS_AES_SYNC 添加 net.ipv4.tcp_collapse_max_bytes 选项
# x86(4.14-5.15)：改进英特尔第 11/12 代 GPU i915 和 GVT-g 功能
wget -P ./package/firmware/linux-firmware/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/firmware/linux-firmware/patches/001-x86-improve-Intel-gen-11-12th-GPU-i915-and-GVT-g-capability.patch
pushd package/firmware/linux-firmware
patch -p1 < 001-x86-improve-Intel-gen-11-12th-GPU-i915-and-GVT-g-capability.patch
rm -f 001-x86-improve-Intel-gen-11-12th-GPU-i915-and-GVT-g-capability.patch
popd

# 以下注释为相关功能优化情况
# svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/target/linux/x86/files target/linux/x86/files

# wget -P ./package/firmware/intel-microcode/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/firmware/intel-microcode/001-intel-microcode-update-3.20230214.1.patch
# pushd package/firmware/intel-microcode
# patch -p1 < 001-intel-microcode-update-3.20230214.1.patch
# rm -f 001-intel-microcode-update-3.20230214.1.patch
# popd

# wget -P ./target/linux/x86/patches-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.10/011-tune_lzma_options.patch

# wget -P ./target/linux/x86/patches-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.10/900-x86-Enable-fast-strings-on-Intel-if-BIOS-hasn-t-already.patch

# wget -P ./target/linux/x86/patches-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.10/993-bnx2x_warpcore_8727_2_5g_sgmii_txfault.patch

# wget -P ./target/linux/x86/patches-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.10/996-intel-igc-i225-i226-disable-eee.patch

# wget -P ./target/linux/x86/patches-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.15/800-add-rts5139.patch

# wget -P ./target/linux/x86/patches-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.15/992-enable-intel-guc.patch

# wget -P ./target/linux/x86/patches-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.15/993-bnx2x_warpcore_8727_2_5g_sgmii_txfault.patch

# wget -P ./target/linux/x86/patches-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.15/996-intel-igc-i225-i226-disable-eee.patch

# wget -P ./target/linux/x86/patches-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.15/998-add-a-sysctl-to-enable-disable-tcp_collapse-logic.patch

# wget -P ./target/linux/x86/patches-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/patches-5.15/999-Add-xtsproxy-Crypto-API-module.patch

# rm -f ./target/linux/x86/64/config-5.10
# wget -P ./target/linux/x86/64/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/64/config-5.10

# rm -f ./target/linux/x86/64/config-5.15
# wget -P ./target/linux/x86/64/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/64/config-5.15

# rm -f ./target/linux/x86/config-5.15
# wget -P ./target/linux/x86/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/config-5.15

# x86：将默认 swiotlb 大小增加到 64MB
# 由于 802.11be 可用，默认 swiotlb 大小从32 至 64MB，最多支持 2 个 Qualcomm WiFi 6E/7 网卡。
rm -rf ./target/linux/x86/image/grub-efi.cfg
wget -P ./target/linux/x86/image/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/image/grub-efi.cfg

rm -rf ./target/linux/x86/image/grub-pc.cfg
wget -P ./target/linux/x86/image/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/image/grub-pc.cfg

# x86：添加支持 I226 的小马 M12 12th J6412/J6413 CPU
wget -P ./target/linux/x86/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/001-add-XiaoMa-M12-12th-J6412-J6413-CPU-with-I226-support.patch
pushd target/linux/x86
patch -p1 < 001-add-XiaoMa-M12-12th-J6412-J6413-CPU-with-I226-support.patch
rm -f 001-add-XiaoMa-M12-12th-J6412-J6413-CPU-with-I226-support.patch
popd
# hostpad添加vendor_vht模块支持
# wget -P ./package/network/services/hostapd/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/services/hostapd/001-add-vendor_vht.patch
# pushd package/network/services/hostapd
# patch -p1 < 001-add-vendor_vht.patch
# rm -f 001-add-vendor_vht.patch
# popd

#wget -P ./package/network/services/hostapd/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/services/hostapd/001-add-BSS-CCA-support.patch
#pushd package/network/services/hostapd
#patch -p1 < 001-add-BSS-CCA-support.patch
#rm -f 001-add-BSS-CCA-support.patch
#popd

wget -P ./package/network/services/hostapd/patches/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/services/hostapd/024-fix-IEEE-802.11-deauthenticated-due-to-local-deauth-.patch

# nginx添加njs模块支持
# wget -P ./feeds/packages/net/nginx/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/nginx/001-nginx-add-njs-module.patch
# pushd feeds/packages/net/nginx
# patch -p1 < 001-nginx-add-njs-module.patch
# rm -f 001-nginx-add-njs-module.patch
# popd

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

wget -P ./package/base-files/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/base-files/001-fix-functions-jshn-sh-fond.patch
pushd package/base-files
patch -p1 < 001-fix-functions-jshn-sh-fond.patch
rm -f 001-fix-functions-jshn-sh-fond.patch
popd

# wget -P ./package/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/001-Makefile-force-overwrite.patch
# pushd package
# patch -p1 < 001-Makefile-force-overwrite.patch
# rm -f 001-Makefile-force-overwrite.patch
# popd

wget -P ./feeds/packages/libs/libsodium/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/libs/libsodium/001-latest.patch
pushd feeds/packages/libs/libsodium
patch -p1 < 001-latest.patch
rm -f 001-latest.patch
popd
# luci-app-nft-qos: simple
# wget -P ./feeds/luci/applications/luci-app-nft-qos/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/applications/luci-app-nft-qos/001-luci-app-nft-qos-simple.patch
# pushd feeds/luci/applications/luci-app-nft-qos
# patch -p1 < 001-luci-app-nft-qos-simple.patch
# rm -f 001-luci-app-nft-qos-simple.patch
# popd
# luci-app-mwan3接口系列双堆栈（ipv4 + ipv6）支持
# wget -P ./feeds/luci/applications/luci-app-mwan3/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/applications/luci-app-mwan3/001-interface-family-dual-stack-ipv4oripv6-support.patch
# pushd feeds/luci/applications/luci-app-mwan3
# patch -p1 < 001-interface-family-dual-stack-ipv4oripv6-support.patch
# rm -f 001-interface-family-dual-stack-ipv4oripv6-support.patch
# popd
wget -P ./feeds/luci/applications/luci-app-mwan3/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/applications/luci-app-mwan3/001-fix-luci-mwan3.patch
pushd feeds/luci/applications/luci-app-mwan3
patch -p1 < 001-fix-luci-mwan3.patch
rm -f 001-fix-luci-mwan3.patch
popd
# 添加、修复iwinfo适配K2P闭源驱动补丁
wget -P ./package/network/utils/iwinfo/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/utils/iwinfo/patches/101-ralink-k2p.patch
pushd package/network/utils/iwinfo
patch -p1 < 101-ralink-k2p.patch
rm -f 101-ralink-k2p.patch
popd
# 添加mbedtls:AES-and-GCM-with-ARMv8-Crypto-Extensions.patch补丁
wget -P ./package/libs/mbedtls/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/libs/mbedtls/001-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch
pushd package/libs/mbedtls
patch -p1 < 001-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch
rm -f 001-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch
popd
# 添加默认编译包
rm -f ./include/target.mk
wget -P ./include/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/include/target.mk
rm -f ./include/netfilter.mk
wget -P ./include/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/include/netfilter.mk
# kernel支持及修改连接数
# kernel：sysctl：更新 fullcone nat 的 nf_ct 设置
wget -P ./package/kernel/linux/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/linux/001-sysctl-nf-conntrack-fullconenat-mode2.patch
pushd package/kernel/linux
patch -p1 < 001-sysctl-nf-conntrack-fullconenat-mode2.patch
rm -f 001-sysctl-nf-conntrack-fullconenat-mode2.patch
popd

# 1.给kernel的crypto.mk、lib.mk、other.mk添加模块
wget -P ./package/kernel/linux/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/linux/001-compressed-memory.patch
pushd package/kernel/linux
patch -p1 < 001-compressed-memory.patch
rm -f 001-compressed-memory.patch
popd
# 2.给kernel的netdevices.mk、netfilter.mk添加模块
wget -P ./package/kernel/linux/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/linux/001-netdevices.mk-netfilter.mk.patch
pushd package/kernel/linux
patch -p1 < 001-netdevices.mk-netfilter.mk.patch
rm -f 001-netdevices.mk-netfilter.mk.patch
popd
# 3.给kernel的video.mk、virt.mk添加模块
wget -P ./package/kernel/linux/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/linux/001-video-add-multimedia-input-and-virt-add-i915.patch
pushd package/kernel/linux
patch -p1 < 001-video-add-multimedia-input-and-virt-add-i915.patch
rm -f 001-video-add-multimedia-input-and-virt-add-i915.patch
popd
# 4.给netsupport.mk 添加bbrplus、nanqinlang等模块
wget -P ./package/kernel/linux/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/linux/001-netsupport.mk-add-bbrplus.patch
pushd package/kernel/linux
patch -p1 < 001-netsupport.mk-add-bbrplus.patch
rm -f 001-netsupport.mk-add-bbrplus.patch
popd
# 4.给fs.mk 添加 NFSv4_2 SSC helper等模块
# wget -P ./package/kernel/linux/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/linux/001-fs.mk-add-nfsv4-2-ssc-helper.patch
# pushd package/kernel/linux
# patch -p1 < 001-fs.mk-add-nfsv4-2-ssc-helper.patch
# rm -f 001-fs.mk-add-nfsv4-2-ssc-helper.patch
# popd

# 5.给kernel(5.15)添加bbrplus、nanqinlang等模块补丁
wget -P ./target/linux/generic/backport-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.15/051-v5.18-bpf-Add-config-to-allow-loading-modules-with-BTF-mismatch.patch
wget -P ./target/linux/generic/backport-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.15/791-v6.6-11-net-phy-motorcomm-Add-pad-drive-strength-cfg-support.patch

wget -P ./target/linux/generic/backport-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.15/999-net-tcp-add-bbrplus.patch
wget -P ./target/linux/generic/backport-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.15/999-net-tcp-add-nanqinlang.patch
wget -P ./target/linux/generic/backport-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.15/999-net-tcp-add-tsunami.patch
wget -P ./target/linux/generic/backport-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.15/999-net-tcp-add-tsunamio.patch

# 给kernel(5.10)添加 bcm fullconenat补丁
# wget -P ./target/linux/generic/hack-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-5.10/982-add-bcm-fullconenat-support.patch

# 6.给kernel(5.10)添加bbrplus、nanqinlang等模块补丁
# wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/350-v5.12-NFSv4_2-SSC-helper-should-use-its-own-config.patch
# wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/351-v5.13-NFSv4_2-Remove-ifdef-CONFIG_NFSD-from-client-SSC.patch
# (不需要)wget -P ./target/linux/generic/backport-5.10/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/generic/backport-5.10/610-v5.13-54-net-ethernet-mtk_eth_soc-add-ipv6-flow-offloading-support.patch

# wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/999-net-tcp-add-bbrplus.patch
# wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/999-net-tcp-add-nanqinlang.patch
# wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/999-net-tcp-add-tsunami.patch
# wget -P ./target/linux/generic/backport-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/backport-5.10/999-net-tcp-add-tsunamio.patch

# 7、kernel修改连接数
# sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
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

wget -P ./package/network/utils/iptables/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/utils/iptables/001-IMQ-gargoyle-netfilter-match-modules.patch
pushd package/network/utils/iptables
patch -p1 < 001-IMQ-gargoyle-netfilter-match-modules.patch
rm -f 001-IMQ-gargoyle-netfilter-match-modules.patch
popd
wget -P ./package/network/utils/iproute2/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/utils/iproute2/001-add-qos-gargoyle.patch
pushd package/network/utils/iproute2
patch -p1 < 001-add-qos-gargoyle.patch
rm -f 001-add-qos-gargoyle.patch
popd
wget -P ./package/network/utils/iproute2/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/utils/iproute2/001-add-NSS-QDISC-support.patch
pushd package/network/utils/iproute2
patch -p1 < 001-add-NSS-QDISC-support.patch
rm -f 001-add-NSS-QDISC-support.patch
popd

svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/package/network/services/shellsync package/network/services/shellsync

wget -P ./package/network/services/ppp/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/services/ppp/patches/001-ppp-add-shellsync-support.patch
pushd package/network/services/ppp
patch -p1 < 001-ppp-add-shellsync-support.patch
rm -f 001-ppp-add-shellsync-support.patch
popd
# MWAN3回退到2.8.16版本以适配多拨
# rm -rf ./feeds/packages/net/mwan3
# svn co https://github.com/openwrt/packages/branches/openwrt-19.07/net/mwan3 feeds/packages/net/mwan3
# rm -rf ./feeds/packages/net/mwan3/.svn
# 9、luci-app-aria2开放路径修复
wget -P ./feeds/luci/applications/luci-app-aria2/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/applications/luci-app-aria2/001-luci-app-aria2-fix-open-path.patch
pushd feeds/luci/applications/luci-app-aria2
patch -p1 < 001-luci-app-aria2-fix-open-path.patch
rm -f 001-luci-app-aria2-fix-open-path.patch
popd
# 10、关闭https-dns-proxy自启动
# wget -P ./feeds/packages/net/https-dns-proxy/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/net/https-dns-proxy/patches/001-not-started.patch
# pushd feeds/packages/net/https-dns-proxy
# patch -p1 < 001-not-started.patch
# rm -f 001-not-started.patch
# popd
# 11、wget软链接到/usr/bin的二进制文件，以便与其他文件兼容
wget -P ./feeds/packages/net/wget/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/wget/patches/001-soft-link-binary-file-to-usr-bin.patch
pushd feeds/packages/net/wget
patch -p1 < 001-soft-link-binary-file-to-usr-bin.patch
rm -f 001-soft-link-binary-file-to-usr-bin.patch
popd
wget -P ./feeds/packages/net/wget/patches/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/wget/wget/patches/001-prefer_ipv4.patch

# 12、修改feeds里的luci-app-firewall加速开关等源码包
wget -P ./feeds/luci/applications/luci-app-firewall/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/applications/luci-app-firewall/patches/001-luci-app-firewall-Enable-FullCone-NAT.patch
pushd feeds/luci/applications/luci-app-firewall
patch -p1 < 001-luci-app-firewall-Enable-FullCone-NAT.patch
rm -f 001-luci-app-firewall-Enable-FullCone-NAT.patch
popd
# 13、添加wifi的MU-MIMO功能
wget -P ./feeds/luci/modules/luci-mod-network/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/modules/luci-mod-network/patches/001-wifi-add-MU-MIMO-option.patch
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

# 给kernel(5.15)添加 bcm fullconenat补丁
wget -P ./target/linux/generic/hack-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-5.15/982-add-bcm-fullconenat-support.patch

# 14、添加5.15内核ACC、shortcut-fe补丁
wget -P ./target/linux/generic/hack-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-5.15/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch

rm -f ./target/linux/generic/hack-5.15/901-debloat_sock_diag.patch
wget -P ./target/linux/generic/hack-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-5.15/901-debloat_sock_diag.patch

wget -P target/linux/generic/hack-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-5.15/952-add-net-conntrack-events-support-multiple-registrant.patch

wget -P target/linux/generic/hack-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-5.15/953-net-patch-linux-kernel-to-support-shortcut-fe.patch

wget -P target/linux/generic/hack-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-5.15/954-net-patch-linux-kernel-to-support-qca-nss-sfe.patch

wget -P target/linux/generic/hack-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-5.15/992-add-ndo-do-ioctl.patch

wget -P target/linux/generic/hack-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/hack-5.15/999-add-fibocom-id-and-zeropacket.patch

# 16、修复及添加pending-5.15部分补丁及添加Qualcomm QMI Helpers模块补丁
wget -P target/linux/generic/pending-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-5.15/613-netfilter_optional_tcp_window_check.patch

wget -P target/linux/generic/pending-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-5.15/709-Revert-net-mlx4_en-Update-reported-link-modes-for-1-.patch

wget -P target/linux/generic/pending-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-5.15/901-usb-add-more-modem-support.patch

rm -f ./target/linux/generic/pending-5.15/920-mangle_bootargs.patch
wget -P target/linux/generic/pending-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-5.15/920-mangle_bootargs.patch

wget -P ./target/linux/generic/pending-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/pending-5.15/930-qcom-qmi-helpers.patch

rm -f ./target/linux/generic/config-5.15
wget -P ./target/linux/generic/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/generic/config-5.15

rm -f ./target/linux/x86/Makefile
wget -P ./target/linux/x86/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/x86/Makefile
# 18、mwlwifi添加disable-amsdu补丁
wget -P package/kernel/mwlwifi/patches/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/mwlwifi/patches/002-disable-AMSDU.patch

# 19、给luci-lua-runtime使用busybox设置passwd
wget -P ./feeds/luci/modules/luci-lua-runtime/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/modules/luci-lua-runtime/patches/001-let-passwd-using-busybox.patch
pushd feeds/luci/modules/luci-lua-runtime
patch -p1 < 001-let-passwd-using-busybox.patch
rm -f 001-let-passwd-using-busybox.patch
popd

# 20、wireless-regdb：自定义更改txpower和dfs的补丁
wget -P package/firmware/wireless-regdb/patches/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/firmware/wireless-regdb/patches/600-custom-change-txpower-and-dfs.patch

# 21、添加upx压缩源码
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/tools/ucl tools/ucl

svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/tools/upx tools/upx

rm -f ./tools/Makefile
wget -P ./tools/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/tools/Makefile
# 22、去除feeds中的material主题多余openwrt名
# sed -i '66 s#boardinfo.hostname or "?"#""#g' feeds/luci/themes/luci-theme-material/luasrc/view/themes/material/header.htm
# 23、将tty、ksmd所在服务目录改到系统、网络存储目录
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-ksmbd/root/usr/share/luci/menu.d/luci-app-ksmbd.json
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
# 24、添加feeds里的依赖包
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/lang/python/Flask-RESTful feeds/packages/lang/python/Flask-RESTful

svn export https://github.com/openwrt/packages/branches/openwrt-19.07/libs/opencv feeds/packages/libs/opencv

svn export https://github.com/openwrt/packages/branches/openwrt-19.07/libs/fcgi feeds/packages/libs/fcgi

# svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/libs/libdouble-conversion feeds/packages/libs/libdouble-conversion

# 25、添加dnamasq的IPV6展示
wget -P ./package/network/services/dnsmasq/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/services/dnsmasq/patches/0001-dnsmasq-add-filteraaaa-https-unknown-option-remove-mini-ttl.patch
pushd package/network/services/dnsmasq
patch -p1 < 0001-dnsmasq-add-filteraaaa-https-unknown-option-remove-mini-ttl.patch
rm -f 0001-dnsmasq-add-filteraaaa-https-unknown-option-remove-mini-ttl.patch
popd
wget -P ./feeds/luci/modules/luci-mod-network/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/services/dnsmasq/patches/0001-luci-add-filteraaaa-https-unknown-option.patch
pushd feeds/luci/modules/luci-mod-network
patch -p1 < 0001-luci-add-filteraaaa-https-unknown-option.patch
rm -f 0001-luci-add-filteraaaa-https-unknown-option.patch
popd
wget -P ./package/network/services/dnsmasq/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/services/dnsmasq/patches/0001-dnsmasq-conf.patch
pushd package/network/services/dnsmasq
patch -p1 < 0001-dnsmasq-conf.patch
rm -f 0001-dnsmasq-conf.patch
popd
wget -P ./package/network/services/dnsmasq/patches/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/services/dnsmasq/patches/910-mini-ttl.patch
wget -P ./package/network/services/dnsmasq/patches/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/services/dnsmasq/patches/911-dnsmasq-filteraaaa-https-unknown.patch
# 26、添加dnamasq的多核心dns负载均衡解析
# wget -P ./package/network/services/dnsmasq/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/package/network/services/dnsmasq/patches/001-auto-multiple-service-instances.patch
# pushd package/network/services/dnsmasq
# patch -p1 < 001-auto-multiple-service-instances.patch
# rm -f 001-auto-multiple-service-instances.patch
# popd
# 27、添加k2p的lan/wan
wget -P ./target/linux/ramips/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/ramips/patches/000-k2p-network.patch
pushd target/linux/ramips
patch -p1 < 000-k2p-network.patch
rm -f 000-k2p-network.patch
popd

# mtk-eip93：使用内核修复构建
# wget -P ./target/linux/ramips/patches-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/ramips/patches-5.10/999-crypto-eip93-fix.patch
# wget -P ./target/linux/ramips/patches-5.10/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/ramips/patches-5.10/999-fix-hwnat.patch

# (不需要)wget -P ./target/linux/ramips/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/target/linux/ramips/patches/overclock-mt7621.patch
# pushd target/linux/ramips
# patch -p1 < overclock-mt7621.patch
# rm -f overclock-mt7621.patch
# popd
wget -P ./target/linux/ramips/patches-5.15/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/ramips/patches-5.15/999-crypto-eip93-fix.patch
# rtl8812au-ac：更新无线5.8
# svn co https://github.com/project-openwrt/openwrt/branches/master/package/kernel/rtl8812au-ac package/kernel/rtl8812au-ac
# 28、修改transmission依赖
wget -P ./feeds/packages/net/transmission-web-control/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/transmission-web-control/patches/001-transmission-web-control-dbengine.patch
pushd feeds/packages/net/transmission-web-control
patch -p1 < 001-transmission-web-control-dbengine.patch
rm -f 001-transmission-web-control-dbengine.patch
popd
wget -P ./feeds/luci/applications/luci-app-transmission/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/applications/luci-app-transmission/patches/001-luci-app-transmission-with-dbengine.patch
pushd feeds/luci/applications/luci-app-transmission
patch -p1 < 001-luci-app-transmission-with-dbengine.patch
rm -f 001-luci-app-transmission-with-dbengine.patch
popd
# 29、修改sqm-scripts汉化help
svn export https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/net/sqm-scripts/patches feeds/packages/net/sqm-scripts/patches

# 30、添加netdata显示中文日期补丁
wget -P ./feeds/packages/admin/netdata/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/admin/netdata/patches/006-netdata.patch
pushd feeds/packages/admin/netdata
patch -p1 < 006-netdata.patch
rm -f 006-netdata.patch
popd
# svn co https://github.com/zxlhhyccc/acc-imq-bbr/trunk/master/feeds/packages/libs/libJudy feeds/packages/libs/libJudy
# 32、luci-lib-jsoncs使用int64
# wget -P ./feeds/luci/libs/luci-lib-jsonc/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/luci/libs/luci-lib-jsonc/patches/0001-use_json_object_new_int64.patch
# pushd feeds/luci/libs/luci-lib-jsonc
# patch -p1 < 0001-use_json_object_new_int64.patch
# rm -f 0001-use_json_object_new_int64.patch
# popd
# 32、修正adblock.init
wget -P ./feeds/packages/net/adblock/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/adblock/patches/001-adblock.patch
pushd feeds/packages/net/adblock
patch -p1 < 001-adblock.patch
rm -f 001-adblock.patch
popd
# 33、屏蔽socat/openvpn的与luci冲突的config、init以编译luci
wget -P ./feeds/packages/net/socat/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/socat/patches/001-shield-socat-config-init.patch
pushd feeds/packages/net/socat
patch -p1 < 001-shield-socat-config-init.patch
rm -f 001-shield-socat-config-init.patch
popd
wget -P ./feeds/packages/net/openvpn/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/packages/net/openvpn/patches/001-shield-config.patch
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
# 34、添加aria2补丁和修复 ujail mount
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

# 35、删除feeds里的与自有包冲突插件
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

# 38、mac80211：为ath / subsys：在2g上允许vht添加补丁
wget -P ./package/kernel/mac80211/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/mac80211/patches/Makefile
wget -P ./package/kernel/mac80211/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/mac80211/patches/ath.mk
wget -P ./package/kernel/mac80211/patches/subsys/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/mac80211/patches/subsys/999-mac80211-allow-vht-on-2g.patch
wget -P ./package/kernel/mac80211/patches/ath10k/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/mac80211/patches/ath10k/983-ath10k-allow-vht-on-2g.patch
wget -P ./package/kernel/mac80211/patches/ath11k/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/mac80211/patches/ath11k/983-ath11k-Enable-VHT-for-2G.patch
wget -P ./package/kernel/mac80211/patches/ath11k/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/kernel/mac80211/patches/ath11k/984-ath11k-workaround-for-memory-leak.patch

git clone --depth 1 https://github.com/zxlhhyccc/acc-imq-bbr.git && cp -rf ./acc-imq-bbr/master/package/kernel/mac80211/patches/nss ./package/kernel/mac80211/patches/ && cp -rf ./acc-imq-bbr/master/package/kernel/mac80211/patches/files ./package/kernel/mac80211/ && rm -rf acc-imq-bbr

# 39、修正友善补丁(R2S/R4S)
rm -rf package/boot/uboot-rockchip
svn export https://github.com/immortalwrt/immortalwrt/trunk/package/boot/uboot-rockchip package/boot/uboot-rockchip

rm -rf target/linux/rockchip
svn export https://github.com/immortalwrt/immortalwrt/trunk/target/linux/rockchip target/linux/rockchip

rm -rf package/boot/arm-trusted-firmware-rockchip
svn export https://github.com/immortalwrt/immortalwrt/trunk/package/boot/arm-trusted-firmware-rockchip package/boot/arm-trusted-firmware-rockchip

# 40、busybox：为docker top命令添加ps -ef选项的补丁
wget -P ./package/utils/busybox/patches/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/utils/busybox/patches/900-add-e-f-option-for-docker.patch

# netifd：修复树外以太网驱动程序的自动协商
# wget -P ./package/network/config/netifd/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/config/netifd/100-Revert-device-add-support-for-configuring-device-link-spe.patch
# pushd package/network/config/netifd
# patch -p1 < 100-Revert-device-add-support-for-configuring-device-link-spe.patch
# rm -f 100-Revert-device-add-support-for-configuring-device-link-spe.patch
# popd
# netifd：抑制 uci 错误日志
wget -P ./package/network/config/netifd/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/config/netifd/001-suppress-uci-error-log.patch
pushd package/network/config/netifd
patch -p1 < 001-suppress-uci-error-log.patch
rm -f 001-suppress-uci-error-log.patch
popd

# odhcp6c：支持dhcpv6热插拔
wget -P ./package/network/ipv6/odhcp6c/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/package/network/ipv6/odhcp6c/001-support-dhcpv6-hotplug.patch
pushd package/network/config/netifd
patch -p1 < 001-support-dhcpv6-hotplug.patch
rm -f 001-support-dhcpv6-hotplug.patch
popd

# 42、mvebu 添加cpu显示
# rm -rf target/linux/mvebu/Makefile
# wget -P ./target/linux/mvebu/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/target/linux/mvebu/Makefile

# 44、sqlite3：添加对qt5的列元数据支持
# wget -P ./feeds/packages/libs/sqlite3/ https://raw.githubusercontent.com/zxlhhyccc/acc-imq-bbr/master/master/feeds/packages/libs/sqlite3/patches/001-add-column-metadata-support-for-qt5.patch
# pushd feeds/packages/libs/sqlite3
# patch -p1 < 001-add-column-metadata-support-for-qt5.patch
# rm -f 001-add-column-metadata-support-for-qt5.patch
# popd
