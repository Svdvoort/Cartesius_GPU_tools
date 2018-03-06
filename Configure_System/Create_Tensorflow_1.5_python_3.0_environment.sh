#!/bin/bash

# Specificy the directory of your code (Assumed to be in Home folder)
code_dir_name=Example_Dir
# Specify the name you want for the virtual environment
vir_env_name=Example

# Change directory to the code folder
cd $HOME/$code_dir_name
# Need to load python 2.7.9 as it has the virtualenv command, other python
# versions do not have this
module load python/2.7.9
virtualenv --system-site-packages --python=/hpc/sw/python-3.5.2/bin/python3.5  $vir_env_name
module unload python/2.7.9


# But actually we will use python 2.7.11
module load python/3.5.2
# Install the required packages
source $HOME/$code_dir_name/$vir_env_name/bin/activate
pip install -I -r requirements.txt

# Uninstall the tensorflow from requirements, install specific optimized
# version
pip uninstall -y tensorflow
pip install --upgrade https://github.com/mind/wheels/releases/download/tf1.5-gpu/tensorflow-1.5.0-cp27-cp27mu-linux_x86_64.whl



