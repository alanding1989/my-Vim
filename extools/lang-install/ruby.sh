#! /usr/bin/env bash

#================================================================================
# File Name    : extools/lang-install/ruby.sh
# Author       : AlanDing
# Created Time : Thu 06 Jun 2019 02:56:03 PM CST
# Description  : 
#================================================================================


if [ ! -e "$HOME/.rbenv" ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd "$HOME/.rbenv" && src/configure && make -C src
  source "$HOME/.zshrc"
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  # ruby-dependencies
  apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
  rbenv install 2.6.0
  rbenv global 2.6.0
  gem install neovim
  gem install bundler
  gem install colorls
  gem install rainbow
  rbenv rehash
  rehash
fi
