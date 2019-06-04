#! /usr/bin/env bash


# File Name    : extools/lang-install/go.sh
# Author       : AlanDing
# Created Time : Wed 29 May 2019 06:16:22 AM CST
# Description  : 

# lang install released binary


checkclone()
{
  if [ ! -e "$1" ]; then
    git clone "$2" "$1" && cd "$1" || return
  else
    cd "$1" || return && git pull
  fi
}

gotoolspath=/home/alanding/go/src/golang.org/x/tools
gotoolsrepo=git@github.com:golang/tools.git

golintpath=/home/alanding/go/src/golang.org/x/lint
golintrepo=git@github.com:golang/lint.git

keyifypath=/home/alanding/go/src/honnef.co/go/tools
keyifyrepo=git@github.com:dominikh/go-tools.git

cryptopath=/home/alanding/go/src/golang.org/x/crypto
cryptorepo=git@github.com:golang/crypto.git

syncpath=/home/alanding/go/src/golang.org/x/sync
syncrepo=git@github.com:golang/sync.git


checkclone $gotoolspath $gotoolsrepo
checkclone $golintpath  $golintrepo
checkclone $keyifypath  $keyifyrepo
checkclone $cryptopath  $cryptorepo
checkclone $syncpath    $syncrepo


if [ ! -x dep ]; then
  # go dependency manager
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

