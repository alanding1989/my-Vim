#! /usr/bin/env bash

# =====================================================
# for build gvim manually
# =====================================================


srcpath=/mnt/fun+downloads/linux系统安装/code-software/vim/vim8.1-src

# [ -x vim ] && vim --version

[ -d /opt/vim ] || mkdir -p /opt/vim

src_update() {
  if [ ! -e $srcpath ]; then
    git clone git@github.com:vim/vim.git $srcpath
    cd $srcpath || exit 1
    # dependencies
    # sudo apt-get install libncurses5-dev python-dev python3-dev \
      # libgtk3.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev \
      # libx11-dev libxpm-dev libxt-dev libgnome2-dev libgnomeui-dev \
      # libgtk2.0-dev ruby-dev liblua5.3-dev libperl-dev
  else
    cd $srcpath && git pull
  fi
}

build_install() {
  if [ -e /opt/vim/vim8.1-old ]; then
    sudo rm -rf /opt/vim/vim8.1-old
  fi
  if [ -e /opt/vim/vim8.1 ]; then
    sudo mv -i /opt/vim/vim8.1 /opt/vim/vim8.1-old
  fi

  # 必须用系统的python作为可执行python进行编译，要不字节码有冲突，具体底层哪有问题还不清楚
  cd $srcpath && \
    ./configure \
    --prefix=/opt/vim/vim8.1 \
    --with-features=huge \
    --enable-multibyte \
    --enable-cscope \
    --enable-gui=gtk3 \
    --enable-rubyinterp \
    --enable-luainterp \
    --enable-perlinterp \
    --enable-python3interp \
    --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/
 
  sudo make && sudo make install
}
      # /usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/

src_update && build_install
# vim --version

