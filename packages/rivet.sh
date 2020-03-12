#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"rivet"}
VERSION=${VERSION:-"2.7.2"}  # tag: rivet-${VERSION}

function get_rivet() {
    pushd $SRC
    git clone --depth=1 https://gitlab.com/hepcedar/rivet.git "$TARGET"
    pushd "$TARGET"
    git fetch --depth=1 --tags
    git checkout "rivet-$VERSION"
    popd
    popd
}

function build_rivet() {
    if [ -z "$HEPMC3_BUILD_DIR" ]; then
        echo "Please provide \$HEPMC3_BUILD_DIR";
        exit 1;
    fi

    if [ -z "$YODA_BUILD_DIR" ]; then
        echo "Please provide \$YODA_BUILD_DIR";
        exit 1;
    fi

    if [ -z "$FASTJET_BUILD_DIR" ]; then
        echo "Please provide \$FASTJET_BUILD_DIR";
        exit 1;
    fi


    WD=`pwd`;
    pushd "${SRC}/${TARGET}"
    prefix="${WD}/${BUILD_DIR}/${TARGET}-${VERSION}"

    libtoolize --force
    aclocal
    autoheader
    automake --force-missing --add-missing
    autoconf
    
    CXXFLAGS="-fno-omit-frame-pointer" CFLAGS="-fno-omit-frame-pointer" ./configure --prefix="$prefix" --with-hepmc3="$HEPMC3_BUILD_DIR" --with-yoda="$YODA_BUILD_DIR" --with-fastjet="$FASTJET_BUILD_DIR"
    make
    make install
    popd
}

case "$1" in
    "get")
        get_rivet
    ;;
    "build")
        build_rivet
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac