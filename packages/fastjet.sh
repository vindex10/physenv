#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"fastjet"}
VERSION=${VERSION:-"3.3.3"}

function get_fastjet() {
    pushd $SRC
    wget "http://fastjet.fr/repo/fastjet-$VERSION.tar.gz" -O "${TARGET}-${VERSION}".tgz
    tar -xvzf "${TARGET}-${VERSION}".tgz
    mv "fastjet-${VERSION}" "${TARGET}"
    popd
}

function build_fastjet() {
    WD=`pwd`;
    pushd "${SRC}/${TARGET}"
    prefix="${WD}/${BUILD_DIR}/${TARGET}-${VERSION}"
    CFLAGS="-fno-omit-frame-pointer" CXXFLAGS="-fno-omit-frame-pointer" ./configure --prefix="$prefix" --enable-allcxxplugins --enable-pyext
    make
    make install
    popd
}

case "$1" in
    "get")
        get_fastjet
    ;;
    "build")
        build_fastjet
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac
