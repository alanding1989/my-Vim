#! /usr/bin/env bash

# pip install when-changed 监控文件变动并且文件修改之后自动执行 pytest 单测，方便我们边修改边跑测试
# 将该文件放在项目根目录

# -r watch recursively
# -v verbose output
# -1 don`t re-run command if files changed while command was running

when-changed -vr1s ./  "pytest -s $1"
