#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"openloops2"}
VERSION=${VERSION:-"2.1.0"}  # tag: OpenLoops-$VERSION

OPENLOOP_LIBS="lhc.coll bbhj heftpphj heftpphjj heftpphjjj pphbb pphbbj pphj2 pphjj2 pphjj_vbf pphjj_vbf_ew pphjjj2 pphll pphll2 pphll_ew pphllj pphllj2 pphllj_ew pphlljj pphlljj_top pphlnj_ckm pphlnjj pphv pphv_ew pphwjj pphz2 pphzj2 pphzjj"

function get_openloops2() {
    pushd $BUILD_DIR  # OpenLoops works from the source dir
    git clone --depth=1 https://gitlab.com/openloops/OpenLoops.git "$TARGET-$VERSION"
    pushd "$TARGET-$VERSION"
    git pull --tags --depth=1
    git checkout "OpenLoops-$VERSION"
    cat openloops.cfg.tmpl | sed 's/#gfortran_f77_flags =/gfortran_f77_flags = -fno-omit-frame-pointer/' \
                           | sed 's/#gfortran_f90_flags =/gfortran_f90_flags = -fno-omit-frame-pointer/' \
                           | sed 's/#gfortran_f_flags =/gfortran_f_flags = -fno-omit-frame-pointer/' \
                           | sed 's/#ifort_f77_flags =/ifort_f77_flags = -fno-omit-frame-pointer/' \
                           | sed 's/#ifort_f90_flags =/ifort_f90_flags = -fno-omit-frame-pointer/' \
                           | sed 's/#ifort_f_flags =/ifort_f_flags = -fno-omit-frame-pointer/' \
                           | sed 's/#ccflags =/ccflags = -fno-omit-frame-pointer/' \
                           | sed 's/#cxxflags =/cxxflags = -fno-omit-frame-pointer/' > openloops.cfg

    popd
    popd
}

function build_openloops2() {
    pushd "${BUILD_DIR}/${TARGET}-${VERSION}"
    ./scons
    ./openloops libinstall "$OPENLOOP_LIBS" compile_extra=1
    popd
}

case "$1" in
    "get")
        get_openloops2
    ;;
    "build")
        build_openloops2
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac
