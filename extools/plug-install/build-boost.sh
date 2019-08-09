#! /usr/bin/env bash


# File Name    : extools/plug-install/build-boost.sh
# Author       : AlanDing
# Created Time : Thu 08 Aug 2019 07:53:21 AM CST
# Description  : 

boostHome=/mnt/fun+downloads/linux系统安装/code-software/lang/cpp/boost_1_70_0

cd $boostHome || (echo "cd failed" && exit)

## --with-libraries指定编译哪些boost库，all的话就是全部编译，只想编译部分库的话就把库的名称写上，之间用,号分隔即可。
## --with-toolset指定编译时使用哪种编译器，Linux下使用gcc即可。
## 如果系统中安装了多个版本的gcc，在这里可以指定gcc的版本，比如--with-toolset=gcc-4.4
./bootstrap.sh --with-libraries=all --with-toolset=gcc

#@ 编译
mkdir buildBoost
./b2 toolset=gcc --build-dir=$boostHome/buildBoost

#@ 安装
## --prefix=/usr用来指定boost的安装目录，默认头文件在/usr/local/include/boost，库文件在/usr/local/lib/。
./b2 install --prefix=/opt/lang-tools/cpp/boost
ldconfig

sudo ln -s /opt/lang-tools/cpp/boost/include/boost/ /usr/include/boost
sudo ln -s /opt/lang-tools/cpp/boost/lib/ /usr/lib/boost

