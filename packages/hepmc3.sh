#!/bin/bash

set -x

SRC=${SRC:-src}
BUILD_DIR=${BUILD_DIR:-build}
TARGET=${TARGET:-"hepmc3"}
VERSION=${VERSION:-"3.2.0"}  # tag: VERSION

function get_hepmc3() {
    pushd $SRC
    git clone --depth=1 https://gitlab.cern.ch/hepmc/HepMC3.git "$TARGET"
    git fetch --depth=1 --tags
    git checkout "$VERSION"
    popd
}

function _build_hepmc3_common() {
    if [ -z "$ROOT_BUILD_DIR" ]; then
        echo "Please provide \$ROOT_BUILD_DIR"
        exit 1;
    fi;

    pythia8_flag=""
    if [ ! -z "$PYTHIA8_BUILD_DIR" ]; then
        pythia8_flag="-DPYTHIA8_ROOT_DIR:PATH=${PYTHIA8_BUILD_DIR}"
    fi;

    WD=`pwd`;
    pushd "$SRC/$TARGET"
    mkdir obj
    pushd obj
    py2majmin=$(python2 -c "import sys; print(str(sys.version_info[0]) + str(sys.version_info[1]))")
    py3majmin=$(python3 -c "import sys; print(str(sys.version_info[0]) + str(sys.version_info[1]))")
    prefix="${WD}/${BUILD_DIR}/${TARGET}-${VERSION}"
    LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT_BUILD_DIR}/lib" cmake -DCMAKE_C_FLAGS="-fno-omit-frame-pointer" -DCMAKE_CXX_FLAGS="-fno-omit-frame-pointer" -DCMAKE_INSTALL_PREFIX="$prefix" -DHEPMC3_Python_SITEARCH$py3majmin="$prefix/lib/python$py3majmin/site-packages" -DHEPMC3_Python_SITEARCH$py2majmin="$prefix/lib/python$py2majmin/site-packages" -DHEPMC3_PYTHON_VERSIONS="2.7,3.6" -DHEPMC3_BUILD_EXAMPLES=ON -DHEPMC3_ENABLE_ROOTIO=ON -DROOT_DIR="$ROOT_BUILD_DIR" $pythia8_flag ..
    make
    make install
    popd
    popd
}

function build_hepmc3_nopythia() {
    _build_hepmc3_common
}

function build_hepmc3_pythia() {
    if [ -z "$PYTHIA8_BUILD_DIR" ]; then
        echo "Please provide \$PYTHIA8_BUILD_DIR"
        exit 1;
    fi;
    _build_hepmc3_common
}

case "$1" in
    "get")
        get_hepmc3
    ;;
    "build_nopythia")
        build_hepmc3_nopythia
    ;;
    "build_withpythia")
        build_hepmc3_pythia
    ;;
    *)
        echo "Command $1 is not supported";
        exit 1
esac
