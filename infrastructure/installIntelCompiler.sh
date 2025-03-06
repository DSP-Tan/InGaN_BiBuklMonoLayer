# Intel compiler installation from: 
# https://www.intel.com/content/www/us/en/developer/tools/oneapi/hpc-toolkit-download.html?packages=hpc-toolkit&hpc-toolkit-os=linux&hpc-toolkit-lin=apt
# download the key to system keyring

wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
| gpg --dearmor | sudo tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null


echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" \
	| sudo tee /etc/apt/sources.list.d/oneAPI.list

sudo apt update
sudo apt install intel-oneapi-hpc-toolkit --assume-yes

echo 'source /opt/intel/oneapi/setvars.sh'                                              >> ~/.bashrc
echo 'export PATH=/opt/intel/oneapi/mkl/2024.0:$PATH'                                   >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/intel/oneapi/mkl/2024.0/lib/intel64:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/intel/oneapi/compiler/2024.0/lib:$LD_LIBRARY_PATH'    >> ~/.bashrc


# Intell basekit installation - Does not have fortran compiler
# wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB
# sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB
# sudo sh -c 'echo deb https://apt.repos.intel.com/oneapi all main > /etc/apt/sources.list.d/oneAPI.list'
# 
# sudo apt-get update
# sudo apt-get install intel-basekit --assume-yes