#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"root"}
VERSION=${VERSION:-"6-20-00"}  # tag: vVERSION

function get_root() {
    pushd $SRC
    git clone --depth=1 http://github.com/root-project/root.git "$TARGET"
    pushd "$TARGET"
    git fetch --depth=1 --tags
    git checkout "v$VERSION"
    popd
    popd
}

function _build_root_common() {
    pythia8_flag="-Dpythia8:boolean=OFF"
    if [ ! -z "$PYTHIA8_BUILD_DIR" ]; then
        pythia8_flag="-Dpythia8:boolean=ON -DPYTHIA8_INCLUDE_DIR=${PYTHIA8_BUILD_DIR}/include -DPYTHIA8_LIBRARY=${PYTHIA8_BUILD_DIR}/lib/libpythia8.so"
    fi;

    WD=`pwd`;
    pushd "${SRC}/${TARGET}"
    mkdir obj
    pushd obj
    cmake -DCMAKE_C_FLAGS="-fno-omit-frame-pointer" -DCMAKE_CXX_FLAGS="-fno-omit-frame-pointer" -DCMAKE_INSTALL_PREFIX="${WD}/${BUILD_DIR}/${TARGET}-${VERSION}" -Dbuiltin_llvm:boolean=ON -Dpythia6:boolean=OFF $pythia8_flag -Dminuit2:boolean=ON -Droofit:boolean=ON -Dtmva:boolean=ON -Dunuran:boolean=ON -Dvc:boolean=ON -Dvdt:boolean=ON -Dx11:boolean=ON ..
    make
    make install
    popd
    popd
}

function build_root_nopythia() {
    _build_root_common
}

function build_root_withpythia() {
    if [ -z "$PYTHIA8_BUILD_DIR" ]; then
        echo "Please provide \$PYTHIA8_BUILD_DIR"
        exit 1;
    fi;

    _build_root_common
}

case "$1" in
    "get")
        get_root
    ;;
    "build_nopythia")
        build_root_nopythia
    ;;
    "build_withpythia")
        build_root_withpythia
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac
