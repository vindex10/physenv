#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"hepmc"}
VERSION=${VERSION:-"02_06_10"}  # tag: VERSION

function get_hepmc() {
    pushd $SRC
    git clone --depth=1 https://gitlab.cern.ch/hepmc/HepMC.git "$TARGET"
    pushd "$TARGET"
    git fetch --depth=1 --tags
    git checkout "HEPMC_$VERSION"
    sed -i '42,43d' CMakeLists.txt
    popd
    popd
}

function build_hepmc() {
    pushd "$SRC/$TARGET"
    mkdir obj
    pushd obj
    prefix="${BUILD_DIR}/${TARGET}-${VERSION}"
    cmake -DCMAKE_C_FLAGS="-fno-omit-frame-pointer" -DCMAKE_CXX_FLAGS="-fno-omit-frame-pointer" -DCMAKE_INSTALL_PREFIX="$prefix" -Dmomentum:STRING="MEV" -Dlength:STRING="MM" ..
    make
    make install
    popd
    popd
}

case "$1" in
    "get")
        get_hepmc
    ;;
    "build")
        build_hepmc
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac
