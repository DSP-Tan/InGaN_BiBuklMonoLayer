# Step-by-Step Guide to Install the Intel oneAPI Base Toolkit Using apt-get
First, add the Intel oneAPI repository to your system. Open a terminal and run the following commands:
```bash
sudo apt-get update
sudo apt-get install wget
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB
sudo sh -c 'echo deb https://apt.repos.intel.com/oneapi all main > /etc/apt/sources.list.d/oneAPI.list'
```

## Update the package list: 
After adding the repository, update your package list to include the new repository:

```bash
sudo apt-get update
```
## Install the Intel oneAPI Base Toolkit 
Install the intel-basekit package:
```bash
sudo apt-get install intel-basekit --assume-yes
```
## Set up the environment 
After installation, set up the environment to use the Intel oneAPI tools. Source the setup script provided by the installation:
```bash
source /opt/intel/oneapi/setvars.sh
```
To set up the environment automatically every time you open a terminal, add the following line to your ~/.bashrc file:
```bash
echo 'source /opt/intel/oneapi/setvars.sh' >> ~/.bashrc
source ~/.bashrc
```
## Verify the installation 
To verify that the Intel C++ Compiler is installed and set up correctly, check its version:
```bash
icx --version
```
This should display the version of the Intel C++ Compiler.

Additional Tips
Check for updates: Intel frequently updates their tools. You can check for updates by running:
sudo apt-get update
sudo apt-get upgrade
Documentation and support: For more detailed information and troubleshooting, refer to the Intel oneAPI documentation and the Intel Developer Zone.o



## Step-by-Step Guide to Install the Intel oneAPI Base Toolkit Using `apt-get`

### 1. Add the Intel oneAPI Repository

First, add the Intel oneAPI repository to your system. Open a terminal and run the following commands:

```sh
sudo apt-get update
sudo apt-get install wget
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB
sudo sh -c 'echo deb https://apt.repos.intel.com/oneapi all main > /etc/apt/sources.list.d/oneAPI.list'

sudo apt-get update

sudo apt-get install intel-basekit

source /opt/intel/oneapi/setvars.sh

echo 'source /opt/intel/oneapi/setvars.sh' >> ~/.bashrc
source ~/.bashrc

icx --version
```
