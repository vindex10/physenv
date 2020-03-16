root_build_dir="$BUILD_DIR/root-6-20-00"
hepmc_build_dir="$BUILD_DIR/hepmc-02_06_10"
lhapdf6_build_dir="$BUILD_DIR/lhapdf6-6.2.3"
pythia8_build_dir="$BUILD_DIR/pythia8-8244"
yoda_build_dir="$BUILD_DIR/yoda-1.8.0"
fastjet_build_dir="$BUILD_DIR/fastjet-3.3.3"
rivet_build_dir="$BUILD_DIR/rivet-2.7.2"
sherpa_build_dir="$BUILD_DIR/sherpa-2.2.8"
sherpa_debug_build_dir="$BUILD_DIR/sherpa-2.2.8-debug"

export LD_LIBDRARY_PATH="$root_build_dir/lib:$hepmc_build_dir/lib:$lhapdf6_build_dir/lib:$pythia8_build_dir/lib:$yoda_build_dir/lib:$fastjet_build_dir/lib:$rivet_build_dir/lib:$sherpa_debug_build_dir/lib/SHERPA-MC:$LD_LIBDRARY_PATH"

export PATH="$root_build_dir/bin:$hepmc_build_dir/bin:$lhapdf6_build_dir/vin:$pythia8_build_dir/bin:$yoda_build_dir/bin:$fastjet_build_dir/bin:$rivet_build_dir/bin:$sherpa_debug_build_dir/bin:$PATH"



