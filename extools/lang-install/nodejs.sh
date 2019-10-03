#! /usr/bin/env bash

#================================================================================
# File Name    : extools/lang-install/nodejs.sh
# Author       : AlanDing
# Created Time : Thu 06 Jun 2019 02:40:33 PM CST
# Description  : 
#================================================================================

# install nvm
if [ ! -e "/opt/lang-tools/nvm" ]; then
  git clone git@github.com:nvm-sh/nvm.git /opt/lang-tools/nvm
  nvm install --lts && nvm use --lts
  nvm alias default "$(nvm version)"
  \. "$HOME/.zshrc"
  # nvm install node --reinstall-packages-from=node
fi

# link
nodepath=$(which node)
ln -s "$nodepath" /usr/bin/node
ln -s "$nodepath" /usr/bin/nodejs

# mirror
npm -g i nrm && nrm use taobao
npm -g i yarn
yarn config set registry 'https://registry.npm.taobao.org'

npm -g i --unsafe-perm bash-language-server
npm -g i diagnostic-languageserver
npm -g i vim-language-server
npm -g i javascript-typescript-langserver
npm -g i vscode-css-languageserver-bin
npm -g i neovim


npm -g i \
  js-beautifya \
  import-js \
  remark \
  remark-cli \
  remark-stringify \
  remark-frontmatter \
  rimraf \
  wcwidth \
  typescript \
  jest \
  ts-jest \

# @Devtools
# 检测es6的支持情况
npm -g i es-checker

# babel es6 转码工具
npm i -g -D\
  # 调用API
  @babel/core \
  # preset 设定转码规则
  @babel/preset-env \
  @babel/preset-react \
  # es6 node-repl
  @babel/cli \
  @babel/node \
  @babel/register

npm i -g -D\
  webpack \
  webpack-cli \
  webpack-dev-server

# lint
npm -g i -D eslint \
  @typescript-eslint/parser \
  @typescript-eslint/eslint-plugin 

npm -g i -D prettier \
  eslint-config-prettier \
  eslint-plugin-prettier

npm -g i -D husky

# npm -g i --save-dev @fortawesome/fontawesome-free
# npm config set "@fortawesome:registry" https://npm.fontawesome.com/ && \
  # npm config set "//npm.fontawesome.com/:_authToken" TOKEN
