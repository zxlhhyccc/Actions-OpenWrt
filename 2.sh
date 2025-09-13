#!/bin/sh

find /home/lin/1/po -type f -name "frpc.po" | while read -r file; do
    sed -i 's|/home/lin/ax6-6.x.6/feeds/luci/||g' "$file"
done

# 批量删除在不同路径下但文件名相同的文件
find po -type f -name "smartdns.po~" -exec rm -f {} \;


# 修改后的 Makefile 和原版放在两个目录
diff -uNr old/Makefile new/Makefile > 001-add-pdnsd.patch

#补丁格式是标准的 Git patch / Git email patch，也称为 unified diff with metadata 格式
From <commit-hash> <timestamp>
From: <author>
Date: <commit date>
Subject: [PATCH] ...

#1 假设你已经完成修改并提交：
git commit -am "Convert arguments of isdigit to int."
#2 使用：
git format-patch <commit>
#或：
git format-patch -1
#这会生成一个文件，比如：
0001-Convert-arguments-of-isdigit-to-int.patch

#分步克隆（先只拿元数据，再拉取文件）
#--depth=1 先拉最新一层提交，速度快，不容易超时；
#--unshallow 再补全历史。
git clone --depth=1 https://github.com/zxlhhyccc/bf-package-master.git
cd bf-package-master
git fetch --unshallow

#2个commit跨commit合并
#通过 git rebase -i 交互式变基来调整提交顺序。具体步骤：
#1.运行命令，打开最近5个提交的编辑器(0-4)：
git rebase -i HEAD~5
#2.类似下面的提交列表：
pick 80d260f7f luci-app-ssr-plus: support xray ech
pick 474b2a944 luci-app-passwall: luci: xray ech add echForceQuery config
pick cb1a2deeb luci-app-openclash: Chore: update third-party resources
pick 60cf9c078 smartdns-rs: fix(resolver): Accept first NOERROR response in FastestResponse mode
pick 98e1b70f8 luci-app-ssr-plus: Update translate
#3.想把最后一个 98e1b70f8 移动到第一个 80d260f7f 后面，改成：
#就是说，直接把 98e1b70f8 这行剪切出来，放到 80d260f7f 这行后面
pick 80d260f7f luci-app-ssr-plus: support xray ech
pick 98e1b70f8 luci-app-ssr-plus: Update translate
pick 474b2a944 luci-app-passwall: luci: xray ech add echForceQuery config
pick cb1a2deeb luci-app-openclash: Chore: update third-party resources
pick 60cf9c078 smartdns-rs: fix(resolver): Accept first NOERROR response in FastestResponse mode
#4.把98e1b70f8并改成 squash：
pick 80d260f7f luci-app-ssr-plus: support xray ech
s 98e1b70f8 luci-app-ssr-plus: Update translate
pick 474b2a944 luci-app-passwall: luci: xray ech add echForceQuery config
pick cb1a2deeb luci-app-openclash: Chore: update third-party resources
pick 60cf9c078 smartdns-rs: fix(resolver): Accept first NOERROR response in FastestResponse mode
#5.编辑合并后的 commit
#6.强制推送，如：
git push origin master -f

