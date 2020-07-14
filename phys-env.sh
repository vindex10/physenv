DEBUG=${DEBUG:-false}

root_build_dir="$BUILD_DIR/root-6-20-06"
hepmc3_build_dir="$BUILD_DIR/hepmc3-3.2.2"
lhapdf6_build_dir="$BUILD_DIR/lhapdf6-6.2.3"
pythia8_build_dir="$BUILD_DIR/pythia8-8244"
yoda_build_dir="$BUILD_DIR/yoda-1.8.2"
fastjet_build_dir="$BUILD_DIR/fastjet-3.3.4"
openloops2_build_dir="$BUILD_DIR/openloops2-2.1.1"
rivet_build_dir="$BUILD_DIR/rivet-3.1.1"
if [ $DEBUG = "true" ]; then
    sherpa_build_dir="$BUILD_DIR/sherpa-2.2.10-debug"
else
    sherpa_build_dir="$BUILD_DIR/sherpa-2.2.10"
fi;

export PYTHONPATH="$sherpa_build_dir/lib64/python3.6/site-packages/ufo_interface:$sherpa_build_dir/lib64/python3.6/site-packages/:$PYTHONPATH"

export LD_LIBRARY_PATH="$root_build_dir/lib:$hepmc3_build_dir/lib:$hepmc3_build_dir/lib64:$lhapdf6_build_dir/lib:$pythia8_build_dir/lib:$yoda_build_dir/lib:$fastjet_build_dir/lib:$rivet_build_dir/lib:$openloops2_build_dir/lib:$sherpa_build_dir/lib/SHERPA-MC:$LD_LIBDRARY_PATH"

export PATH="$root_build_dir/bin:$hepmc3_build_dir/bin:$lhapdf6_build_dir/bin:$pythia8_build_dir/bin:$yoda_build_dir/bin:$fastjet_build_dir/bin:$rivet_build_dir/bin:$sherpa_build_dir/bin:$PATH"



