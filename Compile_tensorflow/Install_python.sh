#!/bin/bash
gcc_version=5.2.0
python_version=3.6.7
temp_dir=/home/vandervo/temp_packages/python
out_folder=/home/vandervo/packages/python/${python_version}

# This fix is needed since some Python versions do not find the openssl
# library otherwise, and thus can't use pip
#apt-get install -y libffi-dev libssl-dev zlib1g-dev graphviz graphviz-dev
#apt-get install -y build-essential python-dev libssl-dev libncurses*-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev

module purge
module load gcc/${gcc_version}


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Make folder to store temporary files and get source
mkdir -p ${temp_dir}


cd ${temp_dir}
wget https://www.python.org/ftp/python/"${python_version}"/Python-"${python_version}".tgz
tar -xzf Python-"${python_version}".tgz
cd Python-"${python_version}"

# Configure with the Module folder as target folder
mkdir -p ${out_folder}
./configure --prefix=${out_folder} --enable-optimizations
make -j8
make install


curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

python_version_elements=(${python_version//./ })
short_python_version="${python_version_elements[0]}.${python_version_elements[1]}"

${out_folder}/bin/python${short_python_version} get-pip.py

# Install virtualenv so users can install their own packages
${out_folder}/bin/pip${short_python_version} install virtualenv

# Clean-up
rm -R ${temp_dir}
