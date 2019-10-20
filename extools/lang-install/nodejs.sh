#! /usr/bin/env bash

#================================================================================
# File Name    : extools/lang-install/nodejs.sh
# Author       : AlanDing
# Created Time : Thu 06 Jun 2019 02:40:33 PM CST
# Description  : 
#================================================================================

# Install nvm/lang {{{
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

# set domestic mirror
npm -g i nrm && nrm use taobao
npm -g i yarn
yarn config set registry 'https://registry.npm.taobao.org'
# }}}


# Install global pkgs {{{
# editor
npm -g i --unsafe-perm bash-language-server
npm -g i diagnostic-languageserver
npm -g i vim-language-server
npm -g i javascript-typescript-langserver
npm -g i vscode-css-languageserver-bin
npm -g i vue-language-server
npm -g i dockerfile-language-server-nodejs
npm -g i neovim

# blog and web generator
npm -g i hexo-cli
npm -g i gitbook-cli

npm -g i \
  js-beautify \
  import-js \
  remark \
  remark-cli \
  remark-stringify \
  remark-frontmatter \
  wcwidth \
# }}}


# @handy runtime libs {{{
npm -g i \
  lodash @types/lodash \
  axios \
  qs \
  rimraf
# }}}


# dev dependencies {{{

# React
npm i -g -D react react-dom @types/react @types/react-dom \
  create-react-app

# Vue
npm i -g -D vue @vue-cli @vue-cli-service eslint-plugin-vue \
  vue-loader vue-template-compiler

# 只用于快速原型开发
# npm i -g @vue/cli-server-global

npm i -g -D bootstrap

npm i -g -D
  jest @types/jest \
  ts-jest \
  typescript


#--------------------------------------------------------------------------------
# @ tools
# package tools
#--------------------------------------------------------------------------------
npm i -g -D \
  webpack \
  webpack-cli webpack-dev-server webpack-merge \
  uglifyjs-webpack-plugin \
  postcss-loader autoprefixer postcss-preset-env postcss-pxtorem

# loader
npm i -g -D \
  awesome-typescript-loader source-map-loader \
  stylus stylus-loader
npm i -g -D style-loader css-loader
# load pics and font
npm i -g -D file-loader
npm i -g -D url-loader
# load data
npm i -g -D csv-loader
npm i -g -D xml-loader


# lint
npm -g i -D eslint \
  @typescript-eslint/parser \
  @typescript-eslint/eslint-plugin 

npm -g i -D prettier \
  eslint-config-prettier \
  eslint-plugin-prettier

npm -g i -D stylelint \
  stylelint-webpack-plugin \
  stylus-supremacy


# git commit check
npm -g i -D husky


# babel es6 转码工具
npm i -g -D\
  # 调用API
  @babel/core \
  babel-loader \
  # preset 设定转码规则
  @babel/preset-env \
  @babel/preset-react \
  # es6 node-repl
  @babel/cli \
  @babel/node \
  @babel/register


# 检测es6的支持情况
npm -g i es-checker
# }}}


# npm -g i --save-dev @fortawesome/fontawesome-free
# npm config set "@fortawesome:registry" https://npm.fontawesome.com/ && \
  # npm config set "//npm.fontawesome.com/:_authToken" TOKEN
