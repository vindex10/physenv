#!/bin/bash

set -x
set -e

SCRIPTS_DIR=${SCRIPTS_DIR:-"`dirname $0`"}
BUILD_DIR=${BUILD_DIR:-"`pwd`/build"}

BUILD_DIR="$BUILD_DIR" $SCRIPTS_DIR/packages/root.sh build_nopythia
export root_build_dir="$BUILD_DIR/root-6-20-06"

BUILD_DIR="$BUILD_DIR" ROOT_BUILD_DIR="$root_build_dir" $SCRIPTS_DIR/packages/hepmc3.sh build_nopythia
export hepmc3_build_dir="$BUILD_DIR/hepmc3-3.2.2"

BUILD_DIR="$BUILD_DIR" $SCRIPTS_DIR/packages/lhapdf6.sh build
export lhapdf6_build_dir="$BUILD_DIR/lhapdf6-6.2.3"

BUILD_DIR="$BUILD_DIR" ROOT_BUILD_DIR="$root_build_dir" HEPMC3_BUILD_DIR="$hepmc3_build_dir" LHAPDF6_BUILD_DIR="$lhapdf6_build_dir" $SCRIPTS_DIR/packages/pythia8.sh build
export pythia8_build_dir="$BUILD_DIR/pythia8-8244"

BUILD_DIR="$BUILD_DIR" PYTHIA8_BUILD_DIR="$pythia8_build_dir" $SCRIPTS_DIR/packages/root.sh build_withpythia
export root_build_dir="$BUILD_DIR/root-6-20-06"

BUILD_DIR="$BUILD_DIR" ROOT_BUILD_DIR="$root_build_dir" $SCRIPTS_DIR/packages/yoda.sh build
export yoda_build_dir="$BUILD_DIR/yoda-1.8.2"

BUILD_DIR="$BUILD_DIR" $SCRIPTS_DIR/packages/fastjet.sh build
export fastjet_build_dir="$BUILD_DIR/fastjet-3.3.4"
BUILD_DIR="$BUILD_DIR" FASTJET_BUILD_DIR="$fastjet_build_dir" $SCRIPTS_DIR/packages/fastjet-contrib.sh build

BUILD_DIR="$BUILD_DIR" HEPMC3_BUILD_DIR="$hepmc3_build_dir" YODA_BUILD_DIR="$yoda_build_dir" FASTJET_BUILD_DIR="$fastjet_build_dir" $SCRIPTS_DIR/packages/rivet.sh build
export rivet_build_dir="$BUILD_DIR/rivet-3.1.1"

BUILD_DIR="$BUILD_DIR" $SCRIPTS_DIR/packages/openloops2.sh build
export openloops2_build_dir="$BUILD_DIR/openloops2-2.1.1"

BUILD_DIR="$BUILD_DIR" LHAPDF6_BUILD_DIR="$lhapdf6_build_dir" PYTHIA8_BUILD_DIR="$pythia8_build_dir" ROOT_BUILD_DIR="$root_build_dir" HEPMC3_BUILD_DIR="$hepmc3_build_dir" RIVET_BUILD_DIR="$rivet_build_dir" FASTJET_BUILD_DIR="$fastjet_build_dir" OPENLOOPS2_BUILD_DIR="$openloops2_build_dir" $SCRIPTS_DIR/packages/sherpa.sh build
export sherpa_build_dir="$BUILD_DIR/sherpa-2.2.10"

BUILD_DIR="$BUILD_DIR" LHAPDF6_BUILD_DIR="$lhapdf6_build_dir" PYTHIA8_BUILD_DIR="$pythia8_build_dir" ROOT_BUILD_DIR="$root_build_dir" HEPMC3_BUILD_DIR="$hepmc3_build_dir" RIVET_BUILD_DIR="$rivet_build_dir" FASTJET_BUILD_DIR="$fastjet_build_dir" OPENLOOPS2_BUILD_DIR="$openloops2_build_dir" $SCRIPTS_DIR/packages/sherpa.sh build_debug
export sherpa_build_dir="$BUILD_DIR/sherpa-2.2.10-debug"
