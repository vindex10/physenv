#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"fastjet-contrib"}
VERSION=${VERSION:-"1.044"}

function get_fastjet_contrib() {
    pushd $SRC
    wget "http://fastjet.hepforge.org/contrib/downloads/fjcontrib-1.044.tar.gz" -O "${TARGET}-${VERSION}".tgz
    tar -xvzf "${TARGET}-${VERSION}".tgz
    mv "fjcontrib-${VERSION}" "${TARGET}"
    popd
}

function build_fastjet_contrib() {
    if [ -z "$FASTJET_BUILD_DIR" ]; then
        echo "Please provide \$FASTJET_BUILD_DIR";
        exit 1;
    fi

    WD=`pwd`;
    pushd "${SRC}/${TARGET}"
    CFLAGS="-fno-omit-frame-pointer" CXXFLAGS="-fno-omit-frame-pointer" ./configure --fastjet-config="$FASTJET_BUILD_DIR/bin/fastjet-config"
    make
    make install
    make fragile-shared
    make fragile-shared-install
    popd
}

case "$1" in
    "get")
        get_fastjet_contrib
    ;;
    "build")
        build_fastjet_contrib
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac
