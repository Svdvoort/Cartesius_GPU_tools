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
virtualenv --system-site-packages $vir_env_name

# But actually we will use python 2.7.11
module load python/2.7.11
# Install the required packages
source $HOME/$Code_dir_name/$vir_env_name/bin/activate
pip install -I -r requirements.txt

# Uninstall the tensorflow from requirements, install specific optimized
# version
pip uninstall -y tensorflow
pip install --upgrade tensorflow
pip install --upgrade tensorflow-gpu



