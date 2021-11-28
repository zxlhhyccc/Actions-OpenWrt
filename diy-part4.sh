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

# luci-compat：修复“非 uci”地图的错误错误消息
sed -i '5c <% if firstmap and readable then %>' feeds/luci/modules/luci-compat/luasrc/view/cbi/map.htm
sed -i '42c <% elseif firstmap then %>' feeds/luci/modules/luci-compat/luasrc/view/cbi/map.htm
# luci-ssl：依赖于 libustream-ssl
sed -i 's/wolfssl/openssl/g' feeds/luci/collections/luci-ssl/Makefile
sed -i 's/WolfSSL/mbedTLS/g' feeds/luci/collections/luci-ssl/Makefile
sed -i 's/px5g-openssl/px5g/g' feeds/luci/collections/luci-ssl/Makefile
# luci-app-openvpn：添加 proto udp4/6 tcp4/6 支持
sed -i 's/{ "udp", "tcp-client", "tcp-server", "udp6", "tcp6-client", "tcp6-server" },/{ "udp", "tcp-client", "tcp-server", "udp4", "tcp4", "tcp6", "udp6", "tcp6-client", "tcp6-server" },/g' feeds/luci/applications/luci-app-openvpn/luasrc/model/cbi/openvpn-basic.lua
sed -i  's/{ "udp", "tcp-client", "tcp-server" },/{ "udp", "tcp-client", "tcp-server", "udp4", "tcp4" },/g' feeds/luci/applications/luci-app-openvpn/luasrc/model/cbi/openvpn-basic.lua

