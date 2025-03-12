#! /bin/bash

user=daniel
compileCores=3

echo -e "\n\n\n-----------------------------------"
echo "Start up script beginning execution"
echo -e "-----------------------------------\n\n\n"


################################################################################
############ Git, other command line utilities ############################
################################################################################
echo -e "\n\n\n--------------------------------------------------------------------------"
echo "Start apt-get and apt install"
echo -e "--------------------------------------------------------------------------\n\n\n"
# Let's make sure any services needing restarting after any apt update, upgrade or installs 
# are restarted automatically. This will also prevent the pink box appearing when you are 
# runnin the script manually.
sed  -i "s/.*$nrconf{restart}.*/\$nrconf{restart} = 'l';/g" /etc/needrestart/needrestart.conf

apt update           --assume-yes
apt-get upgrade      --assume-yes
apt install -y vim tmux tree git ca-certificates curl unzip gnupg  make wget gpg-agent curl gcc \
    build-essential libtbb-dev cmake cmake-curses-gui libopenmpi-dev openmpi-bin libfftw3-dev \
    libblas-dev liblapack-dev pkg-config ffmpeg python3-dev python3-pip python3.10-venv python3-venv \
    --assume-yes 

apt update

################################################################################
######## Intel compiler for C,C++ and fortran with deeplearning add-ons ########
################################################################################
echo -e "\n\n\n--------------------------------------------------------------------------"
echo "Intel compiler download and installation"
echo -e "--------------------------------------------------------------------------\n\n\n"
# Installation instructions from: 
# https://www.intel.com/content/www/us/en/developer/tools/oneapi/hpc-toolkit-download.html?packages=hpc-toolkit&hpc-toolkit-os=linux&hpc-toolkit-lin=apt

su - $user -s /bin/bash <<EOF
wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
| gpg --dearmor | sudo tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null


echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" \
	| sudo tee /etc/apt/sources.list.d/oneAPI.list

sudo apt update
sudo apt install intel-oneapi-hpc-toolkit --assume-yes
EOF

echo 'source /opt/intel/oneapi/setvars.sh'                                              >> /home/${user}/.bashrc
echo 'export PATH=/opt/intel/oneapi/mkl/2024.0:$PATH'                                   >> /home/${user}/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/intel/oneapi/mkl/2024.0/lib/intel64:$LD_LIBRARY_PATH' >> /home/${user}/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/intel/oneapi/compiler/2024.0/lib:$LD_LIBRARY_PATH'    >> /home/${user}/.bashrc

source /opt/intel/oneapi/setvars.sh

################################################################################
######## Clone this repo to the VM and compile the preproc codes ###############
################################################################################
echo -e "\n\n\n--------------------------------------------------------------------------"
echo "Clone InGaN repo and compile codes"
echo -e "--------------------------------------------------------------------------\n\n\n"
#git clone git@github.com:DSP-Tan/InGaN_BiBuklMonoLayer.git /home/${user}/InGaN
git clone https://github.com/DSP-Tan/InGaN_BiBuklMonoLayer.git /home/${user}/InGaN

################################################################################
######## Stable lammps installation using intel compiler  ######################
################################################################################
echo -e "\n\n\n--------------------------------------------------------------------------"
echo "Lammps download and installation"
echo -e "--------------------------------------------------------------------------\n\n\n"

git clone -b stable_29Aug2024 --depth 1 https://github.com/lammps/lammps.git /home/${user}/lammps_intel

## Make modifications to bond_class2 in order to implement III-N wurtzite potential's linear term
cd /home/${user}/lammps_intel/src
git apply /home/${user}/InGaN/infrastructure/lammpsClass2.patch
echo -e "\n\n\n--------------------------------------------------------------------------"
echo "The following diff has been applied to the lammps repo:"
git diff
echo -e "--------------------------------------------------------------------------\n\n\n"

cd /home/${user}/lammps_intel
mkdir -p build
cd       build

echo -e "\n\n\n\n"
echo "Running cmake command"
echo -e "\n\n\n\n"

cd /home/${user}/lammps_intel/build
cmake \
        -D PKG_PYTHON=ON   \
        -D PKG_OPENMP=ON   \
        -D PKG_CLASS2=ON   \
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

make -j $compileCores     # using all the cores can tend to crash
make install
mv lmp lmp_intel

chown -R $user /home/${user}/
echo 'export PATH=/home/'${user}'/lammps_intel/build:$PATH'     >> /home/${user}/.bashrc


# Note, to run these newer versions of lammps you must execute like this: 
# export OMP_NUM_THREADS=8
# mpirun -np 8 lmp -in ../in.pppm
# and in in.pppm, you must modify the line:
# dump_modify 1 format "%6d %11.6lf %11.6lf %11.6lf"
# to:
# dump_modify 1 format line "%6d %11.6lf %11.6lf %11.6lf"
# by just adding the keyword line.

# echo 'export PATH=:$PATH' >> ~/.bashrc
