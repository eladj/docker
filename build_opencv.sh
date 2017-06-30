#!/usr/bin/env bash

# Script to install OpenCV 3.2.0 with contrib on Ubuntu 16.04
# sudo apt-get -y install wget libopencv-dev build-essential cmake git unzip libgtk2.0-dev pkg-config python-dev python-numpy libdc1394-22 libdc1394-22-dev libjpeg-dev libpng12-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils liblapacke-dev libeigen3-dev libgflags-dev libgoogle-glog-dev
mkdir /opencv
cd /opencv
wget https://github.com/opencv/opencv/archive/3.2.0.zip -O opencv-3.2.0.zip
wget https://github.com/opencv/opencv_contrib/archive/3.2.0.zip -O opencv-contrib-3.2.0.zip
unzip opencv-3.2.0.zip
unzip opencv-contrib-3.2.0.zip
cd /opencv/opencv-3.2.0
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.2.0/modules \
            -D CMAKE_CXX_COMPILER=/usr/bin/g++ -D CMAKE_C_COMPILER=/usr/bin/gcc \
            -D ENABLE_FAST_MATH=1 -D CUDA_FAST_MATH=1 -D WITH_CUBLAS=1 -D WITH_LAPACK=ON \
            -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_GSTREAMER=ON \
            -D INSTALL_C_EXAMPLES=OFF -D BUILD_DOCS=OFF -D BUILD_EXAMPLES=OFF \
            -D INSTALL_PYTHON_EXAMPLES=OFF ..
make -j $(nproc)
sudo make install
sudo /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
cd /
rm -rf /opencv

# Check installed version: pkg-config --modversion opencv
# To remove OpenCV: sudo apt-get remove opencv
