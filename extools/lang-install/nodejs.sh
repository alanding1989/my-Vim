#! /usr/bin/env bash

#================================================================================
# File Name    : extools/lang-install/nodejs.sh
# Author       : AlanDing
# Created Time : Thu 06 Jun 2019 02:40:33 PM CST
# Description  : 
#================================================================================


if [ ! -e "/opt/lang-tools/nvm" ]; then
  git clone git@github.com:nvm-sh/nvm.git /opt/lang-tools/nvm
  nvm install --lts && nvm use --lts
  nvm alias default "$(nvm version)"
  \. "$HOME/.zshrc"
  # nvm install node --reinstall-packages-from=node
fi

nodepath=$(which node)
ln -s "$nodepath" /usr/bin/node
ln -s "$nodepath" /usr/bin/nodejs

npm -g i nrm && nrm use taobao
npm -g i yarn
yarn config set registry 'https://registry.npm.taobao.org'

npm -g i --unsafe-perm bash-language-server
npm -g i neovim import-js remark remark-cli remark-stringify remark-frontmatter \
rimraf wcwidth prettier diagnostic-languageserver vim-language-server \
javascript-typescript-langserver vscode-css-languageserver-bin \

# npm -g i --save-dev @fortawesome/fontawesome-free
# npm config set "@fortawesome:registry" https://npm.fontawesome.com/ && \
  # npm config set "//npm.fontawesome.com/:_authToken" TOKEN
