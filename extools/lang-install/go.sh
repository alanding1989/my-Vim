#! /usr/bin/env bash


# File Name    : extools/lang-install/go.sh
# Author       : AlanDing
# Created Time : Wed 29 May 2019 06:16:22 AM CST
# Description  : 



# go dependency manager
if [ ! -x dep ]; then
  go get -u github.com/golang/dep/cmd/dep
fi

if [ ! -x gocode ]; then
  go get -u github.com/stamblerre/gocode
  go get -u github.com/mdempsky/gocode
fi

if [ ! -x errcheck ]; then
  go get -u github.com/kisielk/errcheck
fi

if [ ! -x impl ]; then
  go get - u github.com/josharian/impl
fi

gotoolspath=/opt/lang-tools/go/go/src/golang.org/x/tools

if [ ! -e $gotoolspath ]; then
  git clone git@github.com:golang/tools.git $gotoolspath
fi

