#!/bin/sh

mkdir build && cd build

cmake ..				\
      -DCMAKE_INSTALL_PREFIX=$PREFIX	\
      -DCMAKE_INSTALL_LIBDIR=$PREFIX/lib

make -j 4 install
