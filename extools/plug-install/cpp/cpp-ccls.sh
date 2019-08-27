#!/usr/bin/env bash

# ================================================================================
#  File Name    : plugin-install/ccls-install.sh
#  Author       : AlanDing
#  mail         :
#  Created Time : Thu 25 Apr 2019 06:19:09 PM CST
# ================================================================================

cclspath=/mnt/fun+downloads/linux系统安装/code-software/lang/cpp/ccls

[ -e $cclspath ] && rm -rf "$cclspath"

cd "$(dirname $cclspath)" && \
  git clone --depth=1 --recursive https://github.com/MaskRay/ccls && \
  cd ccls || return

cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_PREFIX_PATH=/opt/lang-tools/cpp/clang \
  -DCMAKE_INSTALL_PREFIX=/opt/lang-tools/cpp/clang

cmake --build Release --target install

