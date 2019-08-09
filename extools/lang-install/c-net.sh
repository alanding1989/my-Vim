#! /usr/bin/env bash


# File Name    : extools/lang-install/c-net.sh
# Author       : AlanDing
# Created Time : Fri 09 Aug 2019 01:17:37 PM CST
# Description  : 


sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update

apt-get install mono-devel
