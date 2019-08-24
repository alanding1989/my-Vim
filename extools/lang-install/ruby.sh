#! /usr/bin/env bash

#================================================================================
# File Name    : extools/lang-install/ruby.sh
# Author       : AlanDing
# Created Time : Thu 06 Jun 2019 02:56:03 PM CST
# Description  : 
#================================================================================


if [ ! -e "/home/alanding/.rbenv" ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd "/home/alanding/.rbenv" && src/configure && make -C src
  source "/home/alanding/.zshrc"
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  # ruby-dependencies
  apt-get install bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libffi-dev libgdbm5 libgdbm-dev

  # rbenv install 太慢，用淘宝镜像下载
  wget -q http://ruby.taobao.org/mirrors/ruby/2.0/ruby-2.6.3.tar.gz \
    -O /home/alanding/.rbenv/versions/ruby-2.6.3.tar.gz \
    env RUBY_BUILD_MIRROR_URL=file:///home/alanding/.rbenv/versions/ruby-2.6.3.tar.gz# ~/.rbenv/bin/rbenv install 2.6.3
  rbenv global 2.6.3

  gem sources --add https://gems.ruby-china.org/
  gem sources --remove https://rubygems.org/
  gem sources -l
  gem install neovim
  gem install bundler
  gem install colorls
  gem install rainbow
  rbenv rehash
  rehash
fi
