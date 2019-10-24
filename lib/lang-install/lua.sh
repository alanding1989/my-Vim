#! /usr/bin/env bash



# File Name    : extools/lang-install/lua.sh
# Author       : AlanDing
# Created Time : Tue 28 May 2019 08:03:47 PM CST
# Description  : 


# cd_mkdircd() {
#   if [ ! -e "$2" ]; then
#     sudo mkdir -p "$2"
#   fi
#   cd "$2" || return
# }
#
# CheckRepo_Update() {
#   # ""$2"": repodir
#   # $2: git repo url
#   if [ ! -e "$2" ]; then
#     git clone "$2" && cd "$2" || return
#   else
#     cd "$2" && git pull
#   fi
# }


cd_tmp_down(){
  # $1: curl or git
  # $2: url
  # $3: dir or file
  cd /tmp || return
  if [[ "$1" = "curl" ]]; then
    curl -R -O "$2" && tar -zxf "$3"
  elif [[ "$1" = "git" ]]; then
    git clone "$2" && cd "$3" || return
  fi
}

cd_tmp_down curl http://www.lua.org/ftp/lua-5.3.5.tar.gz lua-5.3.5.tar.gz

cd lua-5.3.5 || return
make linux test
sudo make install

if [ ! -e "/opt/lang-tools/lua/luarocks" ]; then
  cd /tmp && git clone git@github.com:luarocks/luarocks.git && cd luarocks || return
  ./configure --prefix=/opt/lang-tools/lua/luarocks
  make && make install
fi

