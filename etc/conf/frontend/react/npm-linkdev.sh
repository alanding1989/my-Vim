#! /usr/bin/env bash

# devdependencies link

# react
npm link react
npm link react-dom
npm link @types/react
npm link @types/react-dom

# vue
# npm link @vue/cli
# npm link @vue/cli-service
# npm link vue-style-loader
# npm link eslint-plugin-vue


# lint {{{
npm link eslint
npm link @typescript-eslint/parser
npm link @typescript-eslint/eslint-plugin

npm link prettier
npm link eslint-config-prettier
npm link eslint-plugin-prettier

npm link stylelint
npm link stylelint-webpack-plugin
# }}}


# test
npm link jest
npm link @types/jest
npm link ts-jest


# build {{{
npm link webpack
npm link html-webpack-plugin
npm link clean-webpack-plugin

# npm link ts-loader
npm link awesome-typescript-loader
npm link source-map-loader
# loader
npm link style-loader
npm link css-loader
# css precessor
npm link stylus
npm link stylus-loader
# postcss
npm link postcss-loader
npm link autoprefixer
npm link postcss-preset-env
npm link postcss-pxtorem


# load icon and font
npm link file-loader
# load data
npm link csv-loader
npm link xml-loader

# tranform es6
npm link @babel/core
npm link babel-loader
npm link @babel/preset-env
npm link @babel/preset-react
npm link @babel/cli
npm link @babel/register
# }}}


# git commit check
npm link husky


#@ babel 用例 {{{
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
# }}}
