#! /usr/bin/env bash

#================================================================================
# File Name    : extools/lang-install/nodejs.sh
# Author       : AlanDing
# Created Time : Thu 06 Jun 2019 02:40:33 PM CST
# Description  : 
#================================================================================


if [ ! -e "/opt/lang-tools/nvm" ]; then
  git clone https://github.com/creationix/nvm.git /opt/lang-tools/nvm
  nvm install v11.9.0
  nvm alias default v11.9.0
  source "$HOME/.zshrc"
fi

nodepath=$(which node)
ln -s "$nodepath" /usr/bin/node
ln -s "$nodepath" /usr/bin/nodejs

npm -g i nrm && nrm use taobao
npm config set "@fortawesome:registry" https://npm.fontawesome.com/ && \
  npm config set "//npm.fontawesome.com/:_authToken" TOKEN

npm -g i yarn
yarn config set registry 'https://registry.npm.taobao.org'
npm -g i rimraf
npm -g i neovim
npm -g i import-js
npm -g i remark
npm -g i remark-cli
npm -g i remark-stringify
npm -g i remark-frontmatter
npm -g i wcwidth
npm -g i bash-language-server
npm -g i javascript-typescript-langserver
npm -g i vscode-css-languageserver-bin
npm -g i --save-dev @fortawesome/fontawesome-free
yarn global add prettier
yarn global add diagnostic-languageserver
yarn global add vim-language-server
