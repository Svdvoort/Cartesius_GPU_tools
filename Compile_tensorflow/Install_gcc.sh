#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
gcc_version=7.3.0

# Install prerequisites

#apt-get install -y gcc-multilib g++-multilib libc6:i386 libstdc++6:i386 libc6-dev:i386

# Install GCC version
# Create an installation directorie
install_dir=/home/vandervo/packages/gcc/${gcc_version}
temp_dir=/home/vandervo/temp_packages/gcc-${gcc_version}
mkdir -p ${install_dir}
mkdir -p ${temp_dir}
cd ${temp_dir}

# Download source binaries
source_url="ftp://ftp.nluug.nl/mirror/languages/gcc/releases/gcc-${gcc_version}/gcc-${gcc_version}.tar.gz"
wget ${source_url}

# Unpack the binaries
mkdir -p ${temp_dir}/src
tar -xzf "gcc-${gcc_version}.tar.gz" -C src
cd src/gcc-${gcc_version}
./contrib/download_prerequisites

# Install according to official instructions:https://gcc.gnu.org/install/
cd ../..
src/gcc-${gcc_version}/configure --prefix=${install_dir} --disable-multilib
make -j 4
make install
