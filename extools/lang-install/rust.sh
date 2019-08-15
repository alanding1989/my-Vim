#! /usr/bin/env bash


# File Name    : extools/lang-install/rust.sh
# Author       : AlanDing
# Created Time : Tue 13 Aug 2019 02:25:10 AM CST
# Description  : 


curl https://sh.rustup.rs -sSf | sh

rustup toolchain install nightly
rustup default nightly
rustup component add rust-src
# rustup run nightly rustc --version

cargo install racer

rustup component add rls --toolchain nightly
rustup component add rust-analysis --toolchain nightly
rustup component add rust-src --toolchain nightly

