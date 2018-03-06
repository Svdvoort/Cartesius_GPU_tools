#!/bin/bash

# Specificy the directory of your code (Assumed to be in Home folder)
code_dir_name=Example_dir
# Specify the name you want for the virtual environment
vir_env_name=Example

# Change directory to the code folder
cd $HOME/$code_dir_name

# Need to load python 2.7.9 as it has the virtualenv command, other python
# versions do not have this
module purge
module load python/2.7.9
virtualenv --python=/hpc/sw/python-3.5.2/ --no-site-packages $vir_env_name

module unload python/2.7.9
module load python/3.5.2

# But actually we will use python 2.7.11
# Install the required packages
source $HOME/$code_dir_name/$vir_env_name/bin/activate

pip install -I -r --user requirements.txt
pip install -I --upgrade --user tensorflow
pip install -I --upgrade --user tensorflow-gpu

