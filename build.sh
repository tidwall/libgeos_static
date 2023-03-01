#!/bin/bash

set -e

od=`pwd`
cd $(dirname "${BASH_SOURCE[0]}")

finish() {
	cd $od
}
trap finish EXIT

ncores=`getconf _NPROCESSORS_ONLN`

if [[ ! -d libgeos ]]; then
      echo Decompressing libgeos*.tar.gz...
      tar -xf libgeos*.tar.gz
fi

GITHASH=`cat libgeos/GITHASH`

# Build the library
mkdir -p build
cd build
cmake -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTING=OFF \
      -DBUILD_BENCHMARKS=OFF \
      -DCMAKE_INSTALL_PREFIX=install ../libgeos
make -j "$ncores" install
cd ../build/install
echo "#define GEOS_GITHASH \"$GITHASH\"" > include/geos_githash.h
