#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"pythia8"}
VERSION=${VERSION:-"8244"}

function get_pythia8() {
    pushd $SRC
    wget "http://home.thep.lu.se/~torbjorn/pythia8/pythia${VERSION}.tgz" -O "${TARGET}-${VERSION}".tgz
    tar -xvzf "${TARGET}-${VERSION}".tgz
    mv "pythia${VERSION}" "${TARGET}"
    popd
}

function build_pythia8() {
    if [ -z "$ROOT_BUILD_DIR" ]; then
        echo "Please provide \$ROOT_BUILD_DIR";
        exit 1;
    fi

    if [ -z "$LHAPDF6_BUILD_DIR" ]; then
        echo "Please provide \$LHAPDF6_BUILD_DIR";
        exit 1;
    fi

    if [ -z "$HEPMC_BUILD_DIR" ]; then
        echo "Please provide \$HEPMC_BUILD_DIR";
        exit 1;
    fi

    pushd "${SRC}/${TARGET}"
    prefix="${BUILD_DIR}/${TARGET}-${VERSION}"
    pyinclude=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")
    pylib=$(python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))")
    ./configure --enable-64bit --enable-shared --cxx-common="-fPIC -fno-omit-frame-pointer" --with-python-bin="/usr/bin" --with-python-include="$pyinclude" --with-python-lib="$pylib" --with-root="$ROOT_BUILD_DIR" --with-lhapdf6="$LHAPDF6_BUILD_DIR" --with-hepmc2="$HEPMC_BUILD_DIR" --with-hepmc3="$HEPMC3_BUILD_DIR" --prefix="$prefix"
     make
     make install
    popd
}

case "$1" in
    "get")
        get_pythia8
    ;;
    "build")
        build_pythia8
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac
