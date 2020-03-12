#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"lhapdf6"}
VERSION=${VERSION:-"6.2.3"}  # tag: lhapdf-${VERSION}

PDF_SOURCES=${PDF_SOURCES:-"http://lhapdfsets.web.cern.ch/lhapdfsets/current/"}
PDF_SETS=${PDF_SETS:-"CT14nnlo"}

function get_lhapdf6() {
    pushd $SRC
    hg clone "https://phab.hepforge.org/source/lhapdfhg/" "$TARGET"
    pushd "$TARGET"
    hg update "lhapdf-$VERSION"
    popd
    popd
}

function build_lhapdf6() {
    WD=`pwd`;
    pushd "${SRC}/${TARGET}"
    prefix="${WD}/${BUILD_DIR}/${TARGET}-${VERSION}"
    libtoolize --force
    aclocal
    autoheader
    automake --force-missing --add-missing
    autoconf
    CXXFLAGS="-fno-omit-frame-pointer" CFLAGS="-fno-omit-frame-pointer" ./configure --prefix="$prefix"
    make
    make install
    lhalib="$($prefix/bin/lhapdf-config --libdir)"
    lhadata="$($prefix/bin/lhapdf-config --datadir)"
    pymajdotmin="$(python -c 'import sys; print(str(sys.version_info[0]) + "." + str(sys.version_info[1]))')"
    lhapypath="${lhalib}64/python${pymajdotmin}/site-packages"
    PYTHONPATH="$lhapypath" LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$lhalib" $prefix/bin/lhapdf --source="${PDF_SOURCES}" --listdir="$lhadata" --pdfdir="$lhadata" update
    PYTHONPATH="$lhapypath" LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$lhalib" $prefix/bin/lhapdf --source="${PDF_SOURCES}" --listdir="$lhadata" --pdfdir="$lhadata" install "$PDF_SETS" --upgrade
    popd
}

case "$1" in
    "get")
        get_lhapdf6
    ;;
    "build")
        build_lhapdf6
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac
