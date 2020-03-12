#!/bin/bash

SCRIPTS_DIR=${SCRIPTS_DIR:-"`dirname $0`"}
BUILD_DIR=${BUILD_DIR:-"`pwd`/build"}

BUILD_DIR="$BUILD_DIR" $SCRIPTS_DIR/packages/root.sh build_nopythia
root_build_dir="$BUILD_DIR/root-6-20-00"

BUILD_DIR="$BUILD_DIR" ROOT_BUILD_DIR="$root_build_dir" $SCRIPTS_DIR/packages/hepmc3.sh build
hepmc3_build_dir="$BUILD_DIR/hepmc3-3.2.0"

BUILD_DIR="$BUILD_DIR" $SCRIPTS_DIR/packages/lhapdf6.sh build
lhapdf6_build_dir="$BUILD_DIR/lhapdf6-6.2.3"

BUILD_DIR="$BUILD_DIR" ROOT_BUILD_DIR="$root_build_dir" LHAPDF6_BUILD_DIR="$lhapdf6_build_dir" HEPMC3_BUILD_DIR="$hepmc3_build_dir" $SCRIPTS_DIR/packages/pythia8.sh build
pythia8_build_dir="$BUILD_DIR/pythia8-8244"

BUILD_DIR="$BUILD_DIR" PYTHIA8_BUILD_DIR="$pythia8_build_dir" $SCRIPTS_DIR/packages/root.sh build_withpythia
root_build_dir="$BUILD_DIR/root-6-20-00"

BUILD_DIR="$BUILD_DIR" ROOT_BUILD_DIR="$root_build_dir" $SCRIPTS_DIR/packages/yoda.sh build
yoda_build_dir="$BUILD_DIR/yoda-1.8.0"

BUILD_DIR="$BUILD_DIR" $SCRIPTS_DIR/packages/fastjet.sh build
BUILD_DIR="$BUILD_DIR" $SCRIPTS_DIR/packages/fastjet-contrib.sh build
fastjet_build_dir="$BUILD_DIR/fastjet-3.3.3"

BUILD_DIR="$BUILD_DIR" HEPMC3_BUILD_DIR="$hepmc3_build_dir" YODA_BUILD_DIR="$yoda_build_dir" FASTJET_BUILD_DIR="$fastjet_build_dir" $SCRIPTS_DIR/packages/rivet.sh build
rivet_build_dir="$BUILD_DIR/rivet-2.7.2"

BUILD_DIR="$BUILD_DIR" LHAPDF6_BUILD_DIR="$lhapdf6_build_dir" PYTHIA8_BUILD_DIR="$pythia8_build_dir" ROOT_BUILD_DIR="$root_build_dir" HEPMC3_BUILD_DIR="$hepmc3_build_dir" RIVET_BUILD_DIR="$rivet_build_dir" FASTJET_BUILD_DIR="$fastjet_build_dir" $SCRIPTS_DIR/packages/sherpa.sh build
sherpa_build_dir="$BUILD_DIR/sherpa-2.2.8"

BUILD_DIR="$BUILD_DIR" LHAPDF6_BUILD_DIR="$lhapdf6_build_dir" PYTHIA8_BUILD_DIR="$pythia8_build_dir" ROOT_BUILD_DIR="$root_build_dir" HEPMC3_BUILD_DIR="$hepmc3_build_dir" RIVET_BUILD_DIR="$rivet_build_dir" FASTJET_BUILD_DIR="$fastjet_build_dir" $SCRIPTS_DIR/packages/sherpa.sh build_debug
sherpa_build_dir="$BUILD_DIR/sherpa-2.2.8-debug"

