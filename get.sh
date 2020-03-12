#!/bin/bash

SCRIPTS_DIR=${SCRIPTS_DIR:-"`dirname $0`"}

$(SCRIPTS_DIR)/packages/root.sh get
$(SCRIPTS_DIR)/packages/hepmc3.sh get
$(SCRIPTS_DIR)/packages/lhapdf6.sh get
$(SCRIPTS_DIR)/packages/pythia8.sh get
$(SCRIPTS_DIR)/packages/yoda.sh get
$(SCRIPTS_DIR)/packages/fastjet.sh get
$(SCRIPTS_DIR)/packages/fastjet-contrib.sh get
$(SCRIPTS_DIR)/packages/rivet.sh get
$(SCRIPTS_DIR)/packages/sherpa.sh get
