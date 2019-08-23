#! /usr/bin/env bash

# File Name    : extools/lang-install/go.sh
# Author       : AlanDing
# Created Time : Wed 29 May 2019 06:16:22 AM CST
# Description  : install go tools


# @ for memo
# replace (
#   => github.com/golang/text latest
# )


xpath=$GOPATH/src/golang.org/x

package=(
  ["tour"]="golang.org/x/tour"
  ["dep"]="github.com/golang/dep/cmd/dep"
  ["go-langserver"]="github.com/sourcegraph/go-langserver"
  ["protoc-gen-go"]="github.com/golang/protobuf/protoc-gen-go"

  ["asmfmt"]="github.com/klauspost/asmfmt/cmd/asmfmt"
  ["dlv"]="github.com/go-delve/delve/cmd/dlv"
  ["errcheck"]="github.com/kisielk/errcheck"
  ["fillstruct"]="github.com/davidrjenni/reftools/cmd/fillstruct"
  ["gocode"]="github.com/mdempsky/gocod"
  ["gocode-gomod"]="github.com/stamblerre/gocode"
  ["godef"]="github.com/rogpeppe/godef"
  ["gogetdoc"]="github.com/zmb3/gogetdoc"
  ["goimports"]="golang.org/x/tools/cmd/goimports"
  ["golint"]="golang.org/x/lint/golint"
  ["gopls"]="golang.org/x/tools/cmd/gopls"
  ["gometalinter"]="github.com/alecthomas/gometalinter"
  ["golangci-lint"]="github.com/golangci/golangci-lint/cmd/golangci-lint"
  ["gomodifytags"]="github.com/fatih/gomodifytags"
  ["gorename"]="golang.org/x/tools/cmd/gorename"
  ["gotags"]="github.com/jstemmer/gotags"
  ["guru"]="golang.org/x/tools/cmd/guru"
  ["impl"]="github.com/josharian/impl"
  ["keyify"]="honnef.co/go/tools/cmd/keyify"
  ["motion"]="github.com/fatih/motion"
  ["iferr"]="github.com/koron/iferr"
)


# Install depends
function deps_download_or_update() {
  if [ ! -e "$xpath" ]; then
    git clone git@github.com:alanding1989/golang-x.git "$xpath"
    cd "$xpath" || exit 1
  else
    cd "$xpath" || exit 1
    for file in $(ls) ; do
      echo "$file"
      if [ -d "$file" ]; then
        cd "$file" || exit 1
        git checkout master
        git pull origin master:master
        cd "$xpath" || exit 1
      fi
    done
  fi
}


function install_app() {
  cd "$GOPATH/bin" || return
  for item in ${!package[*]}; do
    if [ ! -x "./$item" ]; then
      go install "${package[$item]}"
      printf "%s installed !\n" "$item"
    fi
  done


  keyifypath=$GOPATH/src/honnef.co/go/tools
  keyifyrepo="git@github.com:dominikh/go-tools.git"

  if [ ! -e "$keyifypath" ]; then
    git clone $keyifyrepo "$keyifypath"
  fi
}


deps_download_or_update

install_app


  # go get -u github.com/golang/dep/cmd/dep
  # go get -u github.com/sourcegraph/go-langserver
  # go get -u github.com/golang/protobuf/protoc-gen-go
  # go get -u github.com/klauspost/asmfmt/cmd/asmfmt
  # go get -u github.com/go-delve/delve/cmd/dlv
  # go get -u github.com/kisielk/errcheck
  # go get -u github.com/davidrjenni/reftools/cmd/fillstruct
  # go get -u github.com/mdempsky/gocod
  # go get -u github.com/stamblerre/gocode
  # go get -u github.com/rogpeppe/godef
  # go get -u github.com/zmb3/gogetdoc
  # go get -u golang.org/x/tools/cmd/goimports
  # go get -u golang.org/x/lint/golint
  # go get -u golang.org/x/tools/cmd/gopls
  # go get -u github.com/alecthomas/gometalinter
  # go get -u github.com/golangci/golangci-lint/cmd/golangci-lint
  # go get -u github.com/fatih/gomodifytags
  # go get -u golang.org/x/tools/cmd/gorename
  # go get -u github.com/jstemmer/gotags
  # go get -u golang.org/x/tools/cmd/guru
  # go get -u github.com/josharian/impl
  # go get -u honnef.co/go/tools/cmd/keyify
  # go get -u github.com/fatih/motion
  # go get -u github.com/koron/iferr
