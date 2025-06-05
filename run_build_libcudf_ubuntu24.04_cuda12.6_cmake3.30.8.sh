#!/bin/bash
set -e # When Error occurs, stop immediately 

# Install build tools
cd
sudo apt update && sudo apt -y upgrade
sudo apt -y install build-essential libssl-dev libz-dev

## cmake
## Reference: https://gist.github.com/UbuntuEvangelist/afd13e6fba7ffc5dbf7c5da31b55dff6
cd
wget https://cmake.org/files/v3.30/cmake-3.30.8.tar.gz
tar -xzvf cmake-3.30.8.tar.gz
cd cmake-3.30.8
./bootstrap
make -j$(nproc)
sudo make install
cmake --version

## CUDA Toolkit 12.6
## Reference: https://developer.nvidia.com/cuda-12-6-0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local
cd
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.6.0/local_installers/cuda-repo-wsl-ubuntu-12-6-local_12.6.0-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-12-6-local_12.6.0-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-6
# Add cuda library path for system
echo "/usr/local/cuda/lib64" | sudo tee /etc/ld.so.conf.d/cuda.conf
sudo ldconfig
# Add nvcc path 
export PATH=/usr/local/cuda/bin:$PATH
# Add nvcc path to .bashrc
# grep -qxF 'export PATH=/usr/local/cuda/bin:$PATH' ~/.bashrc || echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc

# Build libcudf
cd
mkdir -p git
cd git
REPO_URL="https://github.com/rapidsai/cudf.git"
TARGET_DIR="cudf"
rm -rf "$TARGET_DIR"
git clone "$REPO_URL" "$TARGET_DIR"
cd "$TARGET_DIR"
INSTALL_PREFIX=$HOME/local/rapids ./build.sh libcudf
# Add library path (Need to be added to .bashrc if you need)
export LD_LIBRARY_PATH=$HOME/local/rapids/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$HOME/local/rapids/lib/pkgconfig:$PKG_CONFIG_PATH
