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

gosyspath=/home/alanding/go/src/golang.org/x/sys
gosysrepo=git@github.com:golang/sys.git

gonetpath=/home/alanding/go/src/golang.org/x/net
gonetrepo=git@github.com:golang/net.git

gotourpath=/home/alanding/go/src/golang.org/x/tour
gotourrepo=git@github.com:golang/tour.git

goperfpath=/home/alanding/go/src/golang.org/x/perf
goperfrepo=git@github.com:golang/perf.git

govgopath=/home/alanding/go/src/golang.org/x/vgo
govgorepo=git@github.com:golang/vgo.git

goimagepath=/home/alanding/go/src/golang.org/x/image
goimagerepo=git@github.com:golang/image.git

goreviewpath=/home/alanding/go/src/golang.org/x/review
goreviewrepo=git@github.com:golang/review.git

gotextpath=/home/alanding/go/src/golang.org/x/text
gotextrepo=git@github.com:golang/text.git

gotimepath=/home/alanding/go/src/golang.org/x/time
gotimerepo=git@github.com:golang/time.git

checkclone $gotoolspath  $gotoolsrepo
checkclone $golintpath   $golintrepo
checkclone $keyifypath   $keyifyrepo
checkclone $cryptopath   $cryptorepo
checkclone $syncpath     $syncrepo
checkclone $gosyspath    $gosysrepo
checkclone $gonetpath    $gonetrepo
checkclone $gotourpath   $gotourrepo
checkclone $goperfpath   $goperfrepo
checkclone $govgopath    $govgorepo
checkclone $goimagepath  $goimagerepo
checkclone $goreviewpath $goreviewrepo
checkclone $gotextpath   $gotextrepo
checkclone $gotimepath   $gotimerepo


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

