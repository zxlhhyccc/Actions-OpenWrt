#!/bin/sh

find /home/lin/1/po -type f -name "frpc.po" | while read -r file; do
    sed -i 's|/home/lin/ax6-6.x.6/feeds/luci/||g' "$file"
done

# 批量删除在不同路径下但文件名相同的文件
find po -type f -name "smartdns.po~" -exec rm -f {} \;
