#! /usr/bin/env bash

#================================================================================
# File Name    : extools/lang-install/python.sh
# Author       : AlanDing
# Created Time : Thu 06 Jun 2019 01:39:15 PM CST
# Description  : 
#================================================================================


#  Conda及pip配置文件路径
# ~/.condarc  
# ~/.pip/pip.conf

# Functions {{{
function install_conda_pip() {
  if [ -x conda ]; then
    cd /mnt/fun+downloads/linux系统安装/code-software/lang/python || return
    curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    sh ./Miniconda3-latest-Linux-x86_64.sh
    cd - || return

    # Conda 换源
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
    conda config --adzd channels https://mirrors.ustc.edu.cn/anaconda/pkgs/main/
    conda config --set show_channel_urls yes 
  fi

  [ ! -x "/usr/bin/pip" ] && ln -s /home/alanding/software/lang-tools/miniconda/bin/pip usr/bin/pip
}


function install_jupyter() {
  #1. 插件安装配置  
  pip install jupyter_contrib_nbextensions
  jupyter contrib nbextension install --user --skip-running-check

  jupyter-nbextension install rise --py --sys-prefix
  jupyter-nbextension enable rise --py --sys-prefix

  # VIM插件安装  
  [ -d "$(jupyter --data-dir)/nbextensions" ] && mkdir -p "$(jupyter --data-dir)/nbextensions"
  cd "$(jupyter --data-dir)/nbextensions" || return
  git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
  jupyter nbextension enable vim_binding/vim_binding

  # 初始化配置文件  
  jupyter notebook --generate-config --allow-root

  # 配置文件地址 {{{
  # ~/.jupyter/jupyter_notebook_config.py	

  #5. 修改默认配置, 别忘了注释掉行首的#  
  #   c.NotebookApp.allow_root = False	# 修改root限制  
  #   c.NotebookApp.ip = '0.0.0.0'  		# 修改本地登录  
  #   c.NotebookApp.notebook_dir = u'/home/alanding/0_Dev/Python-projects/Jupyter'	# 修改默认启动位置  

  #6. 加入密码-进入repl
  #   >>:from notebook.auth import passwd
  #   passwd()
  #   配置文件中修改：
  #   c.NotebookApp.password = u''
  # }}}
}


function install_pkgs() {
  # if [ ! -e "/home/alanding/software/anaconda3/envs/py37" ]; then
  # conda creat -n py37 python=3.7
  # pip install -r $HOME/.SpaceVim.d/extools/lang-install/python3-list.txt
  # fi


  # 安装pkgs
  pip install -r "$HOME/.SpaceVim.d/extools/lang-install/python3-list.txt"
}
# }}}


install_conda_pip
install_jupyter
install_pkgs

