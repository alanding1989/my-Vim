#! /usr/bin/env bash


# File Name    : extools/lang-install/go.sh
# Author       : AlanDing
# Created Time : Wed 29 May 2019 06:16:22 AM CST
# Description  : 

# lang install released binary

# memo
# replace (
  # => github.com/golang/text latest
# )


xpath="/home/alanding/go/src/golang.org/x"
# golangrepo="git@github.com:golang"

# declare -A dic
# dic=(
  # ["lint"]="$golangrepo/lint.git"
  # ["tools"]="$golangrepo/tools.git"
  # ["crypto"]="$golangrepo/crypto.git"
  # ["sys"]="$golangrepo/sys.git"
  # ["net"]="$golangrepo/net.git"
  # ["tour"]="$golangrepo/tour.git"
  # ["perf"]="$golangrepo/perf.git"
  # ["image"]="$golangrepo/image.git"
  # ["review"]="$golangrepo/review.git"
  # ["text"]="$golangrepo/text.git"
  # ["time"]="$golangrepo/time.git"
  # ["sync"]="$golangrepo/sync.git"
  # ["vgo"]="$golangrepo/vgo.git"
# )

# declare -a modname
# modname=($(ls $xpath))

# checkclone() {
  # if [ ! -e "$1" ]; then
    # git clone "$2" "$1" && cd "$1" || return
  # else
    # cd "$1" || return && git pull
  # fi
# }

# function gomodtidy() {
  # for item in ${modname[*]}; do
    # cd "$xpath/$item" || return && go mod tidy -v
  # done
# }

# gitsubmodadd() {
  # git submodule add "$1" "$2"
# }

# function addsubmod() {
  # for item in ${modname[*]}; do
    # gitsubmodadd  "$golangrepo/$item.git"  "./$item"
  # done
# }

# cd $xpath && addsubmod

# gomodtidy


if [ ! -e $xpath ]; then
  git clone git@github.com:alanding1989/golang-x.git $xpath
fi

install=(
  ["goimports"]="golang.org/x/tools/cmd/goimports"
  ["golint"]="golang.org/x/lint/golint"
  ["gopls"]="golang.org/x/tools/cmd/gopls"
  ["gorename"]="golang.org/x/tools/cmd/gorename"
  ["guru"]="golang.org/x/tools/cmd/guru"
  ["tour"]="golang.org/x/tour"
)

cd "$GOPATH/src" || return
for item in ${!install[*]}; do
  if [ ! -x "$item" ]; then
    go install "${install[$item]}"
  fi
done

keyifypath=/home/alanding/go/src/honnef.co/go/tools
keyifyrepo=git@github.com:dominikh/go-tools.git

if [ ! -e $keyifypath ]; then
  git clone $keyifyrepo $keyifypath
fi

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

if [ ! -x go-langserver ]; then
  go get -u github.com/sourcegraph/go-langserver
fi

if [ ! -x vimlparser ]; then
  go get -u github.com/haya14busa/go-vimlparser/cmd/vimlparser
fi

