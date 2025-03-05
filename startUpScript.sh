#! /bin/bash

user=daniel
GH_USER=DSP-Tan
GITHUB_USER=DSP-Tan
gcsKeyBucket=bigmoney-course-data

echo -e "\n\n\n"
echo -e "-----------------------------------"
echo "Start up script beginning execution"
echo -e "-----------------------------------"
echo -e "\n\n\n"


# Note all changes to zshrc must be made after install.sh is run, as this overwrites the
# file.

################################################################################
############ Git, other command line utilities ############################
################################################################################
echo "Git, other command line utilities"

apt update
sudo apt-get upgrade
apt install -y vim tmux tree git ca-certificates curl jq unzip gnupg  make wget curl gcc \
build-essential libtbb-dev cmake cmake-curses-gui libopenmpi-dev openmpi-bin libfftw3-dev \
libblas-dev liblapack-dev pkg-config ffmpeg python3-dev

sudo apt-get install python3-pip python3.10-venv python3-venv


wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB
sudo sh -c 'echo deb https://apt.repos.intel.com/oneapi all main > /etc/apt/sources.list.d/oneAPI.list'

sudo apt-get update
sudo apt-get install intel-basekit --assume-yes

echo 'source /opt/intel/oneapi/setvars.sh' >> ~/.bashrc
echo 'export PATH=/opt/intel/oneapi/mkl/2024.0:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/intel/oneapi/mkl/2024.0/lib/intel64:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/intel/oneapi/compiler/2024.0/lib:$LD_LIBRARY_PATH' >> ~/.bashrc

source ~/.bashrc

git clone -b stable_29Aug2024 https://github.com/lammps/lammps.git lammps_intel

chown -R daniel lammps_intel
cd lammps_intel
mkdir build
cd build

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

#make -j 4      # using all the cores can tend to crash
#make install
#mv lmp lmp_intel

# Note, to run these newer versions of lammps you must execute like this: 
# export OMP_NUM_THREADS=8
# mpirun -np 8 lmp -in ../in.pppm
# and in in.pppm, you must modify the line:
# dump_modify 1 format "%6d %11.6lf %11.6lf %11.6lf"
# to:
# dump_modify 1 format line "%6d %11.6lf %11.6lf %11.6lf"
# by just adding the keyword line.

# echo 'export PATH=:$PATH' >> ~/.bashrc

################################################################################
############ Github access key #################################################
################################################################################

# printf "\n\n\n\n"
# printf "\n\n\n\n"
# echo "Setting up github key"
# printf "\n\n\n\n"
# printf "\n\n\n\n"
# 
# # You must create an ssh public key, and add it to your github account. The private
# # key must then be available on gcs.
# 
# su - daniel -s /bin/bash <<EOF
# mkdir -p /home/daniel/.ssh/
# mkdir -p /home/daniel/code/$GH_USER
# 
# gsutil cp gs://${gcsKeyBucket}/gitHubKey     ~/.ssh/
# gsutil cp gs://${gcsKeyBucket}/gitHubKey.pub ~/.ssh/
# chmod 400 ~/.ssh/gitHubKey*
# 
# ssh-keyscan github.com >> ~/.ssh/known_hosts
# GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no -i ~/.ssh/gitHubKey" git clone git@github.com:$GH_USER/dotfiles.git code/$GH_USER/dotfiles
# cd ~/code/$GH_USER/dotfiles && ./install.sh
# EOF
# 
# printf "\n\n\n\n"
# printf "\n\n\n\n"
# 
# 
# ################################################################################
# ############ Github CLI ########################################################
# ################################################################################
# echo "Github CLI installation"
# 
# curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
# | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
# apt update
# apt install -y gh
