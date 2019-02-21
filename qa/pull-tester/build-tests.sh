#!/bin/bash
# Param1: The prefix to mingw staging
# Param2: Path to java comparison tool
# Param3: Number of make jobs. Defaults to 1.

set -e
set -o xtrace

MINGWPREFIX=$1
JAVA_COMPARISON_TOOL=$2
JOBS=${3-1}

if [ $# -lt 2 ]; then
  echo "Usage: $0 [mingw-prefix] [java-comparison-tool] <make jobs>"
  exit 1
fi

DISTDIR=bitcoinair-0.8.6

cd /media/root/Data1/Projects/qt/bitcoin-air-blockchain-v1.0
make distdir
mv $DISTDIR linux-build
cd linux-build
./configure --with-comparison-tool="$JAVA_COMPARISON_TOOL"
make -j$JOBS
make check

#Test code coverage
cd /media/root/Data1/Projects/qt/bitcoin-air-blockchain-v1.0
make distdir
mv $DISTDIR linux-coverage-build
cd linux-coverage-build
./configure --enable-lcov --with-comparison-tool="$JAVA_COMPARISON_TOOL"
make -j$JOBS
make cov

# win32 build disabled until pull-tester has updated dependencies
##Test win32 build
#cd /media/root/Data1/Projects/qt/bitcoin-air-blockchain-v1.0
#make distdir
#mv $DISTDIR win32-build
#cd win32-build
#./configure --prefix=$MINGWPREFIX --host=i586-mingw32msvc --with-qt-bindir=$MINGWPREFIX/host/bin --with-qt-plugindir=$MINGWPREFIX/plugins --with-qt-incdir=$MINGWPREFIX/include --with-boost=$MINGWPREFIX --with-protoc-bindir=$MINGWPREFIX/host/bin --with-comparison-tool="$JAVA_COMPARISON_TOOL" CPPFLAGS=-I$MINGWPREFIX/include LDFLAGS=-L$MINGWPREFIX/lib
#make -j$JOBS
#make check
