#! /usr/bin/env bash


# File Name    : linux/alan-home/copy.sh
# Author       : AlanDing
# Created Time : Sun 20 Oct 2019 08:57:25 PM CST
# Description  : 

declare files=(
software/lang-tools/cargo/config
.cgdb/
.conda/
.config/asciinema/install-id
.config/autostart
.config/coc/ultisnips
.config/Code/User/snippets
.config/Code/User/keybindings.json
.config/Code/User/projects.json
.config/Code/User/settings.json
.config/efm-langserver
.config/fcitx/conf
.config/fcitx/cached_layout
.config/fcitx/config
.config/fcitx/profile
.config/fontconfig
.config/gtk-3.0
.config/netease-cloud-music/netease-cloud-music.ini
.config/qBittorrent/qBittorrent.conf
.config/translator
.config/Ulduzsoft
.config/xm1
.config/albert.conf
.config/mimeapps.list
.config/user-dirs.dirs
.config/user-dirs.locale
.docker/
.goldendict/config
.gradle/init.gradle
.ipython/profile_default/ipython_config.py
.irssi/
.local/share/applications
.jupyter/
.m2/settings.xml
.pip/
.rustup/
.sbt/1.0/plugins/ensime.sbt
.sbt/plugins/ensime.sbt
.sbt/repositories
.sbt/conf
.tmux/plugins/tmux-statusbar.tmux
.agignore
.bash_history
.bashrc
.condarc
.cookiecutterrc
.gemrc
.gitconfig
.globalrc
.ideavimrc
.mongorc.js
.npmrc
.nvidia-settings-rc
.shellcheckrc
.tmux.conf
.vintrc.yaml
.vuerc
.warprc
.xinputrc
.yarnrc
.zsh_history
.zshrc
)

dstbase=/mnt/fun+downloads/my-Dotfile/linux/alan-home

for file in "${files[@]}"; do
  dir="$(dirname $file)"
  if [ $dir == '.' ]; then
    cp -rf $HOME/$file /mnt/fun+downloads/my-Dotfile/linux/alan-home
  else
    [ ! -e $dstbase/$dir ] && mkdir -p $dstbase/$dir
    cp -rf $HOME/$file /mnt/fun+downloads/my-Dotfile/linux/alan-home/$dir
  fi
done
