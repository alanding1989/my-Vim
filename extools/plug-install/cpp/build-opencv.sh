#! /usr/bin/env bash


# File Name    : extools/plug-install/build-opencv.sh
# Author       : AlanDing
# Created Time : Thu 08 Aug 2019 08:56:02 AM CST
# Description  : 


path="/mnt/fun+downloads/linux系统安装/code-software/lang/cpp/opencv"

sudo apt-get install pkg-config libavcodec-dev libavformat-dev libswscale-dev \
  libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev

[ -e "/usr/include/Eigen" ] || \
  (sudo apt-get install libeigen3-dev && cp -r /usr/include/eigen3/Eigen /usr/include)

[ -e $path ] || git clone https://github.com/Itseez/opencv.git $path
[ -e $path/opencv_contrib ] || git clone https://github.com/Itseez/opencv_contrib.git "$path/opencv_contrib"
[ -e $path/build ] || mkdir "$path/build"

cd $path || (echo 'cd failed' && exit)

cmake -DCMAKE_BUILD_TYPE=Release \
  -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules ..\
  -D CMAKE_INSTALL_PREFIX=/opt/lang-tools/cpp/opencv ..\
  -D OPENCV_DOC_INSTALL_PATH=/opt/lang-tools/cpp/opencv/docs ..\
  -D BUILD_EXAMPLES=ON \
  -D INSTALL_C_EXAMPLES=ON \
  -D INSTALL_PYTHON_EXAMPLES=ON \
  -D OPENCV_PYTHON3_VERSION=3.7 \
  -D PYTHON3_EXECUTABLE=/home/alanding/software/anaconda3/envs/py37/bin/python3.7 \
  -D PYTHON3_INCLUDE_DIR=/home/alanding/software/anaconda3/envs/py37/include/python3.7m \
  -D PYTHON3_LIBRARY=/home/alanding/software/anaconda3/envs/py37/lib/libpython3.7m.so \
  -D PYTHON3_NUMPY_INCLUDE_DIRS=/home/alanding/software/anaconda3/envs/py37/lib/python3.7/site-packages/numpy/core/include \
  -D PYTHON3_PACKAGES_PATH=/home/alanding/software/anaconda3/envs/py37/lib/python3.7/site-packages \
  -D BUILD_opencv_python3=ON \
  -D BUILD_opencv_python2=OFF \
  -D WITH_CUDA=ON \
  -D CUDA_TOOLKIT_ROOT_DIR=/home/alanding/software/cuda/cuda-10.0 \
  -D WITH_TBB=ON ../opencv ..\
  -D WITH_TIFF=ON \
  -D ENABLE_FAST_MATH=1 \
  -D CUDA_FAST_MATH=1 \
  -D WITH_CUBLAS=1 \
  -D OPENCV_ENABLE_NONFREE=ON \
  -D EIGEN_INCLUDE_PATH=/usr/include/eigen3

make -j8
sudo make install

ln -s /opt/lang-tools/cpp/opencv/include/opencv4/opencv2 /usr/include/opencv2
ln -s /opt/lang-tools/cpp/opencv/lib /usr/lib/opencv2

