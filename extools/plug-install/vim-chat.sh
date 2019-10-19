#! /usr/bin/env bash


# File Name    : extools/plug-install/vim-chat.sh
# Author       : AlanDing
# Created Time : Sat 12 Oct 2019 09:26:58 PM CST
# Description  : 


sudo -i

sudo cpan -i App::cpanminus
# sudo cpanm Mojo::Weixin

cpanm --mirror http://mirrors.163.com/cpan/ Mojo::Webqq
sudo cpanm --mirror http://mirrors.163.com/cpan/ Mojo::weixin
sudo cpanm -v Mojo::IRC::Server::Chinese

sudo apt get install irssi

sudo apt-get install libcurl4-openssl-dev libx11-dev libxt-dev libimlib2-dev libxinerama-dev libjpeg-progs

cd /tmp && git clone https://git.finalrewind.org/feh

cd feh && make && make install

