#! /usr/bin/env bash

# ================================================================================
#  File Name    : extools/plugin-in-up/metals.sh
#  Author       : AlanDing
#  Created Time : Thu 25 Apr 2019 09:57:36 PM CST
# ================================================================================

# Make sure to use coursier v1.1.0-M9 or newer.
scalahome=/opt/lang-tools/scala

cd $scalahome || return
rm -rf $scalahome/coursier \
  && curl -L -o coursier https://git.io/coursier && chmod +x coursier

rm -rf $scalahome/scalafmt \
  && ./coursier bootstrap \
  org.scalameta:scalafmt-cli_2.12:2.0.0-RC7 \
  -r sonatype:snapshots \
  -o $scalahome/scalafmt --standalone --main org.scalafmt.cli.Cli

./scalafmt --version # should be 2.0.0-RC7
