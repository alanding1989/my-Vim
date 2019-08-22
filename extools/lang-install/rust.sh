#! /usr/bin/env bash


# File Name    : extools/lang-install/rust.sh
# Author       : AlanDing
# Created Time : Tue 13 Aug 2019 02:25:10 AM CST
# Description  : 


curl https://sh.rustup.rs -sSf | sh

rustup toolchain install stable
rustup default stable

rustup component add rust-src
rustup component add rls --toolchain stable
rustup component add rust-analysis --toolchain stable

cargo install racer

# rustup run stable rustc --version
