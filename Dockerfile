FROM ubuntu:14.04

# Install basic developer tools
# Switch default mirror (which is currently down)
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/ubuntu.mirror.serversaustralia.com.au\/ubuntu\//' /etc/apt/sources.list
RUN apt-get update && apt-get install -y wget curl unzip git g++ build-essential cmake
RUN apt-get update && apt-get install -y libffi-dev opencl-headers
RUN apt-get update && apt-get install -y -q python2.7 python2.7-dev python-pip

# OpenCV dependecnies
RUN pip install numpy
RUN apt-get update && apt-get install -y -q libavformat-dev libavcodec-dev libavfilter-dev libswscale-dev
RUN apt-get update && apt-get install -y -q libjpeg-dev libpng-dev libtiff-dev libjasper-dev zlib1g-dev libopenexr-dev libxine-dev libeigen3-dev libtbb-dev
# Optional packages: libopencv-dev libavcodec-dev libavformat-dev libswscale-dev libvorbis-dev libxvidcore-dev v4l-utils libtheora-dev libopencore-amrnb-dev libopencore-amrwb-dev libdc1394-22 libdc1394-22-dev libpng12-dev
RUN apt-get update && apt-get install -y -q libgtk2.0-dev pkg-config libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libqt4-dev x264 liblapacke-dev libgflags-dev libgoogle-glog-dev
COPY build_opencv.sh /build_opencv.sh
RUN /bin/sh /build_opencv.sh
RUN rm -rf /build_opencv.sh
