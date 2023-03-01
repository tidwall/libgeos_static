#!/bin/bash

set -e

# Download the repository

if [ "$1" == "" ]; then
	echo "error: missing git checkout branch/tag/hash"
	echo "usage: $0 {branch/tag/hash}"
	echo "example: $0 3.11.1"
	echo "     or: $0 main"
	exit 1
fi

GEOS_CHECKOUT="$1"

od=`pwd`
cd $(dirname "${BASH_SOURCE[0]}")
wd=`pwd`

finish() {
	cd $wd
	rm -rf libgeos libgeos.dl build
	cd $od
}
trap finish EXIT

rm -rf libgeos libgeos.dl libgeos*.tar.gz
git clone https://github.com/libgeos/geos.git libgeos.dl
cd libgeos.dl
git checkout -q "$GEOS_CHECKOUT"
git_hash=`git rev-parse HEAD`
echo Switched to $git_hash.
echo $git_hash > GITHASH
source Version.txt
vers=$GEOS_VERSION_MAJOR.$GEOS_VERSION_MINOR.$GEOS_VERSION_PATCH$GEOS_PATCH_WORD
rm -rf .git
cd ..
rm -rf libgeos 
mv libgeos.dl libgeos
rm -rf libgeos/tests libgeos/web
echo Compressing libgeos-$vers.tar.gz...
GZIP=-9 tar -czf libgeos-$vers.tar.gz libgeos
