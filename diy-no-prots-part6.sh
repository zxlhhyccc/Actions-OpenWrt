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

# 1、给luci-base添加无线图标及分离 Lua 运行时资源
wget -P ./feeds/luci/modules/luci-base/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/modules/luci-base/patches/001-initial-ucode-based-luci-runtime.patch
pushd feeds/luci/modules/luci-base
patch -p1 < 001-initial-ucode-based-luci-runtime.patch
rm -f 001-initial-ucode-based-luci-runtime.patch
popd

# 2、修复新版luci的cpu等寄存器显示
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
wget -P ./feeds/luci/modules/luci-mod-status/ https://github.com/zxlhhyccc/acc-imq-bbr/raw/master/master/feeds/luci/modules/luci-mod-status/patches/001-introduce-ethernet-port-status-view.patch
pushd feeds/luci/modules/luci-mod-status
patch -p1 < 001-introduce-ethernet-port-status-view.patch
rm -f 001-introduce-ethernet-port-status-view.patch
popd
