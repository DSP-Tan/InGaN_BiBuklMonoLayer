
git clone -b stable_29Aug2024 --depth 1 https://github.com/lammps/lammps.git ~/lammps_intel

cd ~/lammps_intel
mkdir -p build
cd       build

echo -e "\n\n\n\n"
echo "Running cmake command"
echo -e "\n\n\n\n"
source ~/.bashrc

cmake \
        -D PKG_PYTHON=ON \
        -D PKG_OPENMP=ON \
        -D PKG_CLASS2=ON \
        -D PKG_MOLECULE=ON \
        -D PKG_KSPACE=ON \
        -D BUILD_SHARED_LIBS=ON \
        -D PKG_INTEL=ON \
        -DCMAKE_C_COMPILER=icx \
        -DCMAKE_CXX_COMPILER=/opt/intel/oneapi/compiler/latest/bin/icpx \
        -DCMAKE_EXE_LINKER_FLAGS="-ltbbmalloc -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core" \
        -DCMAKE_CXX_FLAGS="-xHost -O2 -fp-model=fast -ansi-alias -qopenmp" \
        -DCMAKE_SHARED_LINKER_FLAGS="-L/opt/intel/oneapi/mkl/2024.0/lib" \
../cmake

make -j 3      # using all the cores can tend to crash
make install
mv lmp lmp_intel
