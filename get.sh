#!/bin/bash

SCRIPTS_DIR=${SCRIPTS_DIR:-"`dirname $0`"}
export BUILD_DIR="`pwd`/build"
export SRC="`pwd`/src"

${SCRIPTS_DIR}/packages/root.sh get
${SCRIPTS_DIR}/packages/hepmc.sh get
${SCRIPTS_DIR}/packages/lhapdf6.sh get
${SCRIPTS_DIR}/packages/pythia8.sh get
${SCRIPTS_DIR}/packages/yoda.sh get
${SCRIPTS_DIR}/packages/fastjet.sh get
${SCRIPTS_DIR}/packages/fastjet-contrib.sh get
${SCRIPTS_DIR}/packages/rivet.sh get
${SCRIPTS_DIR}/packages/openloops2.sh get
${SCRIPTS_DIR}/packages/sherpa.sh get
