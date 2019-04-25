# ================================================================================
#  File Name    : plugin-install/ccls-install.sh
#  Author       : AlanDing
#  mail         :
#  Created Time : Thu 25 Apr 2019 06:19:09 PM CST
# ================================================================================
#!/usr/bin/env bash

cclspath=/mnt/fun+downloads/linux系统安装/code-software/lang/cpp/ccls

if [ ! -e $cclspath ]; then
  cd $(dirname $cclspath) && git clone --depth=1 --recursive https://github.com/MaskRay/ccls && cd ccls
else
  cd $cclspath && git pull
fi

cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/opt/lang-tools/cpp/clang -DCMAKE_INSTALL_PREFIX=/opt/lang-tools/cpp/clang
cmake --build Release --target install
