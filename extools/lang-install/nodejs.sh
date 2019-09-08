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

# babel
npm -g i --save-dev @babel/core
npm -g i --save-dev @babel/preset-env
npm -g i --save-dev @babel/preset-react
npm -g i --save-dev @babel/cli
npm -g i --save-dev @babel/node
npm -g i --save-dev @babel/register
npm -g i --save-dev webpack
npm -g i --save-dev webpack-cli


npm -g i --unsafe-perm bash-language-server
npm -g i \
  es-checker \
  neovim \
  import-js \
  remark \
  remark-cli \
  remark-stringify \
  remark-frontmatter \
  rimraf \
  wcwidth \
  prettier \
  js-beautify \
  diagnostic-languageserver \
  vim-language-server \
  javascript-typescript-langserver \
  vscode-css-languageserver-bin \


# npm -g i --save-dev @fortawesome/fontawesome-free
# npm config set "@fortawesome:registry" https://npm.fontawesome.com/ && \
  # npm config set "//npm.fontawesome.com/:_authToken" TOKEN

#@ babel 用例
# # 转码结果输出到标准输出
# $ npx babel example.js
#
# # 转码结果写入一个文件
# # --out-file 或 -o 参数指定输出文件
# $ npx babel example.js --out-file compiled.js
# # 或者
# $ npx babel example.js -o compiled.js
#
# # 整个目录转码
# # --out-dir 或 -d 参数指定输出目录
# $ npx babel src --out-dir lib
# # 或者
# $ npx babel src -d lib
#
# # -s 参数生成source map文件
# # $ npx babel src -d lib -s


# @ babel/register模块改写require命令，为它加上一个钩子。
# 此后，每当使用require加载.js、.jsx、.es和.es6后缀名的文件，就会先用 Babel 进行转码。
# 然后，就不需要手动对index.js转码了。
# 需要注意的是，@babel/register只会对require命令加载的文件转码，而不会对当前文件转码。
# 另外，由于它是实时转码，所以只适合在开发环境使用。

# // index.js
# require('@babel/register');
# require('./es6.js');

