#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"sherpa"}
VERSION=${VERSION:-"2.2.8"}  # tag: vVERSION

DEBUG=${DEBUG:-"false"}

function get_sherpa() {
    pushd $SRC
    git clone --depth=1 https://gitlab.com/sherpa-team/sherpa.git "$TARGET"
    pushd "$TARGET"
    git fetch --depth=1 --tags
    git checkout "v$VERSION"
    popd
    popd
}

function _build_sherpa_common() {
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

    if [ -z "$RIVET_BUILD_DIR" ]; then
        echo "Please provide \$RIVET_BUILD_DIR";
        exit 1;
    fi

    if [ -z "$FASTJET_BUILD_DIR" ]; then
        echo "Please provide \$FASTJET_BUILD_DIR";
        exit 1;
    fi

    if [ -z "$PYTHIA8_BUILD_DIR" ]; then
        echo "Please provide \$PYTHIA8_BUILD_DIR";
        exit 1;
    fi

    if [ -z "$OPENLOOPS2_BUILD_DIR" ]; then
        echo "Please provide \$OPENLOOPS2_BUILD_DIR";
        exit 1;
    fi

    additional_flags=""
    version_suffix=""
    if [ "$DEBUG" = "true" ]; then
        additional_flags="-g -O0"
        version_suffix="-debug"
    fi

    pushd "${SRC}/${TARGET}"
    prefix="${BUILD_DIR}/${TARGET}-${VERSION}${version_suffix}"

    libtoolize --force
    aclocal
    autoheader
    automake --force-missing --add-missing
    autoconf

    CFLAGS="-fno-omit-frame-pointer $additional_flags" CXXFLAGS="-fno-omit-frame-pointer $additional_flags" ./configure --prefix="$prefix" --enable-pyext --enable-ufo --enable-hepmc3root  --enable-hepmc2="$HEPMC_BUILD_DIR" --enable-rivet="$RIVET_BUILD_DIR" --enable-fastjet="$FASTJET_BUILD_DIR" --enable-root="$ROOT_BUILD_DIR" --enable-lhapdf="$LHAPDF6_BUILD_DIR" --enable-pythia="$PYTHIA8_BUILD_DIR" --enable-openloops="$OPENLOOPS2_BUILD_DIR" --enable-gzip
    make
    make install
    popd
}

function build_sherpa() {
    _src_clean
    _build_sherpa_common
}

function build_sherpa_debug() {
    _src_clean
    DEBUG=true _build_sherpa_common
}

function _src_clean() {
    pushd "${SRC}/${TARGET}"
    git clean -x -d -f
    git reset --hard
    popd
}

case "$1" in
    "get")
        get_sherpa
    ;;
    "build")
        build_sherpa
    ;;
    "build_debug")
        build_sherpa_debug
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac
