#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"yoda"}
VERSION=${VERSION:-"1.8.0"}  # tag: yoda-VERSION

function get_yoda() {
    pushd $SRC
    wget "https://yoda.hepforge.org/downloads/?f=YODA-$VERSION.tar.gz" -O "${TARGET}-${VERSION}".tgz
    tar -xvzf "${TARGET}-${VERSION}".tgz
    mv "YODA-${VERSION}" "${TARGET}"
    popd
}

function build_yoda() {
    if [ -z "$ROOT_BUILD_DIR" ]; then
        echo "Please provide \$ROOT_BUILD_DIR";
        exit 1;
    fi

    pushd "${SRC}/${TARGET}"
    prefix="${BUILD_DIR}/${TARGET}-${VERSION}"

    PATH="$ROOT_BUILD_DIR/bin:$PATH" CFLAGS="-fno-omit-frame-pointer" CXXFLAGS="-fno-omit-frame-pointer" ./configure --prefix="$prefix"
    make
    make install

    popd
}

case "$1" in
    "get")
        get_yoda
    ;;
    "build")
        build_yoda
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac
