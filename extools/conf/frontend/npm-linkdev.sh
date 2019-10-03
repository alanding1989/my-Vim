#! /usr/bin/env bash

# File Name    : extools/lang-install/npm-dev.sh
# Author       : AlanDing
# Created Time : Wed 02 Oct 2019 02:34:51 PM CST
# Description  : 

npm link webpack

# lint
npm link eslint \
  @typescript-eslint/parser \
  @typescript-eslint/eslint-plugin 

npm link prettier \
  eslint-config-prettier \
  eslint-plugin-prettier

npm link jest ts-jest \
    husky


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
