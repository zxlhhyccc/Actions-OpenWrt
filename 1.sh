I:\6.1> .\tcping64.exe 192.168.10.1 1688

# 生成 pot 文件命令
./build/i18n-scan.pl ./applications/luci-app-ssr-plus/ > ./applications/luci-app-ssr-plus/po/templates/ssr-plus.pot

# 同步翻译字符串命令
./build/i18n-update.pl ./applications/luci-app-ssr-plus/po/


# 提取 luci-app-passwall
git clone -b main --depth 1 https://github.com/xiaorouji/openwrt-passwall.git && cp -rf ./openwrt-passwall/luci-app-passwall ./ && rm -rf openwrt-passwall

# 提取 luci-app-openclash
git clone -b dev --depth 1 https://github.com/vernesong/OpenClash.git && cp -rf ./OpenClash/luci-app-openclash ./ && rm -rf OpenClash

# 提取 luci-app-homeproxy
rm -rf luci-app-homeproxy luci-app-3ginfo-lite luci-app-sms-tool-js luci-app-3cat && git clone --depth 1 https://github.com/immortalwrt/luci.git && cp -rf ./luci/applications/luci-app-homeproxy ./ && cp -rf ./luci/applications/luci-app-3ginfo-lite ./ && cp -rf ./luci/applications/luci-app-sms-tool-js ./ && cp -rf ./luci/applications/luci-app-3cat ./ && rm -rf luci && sed -i 's#include ../../luci.mk#include $(TOPDIR)/feeds/luci/luci.mk#g' luci-app-homeproxy/Makefile && sed -i 's#include ../../luci.mk#include $(TOPDIR)/feeds/luci/luci.mk#g' luci-app-3ginfo-lite/Makefile && sed -i 's#include ../../luci.mk#include $(TOPDIR)/feeds/luci/luci.mk#g' luci-app-sms-tool-js/Makefile && sed -i 's#include ../../luci.mk#include $(TOPDIR)/feeds/luci/luci.mk#g' luci-app-3cat/Makefile

rm -rf 3proxy && git clone --depth 1 https://github.com/immortalwrt/packages.git && cp -rf ./packages/net/3proxy ./ && rm -rf packages

# 提取 rockchip
rm -rf package/boot/rkbin package/boot/uboot-rockchip package/boot/arm-trusted-firmware-rockchip target/linux/rockchip && git clone --depth 1 https://github.com/immortalwrt/immortalwrt.git && cp -rf ./immortalwrt/package/boot/arm-trusted-firmware-rockchip ./package/boot/ && cp -rf ./immortalwrt/package/boot/uboot-rockchip ./package/boot/ && cp -rf ./immortalwrt/target/linux/rockchip ./target/linux/ && rm -rf immortalwrt

# 提取 luci-app-ssr-plus
git clone --depth 1 https://github.com/fw876/helloworld.git && cp -rf ./helloworld/luci-app-ssr-plus ./ && rm -rf helloworld

# 提取官方 rockchip
rm -rf package/boot/uboot-rockchip package/boot/arm-trusted-firmware-rockchip target/linux/rockchip && git clone --depth 1 https://github.com/openwrt/openwrt.git && cp -rf ./openwrt/package/boot/rkbin ./package/boot/ && cp -rf ./openwrt/package/boot/arm-trusted-firmware-rockchip ./package/boot/ && cp -rf ./openwrt/package/boot/uboot-rockchip ./package/boot/ && cp -rf ./openwrt/target/linux/rockchip ./target/linux/ && rm -rf openwrt
